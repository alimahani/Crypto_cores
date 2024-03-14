`timescale 1ns / 1ps
// ----------------------------------------------------------------------
// Copyright 
// 
// 
//
// ----------------------------------------------------------------------
//----------------------------------------------------------------------------
// Filename:			aes_subbyte.sv
// Version:				1.00
// Description:	
//
//
// Author:              A. MAHANI
// History:				
//-----------------------------------------------------------------------------

module aes_subbyte(
    input   logic   [127:0] di,
    output  logic   [127:0] do1);


//for subbyte module with 4*32 bit (128 bit) input, we need 16 aes_sboxb

genvar s;
generate
    for (s=0; s<16; s=s+1)
    begin
        aes_sboxb sboxb(
            .di(di[8*s +: 8]),
            .do2(do1[8*s +: 8])
        );
    end
endgenerate

endmodule : aes_subbyte