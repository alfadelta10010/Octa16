module IF(
  input         pcRst, 
  input         clk,
  input         branchSel, 
  input         pcEn,
  input  [31:0] branchVal,
  output [31:0] pcP,
  output [31:0] pcN, 
  output [31:0] instOut
);
  
  logic  [31:0] pcIn;
  
  adder #(32) pcAdder (.a(32'd4), .b(pcP), .s(pcN)); 
  instMem #(8) instructionMemory (.instAddr(pcP), .instOut(instOut));
  mux21 #(32) branchMux (.a(pcN), .b(branchVal), .s(branchSel), .y(pcIn));
  regs #(32) programCounter (.clk(clk), .rst(pcRst), .in(pcIn), .out(pcP), .en(pcEn));

endmodule
