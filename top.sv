/*
 * This module is the TOP of the ARM single-cycle processor
 */ 
module top(input logic clk, nreset,
			  input logic [9:0] switches,
			  output logic [9:0] leds);

	// Internal signals
	logic reset;
	assign reset = ~nreset;
	logic [31:0] PC, Instr, ReadData;//ReadData1, ReadData2;
	logic [31:0] WriteData, DataAdr;
	logic MemWrite;
	//logic InstMem;
	
	// Instantiate instruction memory
	//imem imem(clk, MemWrite, InstMem, PC, DataAdr, WriteData, Instr, ReadData2);

	// Instantiate data memory (RAM + peripherals)
	//dmem dmem(clk, MemWrite, InstMem, DataAdr, WriteData, ReadData1, switches, leds);
	
	memV2 mem(clk, MemWrite, PC, DataAdr, WriteData, Instr, ReadData, switches, leds);
	
	// Instantiate processor
	arm arm(clk, reset, PC, Instr, MemWrite, DataAdr, WriteData, ReadData);
endmodule