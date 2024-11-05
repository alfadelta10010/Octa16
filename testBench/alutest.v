`timescale 1ns/1ps

module alutest;
	// Testbench signals
	reg [7:0] a, b;
	reg [2:0] ctrl;
	reg flag;
	wire [7:0] out;
	
	
	// Instantiate the ALU module
	alu uut (
		.a(a), 
		.b(b), 
		.ctrl(ctrl), 
		.flag(flag), 
		.out(out)
	);

	initial begin
		// Initialize inputs
		a = 8'b00000000;
		b = 8'b00000000;
		ctrl = 3'b000;
		flag = 1'b0;
		
		// Monitor outputs in binary format
		$monitor("Time = %0t, a = %b, b = %b, ctrl = %b, flag = %b -> out = %b", 
		          $time, a, b, ctrl, flag, out);
		
		// Test ADD operation (ctrl = 3'b000, flag = 0)
		#10 a = 8'b00001111; b = 8'b00001010; ctrl = 3'b000; flag = 1'b0; // Expected: out = 25, overflow = 0
		#10 a = 8'b10000010; b = 8'b10000010; ctrl = 3'b000; flag = 1'b0; // Expected overflow check

		// Test SUB operation (ctrl = 3'b000, flag = 1)
		#10 a = 8'b00001111; b = 8'b00001010; ctrl = 3'b000; flag = 1'b1; // Expected: out = 5, overflow = 0
		#10 a = 8'b00001010; b = 8'b00001111; ctrl = 3'b000; flag = 1'b1; // Expected negative result in 2's complement

		// Test NOR and NAND operations (ctrl = 3'b001)
		#10 a = 8'b10101010; b = 8'b11001100; ctrl = 3'b001; flag = 1'b0; // NOR: Expected out
		#10 a = 8'b10101010; b = 8'b11001100; ctrl = 3'b001; flag = 1'b1; // NAND: Expected out

		// Test SLTU operation (ctrl = 3'b010)
		#10 a = 8'b00001010; b = 8'b00010100; ctrl = 3'b010; flag = 1'b0; // Expected: out = 1 (since a < b)
		#10 a = 8'b00011110; b = 8'b00010100; ctrl = 3'b010; flag = 1'b0; // Expected: out = 0 (since a > b)

		// Test SLL (shift left logical) and SRL (shift right logical) (ctrl = 3'b011)
		#10 a = 8'b00001111; b = 8'b00000010; ctrl = 3'b011; flag = 1'b1; // SLL: Expected: 8'b00111100
		#10 a = 8'b11110000; b = 8'b00000010; ctrl = 3'b011; flag = 1'b0; // SRL: Expected: 8'b00111100

		// Test SRA (arithmetic shift right) (ctrl = 3'b100)
		#10 a = 8'b11110000; b = 8'b00000010; ctrl = 3'b100; flag = 1'b0; // SRA: Expected 8'b11111100

		// End of test
		#10 $finish;
	end
endmodule

