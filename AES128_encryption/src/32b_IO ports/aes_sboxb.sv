`timescale 1ns / 1ps
// ----------------------------------------------------------------------
// Copyright 
// 
// 
//
// ----------------------------------------------------------------------
//----------------------------------------------------------------------------
// Filename:			aes_sbox.sv
// Version:				1.00
// Description:	
//
//
// Author:              A. MAHANI
// History:				
//-----------------------------------------------------------------------------

module aes_sboxb (
	input logic  [7:0]   di,
	output logic [7:0]   do2);

	logic[7:0] do1;

// --------------------------------------------------------------------------
// LUT SBox
// --------------------------------------------------------------------------
		always @ (*)
			begin
			 case(di)
				8'h00 : do1 = 8'h63;
				8'h01 : do1 = 8'h7C;
				8'h02 : do1 = 8'h77;
				8'h03 : do1 = 8'h7B;
				8'h04 : do1 = 8'hF2;
				8'h05 : do1 = 8'h6B;
				8'h06 : do1 = 8'h6F;
				8'h07 : do1 = 8'hC5;
				8'h08 : do1 = 8'h30;
				8'h09 : do1 = 8'h01;
				8'h0A : do1 = 8'h67;
				8'h0B : do1 = 8'h2B;
				8'h0C : do1 = 8'hFE;
				8'h0D : do1 = 8'hD7;
				8'h0E : do1 = 8'hAB;
				8'h0F : do1 = 8'h76;
				8'h10 : do1 = 8'hCA;
				8'h11 : do1 = 8'h82;
				8'h12 : do1 = 8'hC9;
				8'h13 : do1 = 8'h7D;
				8'h14 : do1 = 8'hFA;
				8'h15 : do1 = 8'h59;
				8'h16 : do1 = 8'h47;
				8'h17 : do1 = 8'hF0;
				8'h18 : do1 = 8'hAD;
				8'h19 : do1 = 8'hD4;
				8'h1A : do1 = 8'hA2;
				8'h1B : do1 = 8'hAF;
				8'h1C : do1 = 8'h9C;
				8'h1D : do1 = 8'hA4;
				8'h1E : do1 = 8'h72;
				8'h1F : do1 = 8'hC0;
				8'h20 : do1 = 8'hB7;
				8'h21 : do1 = 8'hFD;
				8'h22 : do1 = 8'h93;
				8'h23 : do1 = 8'h26;
				8'h24 : do1 = 8'h36;
				8'h25 : do1 = 8'h3F;
				8'h26 : do1 = 8'hF7;
				8'h27 : do1 = 8'hCC;
				8'h28 : do1 = 8'h34;
				8'h29 : do1 = 8'hA5;
				8'h2A : do1 = 8'hE5;
				8'h2B : do1 = 8'hF1;
				8'h2C : do1 = 8'h71;
				8'h2D : do1 = 8'hD8;
				8'h2E : do1 = 8'h31;
				8'h2F : do1 = 8'h15;
				8'h30 : do1 = 8'h04;
				8'h31 : do1 = 8'hC7;
				8'h32 : do1 = 8'h23;
				8'h33 : do1 = 8'hC3;
				8'h34 : do1 = 8'h18;
				8'h35 : do1 = 8'h96;
				8'h36 : do1 = 8'h05;
				8'h37 : do1 = 8'h9A;
				8'h38 : do1 = 8'h07;
				8'h39 : do1 = 8'h12;
				8'h3A : do1 = 8'h80;
				8'h3B : do1 = 8'hE2;
				8'h3C : do1 = 8'hEB;
				8'h3D : do1 = 8'h27;
				8'h3E : do1 = 8'hB2;
				8'h3F : do1 = 8'h75;
				8'h40 : do1 = 8'h09;
				8'h41 : do1 = 8'h83;
				8'h42 : do1 = 8'h2C;
				8'h43 : do1 = 8'h1A;
				8'h44 : do1 = 8'h1B;
				8'h45 : do1 = 8'h6E;
				8'h46 : do1 = 8'h5A;
				8'h47 : do1 = 8'hA0;
				8'h48 : do1 = 8'h52;
				8'h49 : do1 = 8'h3B;
				8'h4A : do1 = 8'hD6;
				8'h4B : do1 = 8'hB3;
				8'h4C : do1 = 8'h29;
				8'h4D : do1 = 8'hE3;
				8'h4E : do1 = 8'h2F;
				8'h4F : do1 = 8'h84;
				8'h50 : do1 = 8'h53;
				8'h51 : do1 = 8'hD1;
				8'h52 : do1 = 8'h00;
				8'h53 : do1 = 8'hED;
				8'h54 : do1 = 8'h20;
				8'h55 : do1 = 8'hFC;
				8'h56 : do1 = 8'hB1;
				8'h57 : do1 = 8'h5B;
				8'h58 : do1 = 8'h6A;
				8'h59 : do1 = 8'hCB;
				8'h5A : do1 = 8'hBE;
				8'h5B : do1 = 8'h39;
				8'h5C : do1 = 8'h4A;
				8'h5D : do1 = 8'h4C;
				8'h5E : do1 = 8'h58;
				8'h5F : do1 = 8'hCF;
				8'h60 : do1 = 8'hD0;
				8'h61 : do1 = 8'hEF;
				8'h62 : do1 = 8'hAA;
				8'h63 : do1 = 8'hFB;
				8'h64 : do1 = 8'h43;
				8'h65 : do1 = 8'h4D;
				8'h66 : do1 = 8'h33;
				8'h67 : do1 = 8'h85;
				8'h68 : do1 = 8'h45;
				8'h69 : do1 = 8'hF9;
				8'h6A : do1 = 8'h02;
				8'h6B : do1 = 8'h7F;
				8'h6C : do1 = 8'h50;
				8'h6D : do1 = 8'h3C;
				8'h6E : do1 = 8'h9F;
				8'h6F : do1 = 8'hA8;
				8'h70 : do1 = 8'h51;
				8'h71 : do1 = 8'hA3;
				8'h72 : do1 = 8'h40;
				8'h73 : do1 = 8'h8F;
				8'h74 : do1 = 8'h92;
				8'h75 : do1 = 8'h9D;
				8'h76 : do1 = 8'h38;
				8'h77 : do1 = 8'hF5;
				8'h78 : do1 = 8'hBC;
				8'h79 : do1 = 8'hB6;
				8'h7A : do1 = 8'hDA;
				8'h7B : do1 = 8'h21;
				8'h7C : do1 = 8'h10;
				8'h7D : do1 = 8'hFF;
				8'h7E : do1 = 8'hF3;
				8'h7F : do1 = 8'hD2;
				8'h80 : do1 = 8'hCD;
				8'h81 : do1 = 8'h0C;
				8'h82 : do1 = 8'h13;
				8'h83 : do1 = 8'hEC;
				8'h84 : do1 = 8'h5F;
				8'h85 : do1 = 8'h97;
				8'h86 : do1 = 8'h44;
				8'h87 : do1 = 8'h17;
				8'h88 : do1 = 8'hC4;
				8'h89 : do1 = 8'hA7;
				8'h8A : do1 = 8'h7E;
				8'h8B : do1 = 8'h3D;
				8'h8C : do1 = 8'h64;
				8'h8D : do1 = 8'h5D;
				8'h8E : do1 = 8'h19;
				8'h8F : do1 = 8'h73;
				8'h90 : do1 = 8'h60;
				8'h91 : do1 = 8'h81;
				8'h92 : do1 = 8'h4F;
				8'h93 : do1 = 8'hDC;
				8'h94 : do1 = 8'h22;
				8'h95 : do1 = 8'h2A;
				8'h96 : do1 = 8'h90;
				8'h97 : do1 = 8'h88;
				8'h98 : do1 = 8'h46;
				8'h99 : do1 = 8'hEE;
				8'h9A : do1 = 8'hB8;
				8'h9B : do1 = 8'h14;
				8'h9C : do1 = 8'hDE;
				8'h9D : do1 = 8'h5E;
				8'h9E : do1 = 8'h0B;
				8'h9F : do1 = 8'hDB;
				8'hA0 : do1 = 8'hE0;
				8'hA1 : do1 = 8'h32;
				8'hA2 : do1 = 8'h3A;
				8'hA3 : do1 = 8'h0A;
				8'hA4 : do1 = 8'h49;
				8'hA5 : do1 = 8'h06;
				8'hA6 : do1 = 8'h24;
				8'hA7 : do1 = 8'h5C;
				8'hA8 : do1 = 8'hC2;
				8'hA9 : do1 = 8'hD3;
				8'hAA : do1 = 8'hAC;
				8'hAB : do1 = 8'h62;
				8'hAC : do1 = 8'h91;
				8'hAD : do1 = 8'h95;
				8'hAE : do1 = 8'hE4;
				8'hAF : do1 = 8'h79;
				8'hB0 : do1 = 8'hE7;
				8'hB1 : do1 = 8'hC8;
				8'hB2 : do1 = 8'h37;
				8'hB3 : do1 = 8'h6D;
				8'hB4 : do1 = 8'h8D;
				8'hB5 : do1 = 8'hD5;
				8'hB6 : do1 = 8'h4E;
				8'hB7 : do1 = 8'hA9;
				8'hB8 : do1 = 8'h6C;
				8'hB9 : do1 = 8'h56;
				8'hBA : do1 = 8'hF4;
				8'hBB : do1 = 8'hEA;
				8'hBC : do1 = 8'h65;
				8'hBD : do1 = 8'h7A;
				8'hBE : do1 = 8'hAE;
				8'hBF : do1 = 8'h08;
				8'hC0 : do1 = 8'hBA;
				8'hC1 : do1 = 8'h78;
				8'hC2 : do1 = 8'h25;
				8'hC3 : do1 = 8'h2E;
				8'hC4 : do1 = 8'h1C;
				8'hC5 : do1 = 8'hA6;
				8'hC6 : do1 = 8'hB4;
				8'hC7 : do1 = 8'hC6;
				8'hC8 : do1 = 8'hE8;
				8'hC9 : do1 = 8'hDD;
				8'hCA : do1 = 8'h74;
				8'hCB : do1 = 8'h1F;
				8'hCC : do1 = 8'h4B;
				8'hCD : do1 = 8'hBD;
				8'hCE : do1 = 8'h8B;
				8'hCF : do1 = 8'h8A;
				8'hD0 : do1 = 8'h70;
				8'hD1 : do1 = 8'h3E;
				8'hD2 : do1 = 8'hB5;
				8'hD3 : do1 = 8'h66;
				8'hD4 : do1 = 8'h48;
				8'hD5 : do1 = 8'h03;
				8'hD6 : do1 = 8'hF6;
				8'hD7 : do1 = 8'h0E;
				8'hD8 : do1 = 8'h61;
				8'hD9 : do1 = 8'h35;
				8'hDA : do1 = 8'h57;
				8'hDB : do1 = 8'hB9;
				8'hDC : do1 = 8'h86;
				8'hDD : do1 = 8'hC1;
				8'hDE : do1 = 8'h1D;
				8'hDF : do1 = 8'h9E;
				8'hE0 : do1 = 8'hE1;
				8'hE1 : do1 = 8'hF8;
				8'hE2 : do1 = 8'h98;
				8'hE3 : do1 = 8'h11;
				8'hE4 : do1 = 8'h69;
				8'hE5 : do1 = 8'hD9;
				8'hE6 : do1 = 8'h8E;
				8'hE7 : do1 = 8'h94;
				8'hE8 : do1 = 8'h9B;
				8'hE9 : do1 = 8'h1E;
				8'hEA : do1 = 8'h87;
				8'hEB : do1 = 8'hE9;
				8'hEC : do1 = 8'hCE;
				8'hED : do1 = 8'h55;
				8'hEE : do1 = 8'h28;
				8'hEF : do1 = 8'hDF;
				8'hF0 : do1 = 8'h8C;
				8'hF1 : do1 = 8'hA1;
				8'hF2 : do1 = 8'h89;
				8'hF3 : do1 = 8'h0D;
				8'hF4 : do1 = 8'hBF;
				8'hF5 : do1 = 8'hE6;
				8'hF6 : do1 = 8'h42;
				8'hF7 : do1 = 8'h68;
				8'hF8 : do1 = 8'h41;
				8'hF9 : do1 = 8'h99;
				8'hFA : do1 = 8'h2D;
				8'hFB : do1 = 8'h0F;
				8'hFC : do1 = 8'hB0;
				8'hFD : do1 = 8'h54;
				8'hFE : do1 = 8'hBB;
				8'hFF : do1 = 8'h16;
			endcase
		end
			
	assign	do2 = do1;


endmodule : aes_sboxb