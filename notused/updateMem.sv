module updateMem #(parameter WIDTH=32)(input logic clk, input logic [WIDTH-1:0] a, output logic [WIDTH-1:0] rd);

	altsyncram #(
		.OPERATION_MODE("ROM"),
		.NUMWORDS_A(64),
		.WIDTH_A(32),
		.WIDTHAD_A(6),
		.OUTDATA_REG_A("UNREGISTERED"),
		.INIT_FILE("mam.hex"),
		.RAM_BLOCK_TYPE("M9K")

	)
	u_mem (
		.clock0(clk),
		.address_a(a),
		.q_a(rd)
	);

endmodule