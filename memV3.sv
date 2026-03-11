module memV3 #(parameter WIDTH=32, DEPTH=64)(input logic clk, reset, we2, input logic [WIDTH-1:0] a1, a2, wd, output logic [WIDTH-1:0] rd1, rd2, input logic [9:0] switches, output logic [9:0] leds);
	
	localparam addr_bits = $clog2(DEPTH); 
	
	logic [WIDTH-1:0] rd, rd11, rd12, curr_a1;
	logic [addr_bits-1:0] addr_A, addr_B;
	logic we, led_in, switches_in, zero_addr;
	
	altsyncram #(
		.OPERATION_MODE("BIDIR_DUAL_PORT"),
		.INIT_FILE("mem.mif"),
		
		.WIDTH_A(WIDTH),
		.WIDTHAD_A(addr_bits),
		
		.WIDTH_B(WIDTH),
		.WIDTHAD_B(addr_bits)
	) 
	u_mem(
		.clock0(clk),
		.address_a(addr_A),
		.q_a(rd1),
	
		.clock1(~clk),
		.address_b(addr_B),
		.wren_b(we),
		.data_b(wd),
		.q_b(rd)
	);
	
	assign addr_A = (curr_a1 === 'x) ? '0 : (curr_a1 == 0) ? '0 : curr_a1[addr_bits+1:2];
	assign addr_B = a2[addr_bits+1:2];
	assign curr_a1 = a1 - 4;
	assign led_in = (a2 == 32'hC000_0004);
	assign switches_in = (a2 == 32'hC000_0000);
	assign we = (led_in) ? ~we2 : we2;
	
	always_comb
		if (switches_in)
			rd2 = {22'b0, switches};
		else
			rd2 = rd; 
			
			
	always_ff @(negedge clk)
		if (led_in)
			leds <= wd[9:0];
endmodule