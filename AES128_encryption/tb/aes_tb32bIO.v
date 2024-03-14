`timescale 1ns/1ps

module aes_tb();

	reg clk, rst, start;
	reg [31:0] data_in;
	wire [31:0] data_32;
	reg[127:0] data_out;
	wire done;
	reg recieve;
	
	reg [127:0] key1 [0:1];
	reg [127:0] di1 [0:1];
	
	aes_top dut(.CLK(clk), 
				.RST(rst),
				.start(start),
				.d_in(data_in),
				.d_out(data_32),
				.done(done)
				);
	initial
	begin
		clk = 1;
		start = 0;
		rst = 1;
	end
	
	always #5 clk = ~clk;
	
	initial
	begin
		$readmemh("key.txt", key1);
		$readmemh("text.txt", di1);
		#9;
		rst = 0;
		start = 1;
		data_in = di1[1][31:0];
		#20;
		start = 0;
		data_in = di1[1][63:32];
		#10;
		data_in = di1[1][95:64];
		#10;
		data_in = di1[1][127:96];
		#10;
		data_in = key1[1][31:0];
		#10;
		data_in = key1[1][63:32];
		#10;
		data_in = key1[1][95:64];
		#10;
		data_in = key1[1][127:96];
		
		if (done)
		begin
			recieve = 1'b1;
		end
		
		if (recieve == 1'b1)
		begin
			data_out[31:0] = data_32;
			#10;
			data_out[63:32] = data_32;
			#10;
			data_out[95:64] = data_32;
			#10;
			data_out[127:96] = data_32;
		end		
	end
endmodule
		