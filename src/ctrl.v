module ctrl(clk, func, mem_rw, alu_ctrl, branch_sel, zero_fl, overflow_fl, rs1_out, rs2_out, memdata_out, memaddr_in);
  output reg [0:0] branch_sel;
  input wire [0:0] zero_fl;
  input wire [0:0] overflow_fl;
  output reg [0:0] rs1_out;
  output reg [0:0] rs2_out;
  output reg [0:0] rs11_out;
  output reg [0:0] memdata_out;
  output reg [0:0] memaddr_in;
  output reg [0:0] mem_rw;
  output reg [2:0] alu_ctrl;
  input wire [0:0] clk;
  input wire [3:0] func;
  output reg [0:0] alu_flag;
  always @(negedge clk) begin
    casex(func)
      4'b0000: begin // NAND
        branch_sel = 1'b0;
        rs1_out = 1'b0;
        rs2_out = 1'b0;
        rs11_out = 1'b0;
        memaddr_in = 1'b0;
        memdata_out = 1'b0;
        mem_rw = 1'bZ;
        alu_ctrl = 3'b000;
        alu_flag = 1'b0;
      end
      4'b1000: begin // NOR
        branch_sel = 1'b0;
        rs1_out = 1'b0;
        rs2_out = 1'b0;
        rs11_out = 1'b0;
        memaddr_in = 1'b0;
        memdata_out = 1'b0;
        mem_rw = 1'bZ;
        alu_ctrl = 3'b000;
        alu_flag = 1'b1;
      end
      4'bX001: begin // BLT
        ;
      end
      4'bX101: begin // BEQ
        branch_sel = 1'b0;
        rs1_out = 1'b0;
        rs2_out = 1'b0;
        rs11_out = 1'b0;
        memaddr_in = 1'b0;
        memdata_out = 1'b0;
        mem_rw = 1'bZ;
        alu_ctrl = 3'b011;
        alu_flag = 1'b1;
        if (zero_fl)
          
      end
      4'bX010: begin // LB
        ;
      end
      4'bX110: begin // SB
        ;
      end
      4'b1011: begin // SUB
        branch_sel = 1'b0;
        rs1_out = 1'b0;
        rs2_out = 1'b0;
        rs11_out = 1'b0;
        memaddr_in = 1'b0;
        memdata_out = 1'b0;
        mem_rw = 1'bZ;
        alu_ctrl = 3'b011;
        alu_flag = 1'b1;
      end
      4'b0011: begin // ADD
        branch_sel = 1'b0;
        rs1_out = 1'b0;
        rs2_out = 1'b0;
        rs11_out = 1'b0;
        memaddr_in = 1'b0;
        memdata_out = 1'b0;
        mem_rw = 1'bZ;
        alu_ctrl = 3'b011;
        alu_flag = 1'b0;
      end
      4'b0100: begin // SRL
        branch_sel = 1'b0;
        rs1_out = 1'b0;
        rs2_out = 1'b0;
        rs11_out = 1'b0;
        memaddr_in = 1'b0;
        memdata_out = 1'b0;
        mem_rw = 1'bZ;
        alu_ctrl = 3'b100;
        alu_flag = 1'b0;
      end
      4'b1100: begin // SLL
        branch_sel = 1'b0;
        rs1_out = 1'b0;
        rs2_out = 1'b0;
        rs11_out = 1'b0;
        memaddr_in = 1'b0;
        memdata_out = 1'b0;
        mem_rw = 1'bZ;
        alu_ctrl = 3'b100;
        alu_flag = 1'b1;
      end
      4'b0111: begin // Jump
        ;
      end
      4'b1111: begin // Move
        ;
      end