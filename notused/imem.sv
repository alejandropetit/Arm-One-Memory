/*
 * This module is the Instruction Memory of the ARM single-cycle processor
 */ 
module imem(input logic clk, we, im, input logic [31:0] a1, a2, wd, output logic [31:0] rd1, rd2);
	// Internal array for the memory (Only 64 32-words)
	logic [31:0] RAM[255:0];

	// The following line loads the program instruction
	// Be careful to have a program longer than the memory available
	initial
		// Uncomment the following line only if you want to load the code given to check peripherals
		$readmemh("C:/Users/josea/Digital_2/ARM_one_memory/imem_to_test_peripherals.dat",RAM);
		
		// Uncomment the following line only if you want to load the code made by your group
		// $readmemh("imem_made_by_students.dat",RAM);
		
	always_ff @(posedge clk) begin
		if (we & im)	
				RAM[a2[31:2]] <= wd;
	end

	assign rd1 = RAM[a1[31:2]]; // word aligned
	
	assign rd2 = RAM[a2[31:2]];
endmodule