`timescale 1ns / 1ps
// ----------------------------------------------------------------------
// Copyright 
// 
// 
//
// ----------------------------------------------------------------------
//----------------------------------------------------------------------------
// Filename:			aes_keyexp.sv
// Version:				1.00
// Description:	
//
//
// Author:              A. MAHANI
// History:				
//-----------------------------------------------------------------------------


module aes_keyexp(
                   input  logic [3:0]   rnd,
		           input  logic [127:0] di_key,
		           output logic [127:0] do_key);
		    
		    
		    logic   [31:0] rot_w ;
		    logic   [31:0] sbox_w;
            logic   [31:0] xor_w0, xor_w1, xor_w2, xor_w3 ;
		    logic   [31:0] rcon  ;		    
		    
		    
            assign rot_w = {di_key[23:0], di_key[31:24]};

            genvar i;
                     generate
                         for (i=0; i<4; i=i+1)
                         begin
                             aes_sboxb key_sbox(
                                 .di(rot_w[8*i +: 8]),
                                 .do2(sbox_w[8*i +: 8])
                             );
                         end
                     endgenerate

			always @ (*)
				begin
                case (rnd)
                        4'd1 : rcon = 32'h01000000;
                        4'd2 : rcon = 32'h02000000;
                        4'd3 : rcon = 32'h04000000;
                        4'd4 : rcon = 32'h08000000;
                        4'd5 : rcon = 32'h10000000;
                        4'd6 : rcon = 32'h20000000;
                        4'd7 : rcon = 32'h40000000;
                        4'd8 : rcon = 32'h80000000;
                        4'd9 : rcon = 32'h1b000000;
                        4'd10: rcon = 32'h36000000;
                    endcase 
				end

		    assign xor_w3 = di_key[127:96] ^ sbox_w ^ rcon;
            assign xor_w2 = di_key[95:64]  ^ xor_w3;
            assign xor_w1 = di_key[63:32]  ^ xor_w2;
            assign xor_w0 = di_key[31:0]   ^ xor_w1;

            assign do_key = { xor_w3, xor_w2, xor_w1, xor_w0 };

		    			
endmodule : aes_keyexp