module tb_decoder;

  reg [7:0] instIn_tb;
  wire [1:0] rs1_tb;
  wire [1:0] rs2_tb;
  wire [3:0] fn_tb;
  wire [3:0] imm_tb;

  decoder dut(
    .instIn(instIn_tb), 
    .rs1(rs1_tb), 
    .rs2(rs2_tb), 
    .fn(fn_tb), 
    .imm(imm_tb)
  );

  initial begin
    $dumpfile("dump.vcd");
    $dumpvars(0, tb_decoder);
    $monitor("Time: %0t, instIn: %b, rs1: %b, rs2: %b, fn: %b, imm: %b", $time, instIn_tb, rs1_tb, rs2_tb, fn_tb, imm_tb);
    instIn_tb = 8'b10101000; // NOR
    #5 instIn_tb = 8'b10100000; // NAND
    #5 instIn_tb = 8'b10101001; // BLT
    #5 instIn_tb = 8'b10100001; // BLT
    #5 instIn_tb = 8'b10101010; // Load
    #5 instIn_tb = 8'b10100010; // Load
    #5 instIn_tb = 8'b10101011; // SUB
    #5 instIn_tb = 8'b10100011; // ADD
    #5 instIn_tb = 8'b10101100; // SLL
    #5 instIn_tb = 8'b10100100; // SRL
    #5 instIn_tb = 8'b10101101; // BEQ
    #5 instIn_tb = 8'b10100101; // BEQ
    #5 instIn_tb = 8'b10101110; // Store
    #5 instIn_tb = 8'b10100110; // Store
    #5 instIn_tb = 8'b10101111; // Undefined
    #5 instIn_tb = 8'b10100111; // Jump
    #10 $finish;
  end
 
endmodule

