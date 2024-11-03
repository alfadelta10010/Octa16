module reg_ff #(parameter DATA_WIDTH = 8) (
    input       clk,
    input       wr_en, rs1_en, rs2_en,
    input       [5:0] rd_addr1, rd_addr2, wr_addr,
    input       [DATA_WIDTH-1:0] wr_data,
    output      [DATA_WIDTH-1:0] rd_data1, rd_data2
);

reg [DATA_WIDTH-1:0] reg_file_arr [0:3];

// register file write logic (synchronous)
always @(posedge clk) begin
    if (wr_en) reg_file_arr[wr_addr] <= wr_data;
end

// register file read logic (combinational)
assign rd_data1 = ( rs1_en != 0 ) ? reg_file_arr[rd_addr1] : 0;
assign rd_data2 = ( rs2_en != 0 ) ? reg_file_arr[rd_addr2] : 0;

endmodule
