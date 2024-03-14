`timescale 1ns / 1ps
// ----------------------------------------------------------------------
// Copyright 
// 
// 
//
// ----------------------------------------------------------------------
//----------------------------------------------------------------------------
// Filename:			mod_mul.sv
// Version:				1.00
// Description:	
//
//
// Author:              A. MAHANI
// History:				
//-----------------------------------------------------------------------------


module mod_mul (
    input  logic [31:0]       di,
    input  logic [31:0]      exp,
    input  logic [31:0]        n,
    input  logic           start,
    input  logic             clk,
    input  logic            reset,
    output logic             done,
    output logic [31:0]     m_exp,
    output logic [31:0] remainder
);

    logic [15:0] ncount;
    logic [31:0] x, n1;
    logic [31:0] outResult;
    logic [31:0] remainderL;
    logic         start_div;
    logic         done_div; 
    
    typedef enum logic [1:0] { idle,
                               div_s,
                               modmul_s,
                               finish} state;
     state                   current_state = idle;


    always @(posedge clk) begin
    if(reset) begin
          done           <= 1'b0;
          remainder      <= 1'b0;
          m_exp          <= 1'b0;
          x              <= 1'b0;
          current_state  <= idle;
          end
       else begin 
       
       case(current_state)
       
          idle: begin
                current_state      <= (start == 1'b1) ? div_s : idle;
                if (start == 1'b1) begin
                    start_div   <= 1'b1;
                    ncount      <= exp + 1'b1 ;
                    m_exp       <= di  ;
                    x           <= 1'b1;
                end
          end
           
          div_s:   begin
                 start_div           <= 1'b0;
                 current_state       <= (done_div == 1'b1) ? modmul_s : div_s;
                 ncount              <= (done_div == 1'b1) ? (ncount - 1'b1) : ncount;
          end
          modmul_s:  begin

                     m_exp             <= remainderL * di;
                     x                 <= remainderL * di;
                     current_state     <= (ncount == 1'b0) ? finish : div_s;
                     start_div         <= (ncount == 1'b0) ? 1'b0 : 1'b1;
           end
           finish:  begin
                      current_state            <= idle;
                      remainder                <= remainderL;
                      done                     <= 1'b1; 
           end
       endcase
    end
   end

    
     div4 div (
        .clk(clk),
        .reset(reset),
        .start(start_div),
        .A(x),
        .B(n),
        .qu(outResult),
        .done(done_div),
        .Res(remainderL)
    );   

endmodule
