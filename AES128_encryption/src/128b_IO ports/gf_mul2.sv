`timescale 1ns / 1ps
// ----------------------------------------------------------------------
// Copyright 
// 
// 
//
// ----------------------------------------------------------------------
//----------------------------------------------------------------------------
// Filename:			gf_mul2.sv
// Version:				1.00
// Description:	
//
//
// Author:              A. MAHANI
// History:				
//-----------------------------------------------------------------------------

module gf_mul2 (
                input   logic [7:0]    di,
                output  logic [7:0]    do1);

//GF(2) multiplication with "x^8 + x^4 + x^3 + x + 1" reduction polynimial

    
assign do1 = {di[6:0], 1'b0} ^ (8'h1b & {8{di[7]}});

endmodule : gf_mul2