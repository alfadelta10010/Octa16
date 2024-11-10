module reg_ff #(parameter DATA_WIDTH = 8) (clk, wrEn, rs1, rs2, rd, r1, r2, rst, dIn);
  input wire clk, wrEn, rst;
  input wire [2:0] rs1, rs2, rd;
  input wire [DATA_WIDTH-1:0] dIn;
  output wire [DATA_WIDTH-1:0] r1, r2;
  reg [DATA_WIDTH-1:0] reg_file [0:7];
  integer i = 0;
  initial begin
    for (i = 0; i < 8; i = i + 1) 
      begin
        reg_file[i] = 0;
      end
  end
  always @(posedge clk) begin
    if (rst) begin
      reg_file[0] <= 0;
      reg_file[1] <= 0;  // substitute with other values
      reg_file[2] <= 0;  // substitute with other values
      reg_file[3] <= 0;  // substitute with other values
      reg_file[4] <= 0;
      reg_file[5] <= 0;
      reg_file[6] <= 0;
      reg_file[7] <= 0;
    end else begin
      reg_file[rd] <= (wrEn ? dIn : ( (rd != 0) ? reg_file[rd] : 0));
    end
  end
/*
  always @(posedge clk) 
    reg_file[rd] <= (wrEn && rd != 0) ? dIn : reg_file[rd];
*/
  // register file read logic (combinational)
  assign r1 = (rs1 != 0 ) ? reg_file[rs1] : 0;
  assign r2 = (rs2 != 0 ) ? reg_file[rs2] : 0;
endmodule
