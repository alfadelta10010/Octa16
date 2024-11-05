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
            imm = {{5{instIn[15]}},instIn[14:12]};
          end
        3'b010: //L-Type
          begin
            rs1 = instIn[11:9];
            rd = instIn[8:6];
            imm = {{2{instIn[15]}},instIn[14:12], instIn[5:3]};
          end
        3'b011: //S-Type
          begin
            rs1 = instIn[11:9];
            rd = instIn[8:6];
            imm = {{2{instIn[15]}},instIn[14:12], instIn[5:3]};
          end
        3'b100: //B-Type
          begin
            rs2 = instIn[14:12];
            rs1 = instIn[11:9];
            func = instIn[5:3];
            imm = {{5{instIn[15]}}, instIn[8:6]};
          end
        3'b101:
          begin
            rd = instIn[8:6];
            func = instIn[5:3];
            case(func)
              3'b000: begin imm = {1'b0, instIn[15:9]}; end   // JAL
              3'b100: begin imm = {instIn[15:12], 4'b0}; rs1 = instIn[11:9]; end  // JALR
            endcase
          end
        3'b110:
          begin
            rd = instIn[8:6];
            func = instIn[5:3];
            case(func)
              3'b001: begin imm = {{2{instIn[15]}}, instIn[14:9]}; end   // ADDPC
              3'b000: begin imm = {instIn[15:12],4'b0}; rs1 = instIn[11:9]; end  // AUIR
            endcase
          end
