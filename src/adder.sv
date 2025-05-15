module adder #(parameter N = 16)(a, b, s);
  input logic [N-1:0] a;
  input logic [N-1:0] b;
  output logic [N-1:0] s;

  assign s = a + b;

endmodule
