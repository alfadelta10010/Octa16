module instMem #(parameter IADDRLEN = 8) (instAddr, instOut);
  input logic [IADDRLEN-1:0] instAddr;
  output logic [15:0] instOut; 

  reg [15:0] mem [0 : (2**IADDRLEN)-1];
  
  initial begin
    $readmemh("program.data", mem, 0, (2**IADDRLEN) -1);
  end
  
  assign instOut = mem [instAddr];

endmodule
