module RegisterFile(clk, wen, rd, rs1, rs2, r1, r2, din);
  input logic clk, wen;
  input logic [2:0] rd;
  input logic [2:0] rs1;
  input logic [2:0] rs2;
  input logic [7:0] din;
  output logic [7:0] r1;
  output logic [7:0] r2;

  logic [7:0] regs [0:7];

  initial begin
    for (int i = 0; i < 8; i++)
      regs[i] <= 8'b0;
  end
  always @(posedge clk)
    if (wen) 
      regs[rd] <= din;
    assign r1 = regs[rs1];
    assign r2 = regs[rs2];
endmodule
