module reg_ff #(parameter DATA_WIDTH = 8) (
    input       clk,
    input       wr_en,
    input       [2:0] rs1, rs2, rd,
    input       [DATA_WIDTH-1:0] din,
    output      [DATA_WIDTH-1:0] r1, r2
);

reg [DATA_WIDTH-1:0] reg_file_arr [0:2];

// register file write logic (synchronous)
always @(posedge clk) begin
    if (wr_en) reg_file_arr[rd] <= din;
end

// register file read logic (combinational)
assign r1 = ( rs1 != 0 ) reg_file_arr[rs1] : 0;
assign r2 = ( rs2 != 0 ) ? reg_file_arr[rs2] : 0;

endmodule
