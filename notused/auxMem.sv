module auxMem #(parameter WIDTH=32)(input logic clk, input logic [WIDTH-1:0] a, wd, output logic [WIDTH-1:0] rd);
	logic [WIDTH-1:0] RAM [63:0];
	assign rd = a;
	
	always_ff @(posedge clk)
		RAM[a[31:2]] <= wd; 
		
	
endmodule