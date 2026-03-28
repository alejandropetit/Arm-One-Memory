module init(input logic clk, reset, output logic [1:0] state);

	logic [1:0] next_state;

	always_ff @(posedge clk, posedge reset)
	if (reset)
		state <= 2'b00;
	else
		state <= next_state;
		
	always_comb
		case(state)
			2'b00: next_state <= 2'b01;
			2'b01: next_state <= 2'b10;
			2'b10: next_state <= 2'b11;
			2'b11: next_state <= 2'b11;
		endcase

endmodule