module memV2(input logic clk, we, input logic [31:0] a1, a2, wd, output logic [31:0] rd1, rd2,
				 input logic [9:0] switches, output logic [9:0] leds);
	logic [31:0] RAM [63:0];
	
	initial
		$readmemh("C:/Users/josea/Digital_2/ARM_one_memory/ARM_one_memory/mem.dat", RAM);
	

	assign rd1 = RAM[a1[31:2]];
	
	always_comb
		if (a2 == 32'hc000_0000)
			rd2 = {22'b0, switches};
		else
			rd2 = RAM[a2[31:2]];
	
	always_ff @(posedge clk)
		if (we)
			if (a2 == 32'hc000_0004)
				leds <=  wd[9:0];
			else
				RAM[a2[31:2]] <= wd;
endmodule