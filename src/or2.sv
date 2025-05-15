module or2 #(parameter N = 16)(a, b, y);
  input logic [N-1 : 0] a;
  input logic [N-1 : 0] b;
  output logic [N-1 : 0] y;
  assign y = a | b;
endmodule
