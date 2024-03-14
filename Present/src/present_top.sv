`timescale 1ns / 1ps
// ----------------------------------------------------------------------
// Copyright 
// 
// 
//
// ----------------------------------------------------------------------
//----------------------------------------------------------------------------
// Filename:			present_top.sv
// Version:				1.00
// Description:	
//
//
// Author:              A. MAHANI
// History:				
//-----------------------------------------------------------------------------

module present_top (
    input  logic               CLK,
    input  logic               RST,
    input  logic             start,
    input  logic [63:0]        din,
    input  logic [79:0]        key,
    output logic [63:0]       dout,
    output logic              done );

    logic [79:0] round_key;
    logic [63:0] c_text;
    logic [5:0]  round_counter;
    logic [63:0] round_data;
    logic [63:0] s_data;
    logic [63:0] p_data;
    logic [79:0] key1;
    logic [79:0] key2;
    
    typedef enum logic[1:0] { idle      ,
                              rounds    ,
                              last_round } state;
    state   current_state;                   

    always @(posedge CLK) begin
        if (RST) begin
            done                  <= 1'b0;
            dout                  <= 32'b0;
            current_state         <= idle;  
        end

        else begin
            case(current_state)

            idle: begin 
                if(start) begin
                    current_state    <= rounds;
                    c_text           <=  din;
                    round_key        <=  key;
                    round_counter    <= 6'b1;

                end
                else
                current_state      <= idle;  
            end 
            rounds: begin

                if(round_counter < 6'd32) begin

                c_text           <= p_data;
                round_key        <= key2;
                round_counter    <= round_counter + 1'b1;
                end 
                else
                current_state     <= last_round;

            end 
            last_round: begin
            done            <= 1'b1;
            dout            <= round_data;
        end
            endcase
    end
  end

    assign round_data           = c_text ^ round_key[79:16];  //the c_text xor with round key to make the round data

    assign key1        = {round_key[18:0], round_key[79:19]}; // 61bit rotated to the left shift
    assign key2[14:0]  = key1[14:0];                          // no_change part of the key 
    assign key2[19:15] = key1[19:15] ^ round_counter;         // 4bits of key xor with round_counter
    assign key2[75:20] = key1[75:20];                        // no_change part of the key
    
   present_sbox sbox1( 
        .din (key1[79:76]),
        .dout(key2[79:76]) 
        );

    generate
        genvar i;
        for (i = 0; i < 64; i = i + 4) begin: sbox_loop
            present_sbox sbox2 (
                .din (round_data[i + 3:i]),
                .dout(s_data[i + 3:i]) 
                );
        end
    endgenerate

    present_pbox pbox( 
        .din (s_data),
        .dout(p_data)
        );


endmodule