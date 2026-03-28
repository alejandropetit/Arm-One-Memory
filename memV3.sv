module memV3 #(parameter WIDTH=32, DEPTH=64)(input logic clk, reset, we2, input logic [1:0] state, input logic [WIDTH-1:0] a1, a2, wd, output logic [WIDTH-1:0] rd1, rd2, input logic [9:0] switches, output logic [9:0] leds);
	
	localparam addr_bits = $clog2(DEPTH); 
	
	logic [WIDTH-1:0] rd, q_a, out_0;
	logic [addr_bits-1:0] addr_A, addr_B;
	logic we, led_in, switches_in;
	
	
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
		.q_a(q_a),
	
		.clock1(~clk),
		.address_b(addr_B),
		.wren_b(we),
		.data_b(wd),
		.q_b(rd)
	);
	

	always_comb begin
		addr_B = a2[addr_bits+1:2];
		case(state)
		2'b00, 2'b01: begin
			addr_A = '0;
			we = 1'b0;
			rd1 = '0;
		end
		2'b10: begin
			addr_A = 1;
			we = (led_in) ? '0 : we2;
			rd1 = out_0;
		end
		2'b11: begin
			addr_A = a1[addr_bits+1:2];
			we = (led_in) ? '0 : we2;
			rd1 = q_a;
		end
		endcase
	end
	
	assign led_in = (a2 == 32'hC000_0004) && we2;
	assign switches_in = (a2 == 32'hC000_0000);
							
	always_ff @(posedge clk)
		if (state == 2'b01)
			out_0 <= q_a;

	always_comb
		if (switches_in)
			rd2 = {22'b0, switches};
		else
			rd2 = rd; 
			 
	always_ff @(posedge clk)
		if (led_in)
			leds <= wd[9:0];
endmodule