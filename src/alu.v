`timescale 1ns / 1ps

module alu(
  input wire [7:0] rs1, rs2,
  input wire [2:0] ctrl,
  input wire Flag,
  output reg [7:0] out,
  output reg overflow
);

  reg [7:0] a_temp, b_temp;
  reg cin;
  wire [7:0] add_out;
  wire add_overflow;

  adder_8 adder (
    .Cin(cin), 
    .A(a_temp), 
    .B(b_temp), 
    .Sum(add_out), 
    .Cout(add_overflow)
  );

  always @(*) begin
    // Default assignments to avoid latches
    out = 8'b0;
    overflow = 1'b0;
    a_temp = 8'b0;
    b_temp = 8'b0;
    cin = 1'b0;

    case(ctrl)
      3'b000: begin
        if (Flag == 1)
          out = ~(rs1 & rs2);  // NAND
        else 
          out = ~(rs1 | rs2);  // NOR
      end
      
      3'b011: begin
        if (Flag == 1) begin 
          a_temp = rs1;
          b_temp = ~rs2;
          cin = 1'b1; 
          out = add_out;
          overflow = add_overflow;
        end else begin
          a_temp = rs1;
          b_temp = rs2;
          cin = 1'b0; 
          out = add_out;
          overflow = add_overflow;
        end
      end
      
      3'b100: begin
        if (Flag == 1) begin
          out = rs1 << rs2[2:0];  // Shift left
          overflow = 1'b0;
        end else begin
          out = rs1 >> rs2[2:0];  // Shift right
          overflow = 1'b0;
        end
      end

      default: begin
        out = 8'b0;    // Assign a valid default value to avoid X (undefined state)
        overflow = 1'b0;
      end
    endcase
  end
endmodule
