module alu(d1, d2, result, control);
  input logic [7:0] d1;
  input logic [7:0] d2;
  output logic [7:0] result;
  input logic [3:0] control;
  always_comb 
  begin
    case(control)
      4'b0000: result = d1 + d2; // ADD
      4'b0001: result = d1 << d2[4:0]; // SLL
      4'b0010: result = ($signed(d1) < $signed(d2)) ? 7'h01 : 7'h00; // SLT
      4'b0011: result = (d1 < d2) ? 7'h01 : 7'h00; // SLTU
      4'b0100: result = d1 ^ d2; // XOR
      4'b0101: result = d1 >> d2[2:0]; // SRL
      4'b0110: result = d1 | d2; // OR
      4'b0111: result = d1 & d2; // AND
      4'b1000: result = d1 - d2; // SUB
      //4'b1001:
      //4'b1010:
      //4'b1011:
      4'b1100: result = ~(d1 ^ d2); // XNOR
      4'b1101: result = d1 >>> d2[2:0]; // SRA
      4'b1110: result = ~(d1 | d2); // NOR
      4'b1111: result = ~(d1 & d2); // NAND
      default: result = 7'b0;
    endcase
  end
endmodule
