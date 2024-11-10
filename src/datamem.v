module datamem #(parameter SIZE = 4) (clk, memW, addr, dataW, dataR);
    input wire clk;
    input wire memW;
    input wire [SIZE-1:0] addr;
    input wire [7:0] dataW;
    output wire [7:0] dataR;
    reg [7:0] mem [(SIZE-1):0];

    always @(posedge clk) begin
        if (memW) begin
            mem[addr] <= dataW;
        end
    end
    assign dataR = mem[addr];
endmodule
