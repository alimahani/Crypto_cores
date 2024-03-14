`timescale 1ns / 1ps
// ----------------------------------------------------------------------
// Copyright 
// 
// 
//
// ----------------------------------------------------------------------
//----------------------------------------------------------------------------
// Filename:			div.sv
// Version:				1.00
// Description:	
//
//
// Author:              A. MAHANI
// History:				
//-----------------------------------------------------------------------------


module div #(parameter BIT_WIDTH = 32)(
    input  logic           clk,
    input  logic         reset,
    input  logic         start,
    input  logic [BIT_WIDTH-1:0] A,
    input  logic [BIT_WIDTH-1:0] B,
    output logic           done,
    output logic [BIT_WIDTH-1:0] qu,
    output logic [BIT_WIDTH-1:0] Res);
;


    logic [BIT_WIDTH-1:0] dd = 1'b0;
    logic [BIT_WIDTH-1:0] ds = 1'b0;
    logic [BIT_WIDTH-1:0] dq = 1'b0;
    logic [BIT_WIDTH:0] p1   = 1'b0; 
    logic [BIT_WIDTH-1:0] bit_count = 1'b0;
    
    typedef enum logic [1:0] {  idle,
                                diff_s0,
                                diff_s1,
                                exit} state;
     state    current_state = idle;                           
      

    always @(posedge clk)
    begin
    if(reset == 1'b1) begin
         done            <= 1'b0;
         qu              <= 1'b0;
         Res             <= 1'b0;
         bit_count       <= 1'b0;
         current_state   <= idle;
         end
        
         else begin
                  
         case(current_state)  
         
             idle:   begin
                         dd               <= A;
                         ds               <= B;
                         p1               <= 0;
                         bit_count        <= 1'b1;
                         done             <= 1'b0;
                         current_state    <= (start == 1'b1 ? diff_s0 : idle);
                     end
              diff_s0: begin
                          if (dd < ds) begin
                              qu            <= 1'b0;
                              Res           <= dd;
                              done          <= 1'b1;
                              current_state <= idle;
                              end
                           else begin  
                               p1 = ({p1[BIT_WIDTH-2:0],dd[BIT_WIDTH-bit_count]}) - ds;
                               bit_count         <= bit_count + 1'b1;             
                               current_state     <= diff_s1;
                          end
                       end
             diff_s1:   begin
                          dq[BIT_WIDTH - bit_count + 1'b1]        <= !p1[BIT_WIDTH -1]; 
                         
                          if(p1[BIT_WIDTH-1] == 1) begin  
                              p1 = p1 + ds;                                
                         end
                              current_state   <= ((bit_count == BIT_WIDTH + 1'b1) ? exit : diff_s0);
                       end
            exit:  begin
                    qu               <= dq;
                    Res              <= p1;
                    done             <= 1'b1; 
                    bit_count        <= 1'b0;
                    current_state    <= idle;
                   end        
        endcase
        end  
    end 

endmodule