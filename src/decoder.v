module decoder(input wire [15:0]instIn,
			   output reg [2:0]rs1, rs2, rd, 
			   output reg [2:0]func,
			   output reg [2:0]opcode,
			   output reg imm);
	
	always_comb
		begin
			opcode = instIn[2:0];
			rs1 = 3'b0;
			rs2 = 3'b0;
			rd = 3'b0;
			func = 3'b0;
			
			case(opcode)
				3'b000: //R-Type
					begin
						rs1 = instIn[11:9];
						rs2 = instIn[14:12];
						rd = instIn[8:6];
						func = instIn[5:3];
					end
				3'b001: //I-Type
					begin
						rs1 = instIn[11:9];
						rd = instIn[8:6];
						func = instIn[5:3];
						imm = instIn[15:12];
					end
				3'b010: //L-Type
					begin
						rs1 = instIn[11:9];
						rd = instIn[8:6];
						imm = {instIn[15:12], instIn[5:3]};
					end
				3'b011: //S-Type
					begin
						rs1 = instIn[11:9];
						rd = instIn[8:6];
						imm = {instIn[15:12], instIn[5:3]};
					end
				3'b100: //B-Type
					begin
						rs2 = instIn[14:12];
						rs1 = instIn[11:9];
						func = instIn[5:3];
						imm = {instIn[15], instIn[8:6]};
					end
				3'b101:
					begin
						rd = instIn[8:6];
						func = instIn[5:3];
						case(func)
							3'b000: begin imm = instIn[15:9]; end   // JAL
							3'b100: begin imm = instIn[15:12]; rs1 = instIn[11:9]; end  // JALR
						endcase
					end
				3'b110: 
					begin
						rd = instIn[8:6];
						func = instIn[5:3];
						case(func)
							3'b001: begin imm = instIn[15:9]; end   // ADDPC
							3'b000: begin imm = instIn[15:12]; rs1 = instIn[11:9]; end  // AUIR
						endcase
					end
							
							
				
/*module decoder(instIn, rs1, rs2, fn, imm);
  input wire [7:0] instIn;
  output reg [1:0] rs1;
  output reg [1:0] rs2;
  reg [2:0] opcode;
  output reg [3:0] fn;
  output reg [3:0] imm;
  always@ (*)
    begin
      opcode = instIn[2:0];
      case(opcode)
        3'b000: // Logic NAND, NOR
          begin
            rs1 = {instIn[4], instIn[6]};
            rs2 = {instIn[5], instIn[7]};
            fn  = {instIn[3:0]};
            imm = 4'bX;
          end
        3'b001: // Branches BLT
          begin
            rs1 = {1'b0, instIn[6]};
            rs2 = {1'b0, instIn[7]};
            fn = {1'bx, instIn[2:0]};
            imm = instIn[5:3];
          end
        3'b101: // Branches BEQ
          begin
            rs1 = {1'b0, instIn[6]};
            rs2 = {1'b0, instIn[7]};
            fn = {1'bx, instIn[2:0]};
            imm = instIn[5:3];
          end
        3'b010: // Load
          begin
            fn = {1'bx, instIn[2:0]};
            rs1 = {1'b0, instIn[7]};
            rs2 = 2'bX;
            imm = instIn[6:3];
          end
        3'b110: // Store
          begin
            fn  = {1'bx, instIn[2:0]};
            rs1 = {1'b0, instIn[6]};
            rs2 = {1'b0, instIn[7]};
            imm = instIn[5:3];
          end
        3'b011: // Arithmetic ADD SUB
          begin
            fn  = {instIn[3:0]};
            rs1 = {instIn[4], instIn[6]};
            rs2 = {instIn[5], instIn[7]};
            imm = 4'bX;
          end
        3'b100: // Logic SRL SLL
          begin
            fn  = {instIn[3:0]};
            rs1 = {instIn[4], instIn[6]};
            rs2 = {instIn[5], instIn[7]};
            imm = 4'bX;
          end
        3'b111: // Jump + Move
          begin
            fn = instIn[3:0];
            if(instIn[3] == 1'b1) 
              begin
                rs1 = 2'bX;
                rs2 = 2'bX;
                imm = instIn[7:4];
              end
            else
              begin
                // Move
                rs1 = {instIn[4], instIn[6]};
                rs2 = {instIn[5], instIn[7]};
                imm = 4'bX;
              end
          end
        default:
          begin
            rs1 = 2'bX;
            rs2 = 2'bX;
            fn = 1'bX;
            imm = 4'bX;
          end
      endcase
    end
endmodule
