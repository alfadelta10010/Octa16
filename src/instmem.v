module instmem #(parameter SIZE = 16) (clk, memW, addr, dataW, dataR);
    input wire clk;
    input wire memW;
    input wire [3:0] addr;
    input wire [15:0] dataW;
    output wire [15:0] dataR;
    reg [15:0] mem [(SIZE-1):0];

    always @(posedge clk) begin
        if (memW) begin
            mem[addr] <= dataW;
        end
    end
    assign dataR = mem[addr];
endmodule
