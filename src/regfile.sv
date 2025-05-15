module regFile #(parameter DATA_WIDTH = 8) (clk, wrEn, rs1, rs2, rd, r1, r2, dIn);
  input logic clk, wrEn;
  input logic [2:0] rs1, rs2, rd;
  input logic [DATA_WIDTH-1:0] dIn;
  output logic [DATA_WIDTH-1:0] r1, r2;
  reg [DATA_WIDTH-1:0] reg_file [0:7];
  initial begin
    int i;
    for (i = 0; i < 7; i = i + 1) 
      begin
        reg_file[i] = 0;
      end
  end

  // register file write logic (synchronous)
  always @(posedge clk) 
    reg_file[rd] <= (wrEn && rd != 0) ? dIn : reg_file[rd];

  // register file read logic (combinational)
  assign r1 = (rs1 != 0 ) ? reg_file[rs1] : 0;
  assign r2 = (rs2 != 0 ) ? reg_file[rs2] : 0;
endmodule
