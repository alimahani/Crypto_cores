`timescale 1ns / 1ps
// ----------------------------------------------------------------------
// Copyright 
// 
// 
//
// ----------------------------------------------------------------------
//----------------------------------------------------------------------------
// Filename:			present_pbox.sv
// Version:				1.00
// Description:	
//
//
// Author:              A. MAHANI
// History:				
//-----------------------------------------------------------------------------

module present_pbox (
    input  logic [63:0] din,
    output logic [63:0] dout
);

    always_comb begin
        dout[0]  = din[0];
        dout[16] = din[1];
        dout[32] = din[2];
        dout[48] = din[3];
        dout[1]  = din[4];
        dout[17] = din[5];
        dout[33] = din[6];
        dout[49] = din[7];
        dout[2]  = din[8];
        dout[18] = din[9];
        dout[34] = din[10];
        dout[50] = din[11];
        dout[3]  = din[12];
        dout[19] = din[13];
        dout[35] = din[14];
        dout[51] = din[15];
        dout[4]  = din[16];
        dout[20] = din[17];
        dout[36] = din[18];
        dout[52] = din[19];
        dout[5]  = din[20];
        dout[21] = din[21];
        dout[37] = din[22];
        dout[53] = din[23];
        dout[6]  = din[24];
        dout[22] = din[25];
        dout[38] = din[26];
        dout[54] = din[27];
        dout[7]  = din[28];
        dout[23] = din[29];
        dout[39] = din[30];
        dout[55] = din[31];
        dout[8]  = din[32];
        dout[24] = din[33];
        dout[40] = din[34];
        dout[56] = din[35];
        dout[9]  = din[36];
        dout[25] = din[37];
        dout[41] = din[38];
        dout[57] = din[39];
        dout[10] = din[40];
        dout[26] = din[41];
        dout[42] = din[42];
        dout[58] = din[43];
        dout[11] = din[44];
        dout[27] = din[45];
        dout[43] = din[46];
        dout[59] = din[47];
        dout[12] = din[48];
        dout[28] = din[49];
        dout[44] = din[50];
        dout[60] = din[51];
        dout[13] = din[52];
        dout[29] = din[53];
        dout[45] = din[54];
        dout[61] = din[55];
        dout[14] = din[56];
        dout[30] = din[57];
        dout[46] = din[58];
        dout[62] = din[59];
        dout[15] = din[60];
        dout[31] = din[61];
        dout[47] = din[62];
        dout[63] = din[63];
    end

endmodule