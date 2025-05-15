module mux21 #(parameter N = 8) (a, b, s, y);
  input logic [N-1:0] a; // 0
  input logic [N-1:0] b; // 1
  input logic s;
  output logic [N-1:0] y;
  assign y = s ? b : a;
endmodule
