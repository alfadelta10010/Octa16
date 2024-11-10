module Octa16(
input        clk, reset,
input        Ext_MemWrite,
input  [7:0] Ext_WriteData, 
input  [7:0] Ext_DataAdr,
input  [7:0] DataAdr,
output [7:0] dIn
);

wire [7:0] pcP, pcN;
wire [7:0] aluOut, pcSel, Inst, imm;
wire bSel, reg_wr, mem_wr;
wire [2:0] rs1, rs2, rd, func, opcode;
wire [7:0] r1, r2, dIn;
wire alu_s1, alu_s2, flag;
wire [2:0] alu_opl;
wire [7:0] aluOut, dataOut;
wire [1:0] wb_ctrl;
wire branch, branchOut, doBranch, doJump, bSel;
wire [2:0] branch_ctrl;


adder_8 pcAdd (.A(pcP),.B(1'b1),.Cin(1'b0),.Sum(pcN));

mux21 PC_MUX (.d0(pcN), .d1(aluOut), .sel(bSel), .y(pcSel));

regs #(8) PC (.clk(clk), .rst(reset), .in(pcSel), .out(pcP), .en(1'b1));

instmem #(12) Inst_Mem (.clk(clk), .memW(Ext_MemWrite), .addr(DataAdr), .dataW(Ext_WriteData), .dataR(Inst));

decoder Decoder_Unit (.instIn(Inst), .rs1(rs1), .rs2(rs2), .rd(rd), .func(func), .opcode(opcode), .imm(imm));

reg_ff #(8) Reg_File (.clk(clk), .wrEn(reg_wr), .rs1(rs1), .rs2(rs2), .rd(rd), .r1(r1), .r2(r2), .rst(reset), .dIn(dIn));

mux21 ALU_MUX_1 (.d0(r1), .d1(pcP), .sel(alu_s1), .y(out1));

mux21 ALU_MUX_2 (.d0(imm), .d1(r2), .sel(alu_s2), .y(out2));

alu ALU (.a(out1), .b(out2), .ctrl(alu_op), .flag(flag), .out(aluOut));

datamem #(4) Data_Mem (.clk(clk), .memW(mem_wr), .addr(aluOut), .dataW(r2), .dataR(dataOut));

mux31 #(8) WB_MUX (.a(dataOut), .b(aluOut), .c(pcN), .s(wb_ctrl), .y(dIn));

controller Control_Unit (.func(func), .op(opcode), .reg_wr(reg_wr), .mem_wr(mem_wr), .flag(flag), .doBranch(doBranch), .doJump(doJump), .wb_ctrl(wb_ctrl), .alu_op(alu_op), .branch_ctrl(branch_ctrl), .alu_s1(alu_s1), .alu_s2(alu_s2));

branchCtrl(.bCtrl(branch_ctrl), .r1(rs1), .r2(rs2), .bSel(branchOut));

and Branch (branch, branchOut, doBranch);
or Jump (bSel, branch, doJump);

assign DataAdr = Ext_MemWrite ? Ext_DataAdr : pcP;

endmodule
