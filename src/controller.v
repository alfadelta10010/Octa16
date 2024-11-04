module controller(input wire [2:0]func, 
			input wire [2:0]op,
			output reg reg_wr, mem_wr, wb_ctrl, flag, doBranch, doJump
			output reg [2:0]alu_op, branch_ctrl,
			output reg alu_s1, alu_s2);
	
	always_comb
		begin
			reg_wr = 1'b0;
			alu_s1 = 1'b0;
			alu_s2 = 1'b0;
			alu_op = 3'b0;
			mem_wr = 1'b0;
			doBranch = 1'b0;
			flag = 1'b0;
			//wb_ctrl = 1'b0;
			case(op)
				3'b000: 
					begin
						reg_wr = 1'b1;
						//wb_ctrl = 1'b0;
						alu_s1 = 1'b0;
						alu_s2 = 1'b1;
						
						case(func) 
							3'b000: begin // ADD
								alu_op = 3'b000;
								flag = 1'b0;
							end
							3'b001: begin // SUB
								alu_op = 3'b000;
								flag = 1'b1;
							end
							3'b010: begin // NAND
								alu_op = 3'b001;
								flag = 1'b0;
							end
							3'b011: begin // NOR
								alu_op = 3'b001;
								flag = 1'b1;
							end
							3'b100: begin // SLTU
								alu_op = 3'b010;
							end
							3'b101: begin // SLL
								alu_op = 3'b011;
								flag = 1'b0;
							end
							3'b110: begin // SRL
								alu_op = 3'b011;
								flag = 1'b1;
							end
							3'b111: begin // SRA
								alu_op = 3'b100;
							end
						endcase
					end
				3'b001: // I-TYPE Instrcutions
					begin
						reg_wr = 1'b1;
						//wb_ctrl = 1'b0;
						case(func) 
							3'b000: begin // ADDI
								alu_op = 3'b000;
								flag = 1'b0;
							end
							3'b010: begin // NANDI
								alu_op = 3'b001;
								flag = 1'b0;
							end
							3'b011: begin // NORI
								alu_op = 3'b001;
								flag = 1'b1;
							end
							3'b100: begin // SLTI
								alu_op = 3'b010;
							end
							3'b101: begin // SLLI
								alu_op = 3'b011;
								flag = 1'b0;
							end
							3'b110: begin // SRLI
								alu_op = 3'b011;
								flag = 1'b1;
							end
							3'b111: begin // SRAI
								alu_op = 3'b100;
							end
						endcase
					end
				3'b010: // L-TYPE Instruction
					begin
						reg_wr = 1'b1;
						alu_op = 3'b000;
						//wb_ctrl = 1'b1;
						//need to be done
					end
				3'b011: // S-TYPE Instruction
					begin
						mem_wr = 1'b1;
						alu_op = 3'b000;
						//need to be done
					end
				3'b100: // B-TYPE Instructions
					begin
						branch_ctrl = func;
						doBranch = 1'b1;
						alu_s1 = 1'b1;
						alu_op = 3'b000;
					end
				3'b101: // J-TYPE Instructions
					begin
						case(func)
							3'b000:
								begin
									reg_wr = 1'b1;
									alu_s1 = 1'b1;
									//wb_ctrl = 1'b1;
									alu_op = 3'b000;
									doJump = 1'b1;
								end
							3'b100:
								begin
									reg_wr = 1'b1;
									//wb_ctrl = 1'b1;
									alu_op = 3'b000;
									doJump = 1'b0;
								end
						endcase
					end
				3'b110: // U-TYPE Instructions
					begin
					end
			endcase
		end
endmodule
	
					
				
					
							
							
							