module alu(
	input wire [7:0] rs1, rs2,
	input wire [2:0]ctrl,
	input wire flag,
	output reg [7:0] out, 
	output reg overflow);
	
	adder_8 adder (
    .Cin(cin), 
    .A(a_temp), 
    .B(b_temp), 
    .Sum(add_out), 
    .Cout(add_overflow));
	
	always @(*) begin
		// This is to avoid latches
		out = 8'b0;
		overflow = 1'b0;
		a_temp = 8'b0;
		b_temp = 8'b0;
		cin = 1'b0; 
		
		case(ctrl)
			3'b000: 
				begin
					if (flag == 1) // SUB
					begin
						a_temp = rs1;
						b_temp = ~rs2;
						cin = 1'b1; 
						out = add_out;
						overflow = add_overflow;
					end 
				else begin // ADD
						a_temp = rs1;
						b_temp = rs2;
						cin = 1'b0; 
						out = add_out;
						overflow = add_overflow;
					end
				end
			3'b001:
				begin
					if (flag == 1)
					begin
						out = ~(rs1 & rs2); // NAND
					end
				else begin
						out = ~(rs1 | rs2); // NOR
					end
				end
			3'b010:
				begin
					out = (rs1 < rs2) ? 8'b1 : 8'b0; // SLTU
				end
			3'b011:
				begin
					if (flag == 1)
					begin
						out = rs1 << rs2[2:0]; // SLL
						overflow = 1'b0;
					end
				else begin
						out = rs1 >> rs2[2:0]; //SRL
						overflow = 1'b0;
					end
				end
			3'b100:
				begin
					out = rs1 >>> rs2[2:0]; // SRA
				end
			default: begin
				out = 8'b0;
				overflow = 1'b0;
			end
		endcase
	end
endmodule

