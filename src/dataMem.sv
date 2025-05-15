module dataMem #(parameter SIZE = 11) (clk, memW, addr, dataW, wrType, dataR);
    input logic clk;
    input logic memW;
    input logic [SIZE-1:0] addr;
    input logic [7:0] dataW;
    input logic [3:0] wrType;
    output logic [7:0] dataR;
    logic [7:0] mem [(2**SIZE)-1:0];
    logic [7:0] write_data_masked;

    // Generate the write data mask based on byte enable
       always_ff @(posedge clk) begin
        if (memW) begin
            mem[addr] <= write_data_masked;
        end
    end
    assign dataR = mem[addr];
endmodule
