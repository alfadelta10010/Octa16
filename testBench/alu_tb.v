`timescale 1ns / 1ps

module alu_tb();

  reg [7:0] a, b;
  reg [2:0] control;
  reg flag;
  wire [7:0] c;
  wire f;

  alu dut(
    .rs1(a), 
    .rs2(b), 
    .ctrl(control), 
    .Flag(flag), 
    .overflow(f), 
    .out(c)
  );

  initial begin
    //NAND
    a = 8'b00000101;
    b = 8'b00000001;
    control = 3'b000;
    flag = 1'b1;
    #10;
    $display("NAND: a=%b, b=%b, out=%b, overflow=%b", a, b, c, f);
    
    //NOR
    control = 3'b000;
    flag = 1'b0;
    #10;
    $display("NOR: a=%b, b=%b, out=%b, overflow=%b", a, b, c, f);

    //Addition
    control = 3'b011;
    flag = 1'b0;
    #10;
    $display("Addition: a=%b, b=%b, out=%b, overflow=%b", a, b, c, f);
    
    //Subtraction
    control = 3'b001;
    flag = 1'b1;
    #10;
    $display("Subtraction: a=%b, b=%b, out=%b, overflow=%b", a, b, c, f);
    
    //Shift Right
    control = 3'b100;
    flag = 1'b0;
    #10;
    $display("Shift Right: a=%b, b=%b, out=%b, overflow=%b", a, b, c, f);
    
    //Shift Left
    control = 3'b100;
    flag = 1'b1;
    #10;
    $display("Shift Left: a=%b, b=%b, out=%b, overflow=%b", a, b, c, f);
    
    $finish;
  end
endmodule

