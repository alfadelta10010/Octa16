module reg_ff();
  reg clk_tb, wrEn_tb;
  reg [2:0] rd_tb;
  reg [2:0] rs1_tb;
  reg [2:0] rs2_tb;
  reg [7:0] dIn_tb;
  wire [7:0] r1_tb;
  wire [7:0] r2_tb;
  
  regFile dut (.clk(clk_tb), 
               .wr_en(wrEn_tb), 
               .rd(rd_tb), 
               .rs1(rs1_tb), 
               .rs2(rs2_tb), 
               .r1(r1_tb),
               .r2(r2_tb),
               .din(dIn_tb)
              );
  
  always begin
    clk_tb = 0;
    #5;
    clk_tb = 1;
    #5;
  end
  
  initial begin
    $dumpfile("regFile.vcd");
    $dumpvars(0, tb_regFile);
    wrEn_tb = 1'b0;
    rst_tb = 1'b1;
    rs1_tb = 3'd5;
    rs2_tb = 3'd4;
    #1 rst_tb = 1'b0;
    @(posedge clk_tb);
    wrEn_tb = 1'b1; rd_tb = 3'd0; dIn_tb = 32'hFAFAFA00; 
    @(posedge clk_tb);
    wrEn_tb = 1'b1; rd_tb = 3'd1; dIn_tb = 32'hFAFAFA01; 
    @(posedge clk_tb);
    wrEn_tb = 1'b1; rd_tb = 3'd2; dIn_tb = 32'hFAFAFA02; 
    @(posedge clk_tb);
    wrEn_tb = 1'b1; rd_tb = 3'd3; dIn_tb = 32'hFAFAFA03; 
    @(posedge clk_tb);
    wrEn_tb = 1'b1; rd_tb = 3'd4; dIn_tb = 32'hFAFAFA04; 
    @(posedge clk_tb);
    wrEn_tb = 1'b1; rd_tb = 3'd5; dIn_tb = 32'hFAFAFA05; 
    @(posedge clk_tb);
    wrEn_tb = 1'b1; rd_tb = 3'd6; dIn_tb = 32'hFAFAFA06; 
    @(posedge clk_tb);
    wrEn_tb = 1'b1; rd_tb = 3'd7; dIn_tb = 32'hFAFAFA07; 
    @(posedge clk_tb);
    wrEn_tb = 1'b0;
    dIn_tb = 8'b0;
    rd_tb = 3'b0;
    #10;
    rs1_tb = 3'b001;
    rs2_tb = 3'b010;
    #10;
    rs1_tb = 3'b011;
    rs2_tb = 3'b100;
    #10;
    rs1_tb = 3'b101;
    rs2_tb = 3'b110;
    #10;
    rs1_tb = 3'b111;
    rs2_tb = 3'b000;
    #9;
    $finish;
  end
endmodule
