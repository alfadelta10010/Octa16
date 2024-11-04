`timescale 1ns/1ps

module alutest;
	// Testbench signals
	reg [7:0] rs1, rs2;
	reg [2:0] ctrl;
	reg flag;
	wire [7:0] out;
	wire overflow;
	
	// Instantiate the ALU module
	alu uut (
		.rs1(rs1), 
		.rs2(rs2), 
		.ctrl(ctrl), 
		.flag(flag), 
		.out(out), 
		.overflow(overflow)
	);

	initial begin
		// Initialize inputs
		rs1 = 8'b00000000;
		rs2 = 8'b00000000;
		ctrl = 3'b000;
		flag = 1'b0;
		
		// Monitor outputs in binary format
		$monitor("Time = %0t, rs1 = %b, rs2 = %b, ctrl = %b, flag = %b -> out = %b, overflow = %b", 
		          $time, rs1, rs2, ctrl, flag, out, overflow);
		
		// Test ADD operation (ctrl = 3'b000, flag = 0)
		#10 rs1 = 8'b00001111; rs2 = 8'b00001010; ctrl = 3'b000; flag = 1'b0; // Expected: out = 25, overflow = 0
		#10 rs1 = 8'b10000010; rs2 = 8'b10000010; ctrl = 3'b000; flag = 1'b0; // Expected overflow check

		// Test SUB operation (ctrl = 3'b000, flag = 1)
		#10 rs1 = 8'b00001111; rs2 = 8'b00001010; ctrl = 3'b000; flag = 1'b1; // Expected: out = 5, overflow = 0
		#10 rs1 = 8'b00001010; rs2 = 8'b00001111; ctrl = 3'b000; flag = 1'b1; // Expected negative result in 2's complement

		// Test NOR and NAND operations (ctrl = 3'b001)
		#10 rs1 = 8'b10101010; rs2 = 8'b11001100; ctrl = 3'b001; flag = 1'b0; // NOR: Expected out
		#10 rs1 = 8'b10101010; rs2 = 8'b11001100; ctrl = 3'b001; flag = 1'b1; // NAND: Expected out

		// Test SLTU operation (ctrl = 3'b010)
		#10 rs1 = 8'b00001010; rs2 = 8'b00010100; ctrl = 3'b010; flag = 1'b0; // Expected: out = 1 (since rs1 < rs2)
		#10 rs1 = 8'b00011110; rs2 = 8'b00010100; ctrl = 3'b010; flag = 1'b0; // Expected: out = 0 (since rs1 > rs2)

		// Test SLL (shift left logical) and SRL (shift right logical) (ctrl = 3'b011)
		#10 rs1 = 8'b00001111; rs2 = 8'b00000010; ctrl = 3'b011; flag = 1'b1; // SLL: Expected: 8'b00111100
		#10 rs1 = 8'b11110000; rs2 = 8'b00000010; ctrl = 3'b011; flag = 1'b0; // SRL: Expected: 8'b00111100

		// Test SRA (arithmetic shift right) (ctrl = 3'b100)
		#10 rs1 = 8'b11110000; rs2 = 8'b00000010; ctrl = 3'b100; flag = 1'b0; // SRA: Expected 8'b11111100

		// End of test
		#10 $finish;
	end
endmodule

