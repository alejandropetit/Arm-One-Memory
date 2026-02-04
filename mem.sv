/*
 *
 */ 
module mem(input logic clk, we, input logic [31:0] a1, a2, wd, output logic [31:0] rd1, rd2,
           input logic [9:0] switches, output logic [9:0] leds);
					
	logic[31:0] RAM[319:0];
	
	initial begin
	
	$readmemh("imem_to_test_peripherals.dat",RAM,0,255);
	$readmemh("dmem_to_test_peripherals.dat",RAM,256,319);
	
	
	// $readmemh("imem_made_by_students.dat",RAM);
	// $readmemh("dmem_made_by_students.dat",RAM);
	end
	
	assign rd1 = RAM[a1[31:2]];
	
	always_comb begin
		if (a2 == 32'hC000_0000)
			rd2 = {22'b0, switches};		
		else 
			rd2 = RAM[a2[31:2]];
	end
	
	always_ff @(posedge clk) begin
		if (we)
			if (a2 == 32'hc000_0004)
				leds <= wd[9:0];
			else
				RAM[a2[31:2]] <= wd;
	end	  
endmodule