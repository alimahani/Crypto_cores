`timescale 1ns / 1ps
// ----------------------------------------------------------------------
// Copyright 
// 
// 
//
// ----------------------------------------------------------------------
//----------------------------------------------------------------------------
// Filename:			present_sbox.sv
// Version:				1.00
// Description:	
//
//
// Author:              A. MAHANI
// History:				
//-----------------------------------------------------------------------------


module present_sbox (
    input  logic [3:0] din,
    output logic [3:0] dout );

always_comb begin
        case (din) 
            4'd0  : dout = 4'hC;
            4'd1  : dout = 4'h5;
            4'd2  : dout = 4'h6;
            4'd3  : dout = 4'hB;
            4'd4  : dout = 4'h9;
            4'd5  : dout = 4'h0;
            4'd6  : dout = 4'hA;
            4'd7  : dout = 4'hD;
            4'd8  : dout = 4'h3;
            4'd9  : dout = 4'hE;
            4'd10 : dout = 4'hF;
            4'd11 : dout = 4'h8;
            4'd12 : dout = 4'h4;
            4'd13 : dout = 4'h7;
            4'd14 : dout = 4'h1;
            4'd15 : dout = 4'h2;
    endcase
    end

endmodule
