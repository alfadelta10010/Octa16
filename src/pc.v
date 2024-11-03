module pc(clk, reset, pc_out, branch_in, branch_sel);
  input clk;
  input reset;
  output reg [4:0] pc_out; 
  wire [4:0] pc_reg;
  input wire  branch_sel;
  input wire [4:0] branch_in;
  wire [4:0] check;
  
  assign check = branch_sel ? branch_in : 5'b1;
  assign pc_reg = pc_out + check;

  always @(posedge clk or posedge reset) 
    begin
      if (reset) 
        pc_out <= 5'b0;
      else
        pc_out <= pc_reg;
    end
endmodule
