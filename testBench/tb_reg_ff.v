/*
module tb_reg_ff();
  reg clk_tb, wrEn_tb;
  reg [2:0] rd_tb;
  reg [2:0] rs1_tb;
  reg [2:0] rs2_tb;
  reg [7:0] dIn_tb;
  wire [7:0] r1_tb;
  wire [7:0] r2_tb;
  
  reg_ff dut (.clk(clk_tb), 
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
    
    wrEn_tb = 1'b0;

    rs1_tb = 3'd0;
    rs2_tb = 3'd0;
    $monitor("Time = %0t, rs1 = %b, rs2 = %b, rd = %b, wrEn = %b, dataIn = %b, r1 = %b, r2 = %b", $time, rs1_tb, rs2_tb, rd_tb, wrEn_tb, dIn_tb, r1_tb, r2_tb);
    @(posedge clk_tb);
    wrEn_tb = 1'b1; rd_tb = 3'd0; dIn_tb = 8'hBC; 
    @(posedge clk_tb);
    wrEn_tb = 1'b1; rd_tb = 3'd1; dIn_tb = 8'hAB; 
    @(posedge clk_tb);
    wrEn_tb = 1'b1; rd_tb = 3'd2; dIn_tb = 8'h03; 
    @(posedge clk_tb);
    wrEn_tb = 1'b1; rd_tb = 3'd3; dIn_tb = 8'h5A; 
    @(posedge clk_tb);
    wrEn_tb = 1'b1; rd_tb = 3'd4; dIn_tb = 8'h6B; 
    @(posedge clk_tb);
    wrEn_tb = 1'b1; rd_tb = 3'd5; dIn_tb = 8'h3F; 
    @(posedge clk_tb);
    wrEn_tb = 1'b1; rd_tb = 3'd6; dIn_tb = 8'h7C; 
    @(posedge clk_tb);
    wrEn_tb = 1'b1; rd_tb = 3'd7; dIn_tb = 8'h2D; 
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
*/
module tb_regFile();
  reg clk_tb, wrEn_tb, rst_tb;
  reg [2:0] rd_tb;
  reg [2:0] rs1_tb;
  reg [2:0] rs2_tb;
  reg [7:0] dIn_tb;
  wire [7:0] r1_tb;
  wire [7:0] r2_tb;
  
  reg_ff dut (.clk(clk_tb), 
               .wrEn(wrEn_tb), 
               .rd(rd_tb), 
               .rs1(rs1_tb), 
               .rs2(rs2_tb), 
               .r1(r1_tb),
               .r2(r2_tb),
               .dIn(dIn_tb),
               .rst(rst_tb)
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
    rs1_tb = 3'd6;
    rs2_tb = 3'd5;
    #1 rst_tb = 1'b0;
    @(posedge clk_tb);
    wrEn_tb = 1'b1; rd_tb = 3'd0; dIn_tb = 8'hA0; 
    @(posedge clk_tb);
    wrEn_tb = 1'b1; rd_tb = 3'd1; dIn_tb = 8'hF1; 
    @(posedge clk_tb);
    wrEn_tb = 1'b1; rd_tb = 3'd2; dIn_tb = 8'hFA; 
    @(posedge clk_tb);
    wrEn_tb = 1'b1; rd_tb = 3'd3; dIn_tb = 8'h03; 
    @(posedge clk_tb);
    wrEn_tb = 1'b1; rd_tb = 3'd4; dIn_tb = 8'hD3; 
    @(posedge clk_tb);
    wrEn_tb = 1'b1; rd_tb = 3'd5; dIn_tb = 8'hA5; 
    @(posedge clk_tb);
    wrEn_tb = 1'b1; rd_tb = 3'd6; dIn_tb = 8'h06; 
    @(posedge clk_tb);
    wrEn_tb = 1'b1; rd_tb = 3'd7; dIn_tb = 8'h07;  
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
    rs2_tb = 3'b011;
    #10;
    rs1_tb = 3'b101;
    rs2_tb = 3'b010;
    #10;
    rs1_tb = 3'b111;
    rs2_tb = 3'b110;
    #10;
    #10;
    rst_tb = 1'b1;
    #1;
    rst_tb = 1'b0;
    #9;
    $finish;
  end
endmodule
