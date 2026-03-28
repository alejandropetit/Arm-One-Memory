/*
 * This module is the TOP of the ARM single-cycle processor
 */ 
module top(input logic clk, nreset,
			  input logic [9:0] switches,
			  output logic [9:0] leds);
	

	
	// Internal signals
	logic reset;
	assign reset = ~nreset;
	logic [31:0] PCNext, Instr, ReadData;
	logic [31:0] WriteData, DataAdr;
	logic MemWrite;
	logic [1:0] state; 
	
	
	// Instantiate Memory
	memV3 mem(clk, reset, MemWrite, state, PCNext, DataAdr, WriteData, Instr, ReadData, switches, leds);
	
	// Instantiate processor
	arm arm(clk, reset, state, PCNext, Instr, MemWrite, DataAdr, WriteData, ReadData);
	
	init init(clk, reset, state);

endmodule