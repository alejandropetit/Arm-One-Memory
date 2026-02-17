module memV3 #(parameter WIDTH=32, DEPTH=64)(input logic clk, reset, we2, input logic [WIDTH-1:0] a1, a2, wd, output logic [WIDTH-1:0] rd1, rd2, input logic [9:0] switches, output logic [9:0] leds);
	
	localparam addr_bits = $clog2(DEPTH); 
	
	logic [WIDTH-1:0] rd;
	logic [addr_bits-1:0] input_A=0, input_B;
	logic we;
	
	altsyncram #(
		.OPERATION_MODE("BIDIR_DUAL_PORT"),
		.INIT_FILE("mam.hex"),
		
		.WIDTH_A(WIDTH),
		.WIDTHAD_A(addr_bits),
		
		.WIDTH_B(WIDTH),
		.WIDTHAD_B(addr_bits)
	) 
	u_mem(
		.clock0(clk),
		.address_a(input_A),
		.q_a(rd1),
	
		.clock1(~clk),
		.address_b(input_B),
		.wren_b(we),
		.data_b(wd),
		.q_b(rd)
	);
	
	
	always_comb begin
	 input_A = (reset) ? '0 : a1[addr_bits+1:2];
	 input_B = (reset) ? '0 : a2[addr_bits+1:2];
	end
	
	assign we = (a2 == 32'hC000_0004) ? ~we2 : we2;
	
	always_comb
		if (a2 == 32'hC000_0000)
			rd2 = {22'b0, switches};
		else
			rd2 = rd; 
			
	always_ff @(negedge clk)
		if (a2 == 32'hC000_0004)
			leds <= wd[9:0];
	

endmodule