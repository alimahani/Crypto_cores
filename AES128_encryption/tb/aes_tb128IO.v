`timescale 1ns/1ps

module aes_tb();

	reg clk, rst, start;
	reg [127:0] key, data_in;
	wire [127:0] data_out;
	wire done;
	
	reg [127:0] key1 [0:1];
	reg [127:0] di1 [0:1];
	
	aes_top dut(.CLK(clk), 
				.RST(rst),
				.start(start),
				.key(key),
				.di(data_in),
				.do1(data_out),
				.done(done)
				);
	initial
	begin
		clk = 0;
		start = 0;
		rst = 1;
		#12;
		rst = 0;
		start = 1;
	end
	
	always #5 clk = ~clk;
	
	initial
	begin
		$readmemh("key.txt", key1);
		$readmemh("text.txt", di1);
		key = key1[0];
		data_in = di1[0];
		#500;
		start = 0;
		key = key1[1];
		data_in = di1[1];
		#12;
		start = 1;
	end
endmodule
		