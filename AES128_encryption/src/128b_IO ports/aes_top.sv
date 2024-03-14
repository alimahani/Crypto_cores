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
            input    logic    CLK,
		    input    logic    RST,
		    input    logic    start,
		    input    logic    [127:0] key,
		    input    logic    [127:0] di,
		    output   logic    [127:0] do1,
		    output   logic    done);

		logic    [127:0] di_start;
		logic    [127:0] key_start;
    	logic [127:0]            rnd_key;
		logic [3:0]                  rnd;
		logic [127:0]        i_addrndkey;
		logic [127:0]          i_subbyte;
        logic [127:0]         i_shiftrow;
        logic [127:0]             stage1;
		logic [127:0]           i_mixcol;
        logic [127:0]             stage2;        
        
    typedef enum logic [1:0] {
                                      s0,
                        subbyte_shiftrow,
                        mixcol_addrndkey,
                        s_last   } State;

        State       current_state;


always @(posedge CLK)
begin
    if(RST)
    begin
        do1                   <= 1'b0;
        i_addrndkey          <= 1'b0;
 //       i_subbyte            <= 1'b0;
 //       i_shiftrow           <= 1'b0;
 //       i_mixcol             <= 1'b0;
        rnd                  <= 1'b0;
        done                 <= 1'b0;
    end

    else
    begin
        case(current_state)
        

            s0:
            begin
                di_start              <= key ^ di      ;
                key_start             <= key     ;
                rnd                   <= rnd + start;
                done                  <= 1'b0;
                current_state         <= (start ? subbyte_shiftrow : s0);
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



aes_subbyte   subbyte (
    .di(di_start),
    .do1(i_subbyte)
);

aes_shiftrow  shiftrow(
    .di(i_subbyte),
    .do1(i_shiftrow)
);

// shiftRows sr(.in(i_subbyte), 
		   // .shifted(i_shiftrow));

aes_mxcol    mixcol(
    .di(stage1),
    .do1(i_mixcol)
);

// mixColumns mc(.state_in(stage1),.state_out(i_mixcol));

aes_keyexp    keyexp(

    .rnd(rnd),
    .di_key(key_start),
    .do_key(rnd_key)
);



endmodule: aes_top            
