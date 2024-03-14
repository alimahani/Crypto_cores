`timescale 1ns / 1ps
// ----------------------------------------------------------------------
// Copyright 
// 
// 
//
// ----------------------------------------------------------------------
//----------------------------------------------------------------------------
// Filename:			aes_maxcol.sv
// Version:				1.00
// Description:	
//
//
// Author:              A. MAHANI
// History:				
//-----------------------------------------------------------------------------


module aes_mxcol(
               input   logic [127:0] di,
               output  logic [127:0] do1);

 
   wire  [31:0] 	col [3:0];
   logic [31:0] 	mx  [3:0];
genvar i;
generate  
for(i = 0; i < 4; i = i+1)
begin
    assign col[i]  = di[32*i +: 32] ;
end
endgenerate
 
genvar j;
generate

    for(j=0; j<4; j = j+1)
    begin
        col_op col_op0(
            .di(col[j]),
            .do1(mx[j])
        );
    end
endgenerate

   assign do1 = {mx[3], mx[2], mx[1], mx[0]};

endmodule : aes_mxcol


module col_op (
                 input   logic   [31:0] di,
                 output  logic   [31:0] do1); 

wire    [7:0]     b0,b1,b2,b3;
logic   [7:0]     mx [7:0];
wire    [7:0]     s0,s1,s2,s3;

assign     b0 = di[7:0];  
assign     b1 = di[15:8];  
assign     b2 = di[23:16];  
assign     b3 = di[31:24];  

genvar i;
generate
    for(i=0; i<4; i=i+1)
    begin
   gf_mul2 m2_rw0(
                 .di(di[8*i +: 8]),
	             .do1(mx[i]));

   gf_mul3 m3_rw0(
                 .di(di[8*i +: 8]),
                 .do1(mx[i + 4]));
    end
endgenerate                

//   assign   s0 = mx[0] ^ mx[4] ^ b2    ^ b3;
//   assign   s1 = b0    ^ mx[1] ^ mx[5] ^ b3;
//   assign   s2 = b0    ^ b1    ^ mx[2] ^ mx[6];
//   assign   s3 = mx[7] ^ b1    ^ b2    ^ mx[3];

   assign   s0 = mx[0] ^ b1    ^ b2    ^ mx[7];
   assign   s1 = mx[4] ^ mx[1] ^ b2    ^ b3;
   assign   s2 = b0    ^ mx[5] ^ mx[2] ^ b3;
   assign   s3 = b0    ^ b1    ^ mx[6] ^ mx[3];                

assign  do1 = {s3, s2, s1, s0};

endmodule : col_op
