`timescale 1ns / 1ps
// ----------------------------------------------------------------------
// Copyright 
// 
// 
//
// ----------------------------------------------------------------------
//----------------------------------------------------------------------------
// Filename:			aes_top.sv
// Version:				1.00
// Description:	
//
//
// Author:              A. MAHANI
// History:				
//-----------------------------------------------------------------------------


module aes_top(
            input    logic              CLK,
		    input    logic              RST,
		    input    logic            start,
		    input    logic    [31:0]   d_in,
		    output   logic    [31:0]  d_out,
		    output   logic            done);

		logic [127:0]           di_start;
		logic [127:0]          key_start;
    	logic [127:0]            rnd_key;
		logic [3:0]                  rnd;
		logic [127:0]        i_addrndkey;
		logic [127:0]          i_subbyte;
        logic [127:0]         i_shiftrow;
        logic [127:0]             stage1;
		logic [127:0]           i_mixcol;
        logic [127:0]             stage2;
        logic [31:0]         di_32 [3:0];
        logic [31:0]        key_32 [3:0];
		logic [127:0]                 di;     
		logic [127:0]                do1;
		logic [127:0]                key;        		        		   
        logic                  start_enc;        
        logic [2:0]           rx_counter; 
        logic [2:0]           tx_counter;       
        
    typedef enum logic [1:0] {                    //states for encryption
                                      s0,
                        subbyte_shiftrow,
                        mixcol_addrndkey,
                        s_last   } State;

    typedef enum logic [1:0] {                    // rcv states     
                                      rx_idle,
                                     rx_start,
                                       rx_key,
                                        rx_end
                              }rx_state;

    typedef enum logic [1:0] {                    // send ouy states
                                       tx_idle,
                                      tx_start,
                                         tx_end
                              }tx_state;


        State       current_state;
        rx_state              rcv;
        tx_state              xmit;

always @(posedge CLK)                 //receive state machine, which receives 128 plaintext and 128 bit key as 32 bit packets
begin
     if(RST) begin
              rx_counter     <= 1'b0   ;
              rcv            <= rx_idle;
        end
     else  begin
     
     case(rcv) 
      
     rx_idle: begin
     
               rcv             <= start ? rx_start : rx_idle;
               
               start_enc       <= 1'b0;
              end
      
     rx_start: begin                            //receive 128 palintext through 4 packets (each 32 bit)
     
                di_32[rx_counter]                 <= d_in;
                rx_counter                        <= (rx_counter < 2'd3) ? rx_counter + 1'b1 : 1'b0;
                rcv                               <= (rx_counter < 2'd3) ? rx_start : rx_key;                             
               end          
      
     rx_key: begin                               // receive 128 key through 4 packets (each 32 bits) 
     
                key_32[rx_counter]                <= d_in;
                rx_counter                        <= (rx_counter < 2'd3) ? rx_counter + 1'b1 : 1'b0;
                rcv                               <= (rx_counter < 2'd3) ? rx_key : rx_end;                             
               end 
      
     rx_end: begin
     
                rcv                                <= rx_idle;
                di                                 <= {di_32[3], di_32[2], di_32[1], di_32[0]};
                key                                <= {key_32[3], key_32[2], key_32[1], key_32[0]};    
                start_enc                          <= 1'b1;   
               end                        
     endcase
     end
end


always @(posedge CLK)                         //encryption state-machine
begin
    if(RST)
    begin
        do1                  <= 1'b0;
        i_addrndkey          <= 1'b0;
        rnd                  <= 1'b0;
        done                 <= 1'b0;
    end

    else
    begin
        case(current_state)
        

            s0:
            begin
//                di_start              <= key ^ di      ;
//                key_start             <= key     ;
                di_start              <= {key_32[3], key_32[2], key_32[1], key_32[0]} ^ {di_32[3], di_32[2], di_32[1], di_32[0]}      ;
                key_start             <= {key_32[3], key_32[2], key_32[1], key_32[0]}     ;                
                rnd                   <= rnd + start_enc;
                done                  <= 1'b0;
                current_state         <= (start_enc ? subbyte_shiftrow : s0);
            end

            subbyte_shiftrow:
            begin
                stage1                <= i_shiftrow;
                current_state         <= mixcol_addrndkey;
            end

            mixcol_addrndkey:
            begin
                stage2                <= (rnd < 4'd10 ? i_mixcol ^ rnd_key : i_shiftrow ^ rnd_key);
                di_start              <= i_mixcol ^ rnd_key;
                key_start             <= rnd_key;
                rnd                   <= (rnd < 4'd10 ? rnd + 1'b1 : 1'b0);
                current_state         <= (rnd < 4'd10 ? subbyte_shiftrow : s_last);
            end

            s_last:
            begin
                do1                    <= stage2;
                current_state          <= s0;
                done                   <= 1'b1;
            end
			default: current_state <= s0;

        endcase
    end
end

always @(posedge CLK)             //tx state machine, send out the 128 bit ciphertext through 32 bit packets
begin
     if(RST)  begin 
     
              xmit            <= tx_idle;
              tx_counter      <= 1'b0;
              end 
     else  begin
     
     case(xmit) 
      
     tx_idle: begin
     
               xmit             <= done ? tx_start : tx_idle;
              end
      
     tx_start: begin
     
//                d_out                              <= do1[tx_counter * 6'd32 +:32];
                tx_counter                         <= (tx_counter < 2'd3) ? tx_counter + 1'b1 : 1'b0;
                xmit                               <= (tx_counter < 2'd3) ? tx_start : tx_end;
                case(tx_counter)
                     3'd0: begin
                           d_out                   <= do1[31:0];     
                          end
                     3'd1: begin
                           d_out                   <= do1[63:32];                          
                          end
                     3'd2: begin
                            d_out                   <= do1[95:64];                          
                          end
                     3'd3: begin
                            d_out                   <= do1[127:96];                          
                          end               
                endcase                        
               end          
      
     tx_end: begin
     
                xmit                               <= tx_idle;
               end                        
     endcase
     end
end





aes_subbyte   subbyte (
    .di(di_start),
    .do1(i_subbyte)
);

aes_shiftrow  shiftrow(
    .di(i_subbyte),
    .do1(i_shiftrow)
);

aes_mxcol    mixcol(
    .di(stage1),
    .do1(i_mixcol)
);

aes_keyexp    keyexp(

    .rnd(rnd),
    .di_key(key_start),
    .do_key(rnd_key)
);



endmodule: aes_top            
