`timescale 1ns / 1ps

module present_tb();
	reg clk, rst, start;
	reg [63:0] data_in;
	reg [79:0] key;
	wire [63:0] data_out;
	wire done;
	
	reg [79:0] key1 [0:0];
	reg [63:0] di1 [0:0];

	present_top dut(.CLK(clk),
                    .RST(rst),
                    .start(start),
                    .din(data_in),
                    .key(key),
                    .dout(data_out),
                    .done(done));
					
					
	initial
	begin
		clk = 0;
		rst = 1;
		start = 0;
	end
	
	always #5 clk = ~clk;
	
	initial
	begin
		#15;
		rst = 0;
		start = 1;
		$readmemh("key.txt", key1);
		$readmemh("text.txt", di1);
		key = key1[0];
		data_in = di1[0];
		#15;
		start = 0;
	end
endmodule