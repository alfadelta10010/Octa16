module alu(
    input wire [7:0] a, b,
    input wire [2:0] ctrl,
    input wire flag,
    output reg [7:0] out, 
    output reg overflow
);

    wire [7:0] add_out;
    wire add_overflow;
    reg [7:0] a_temp, b_temp;
    reg cin;

    // Instantiate adder module
    adder_8 adder (
        .A(a_temp), 
        .B(b_temp), 
        .Cin(cin), 
        .Sum(add_out), 
        .Cout(add_overflow)
    );

    always @(*) begin
        // Default values to avoid latches
        out = 8'b0;
        overflow = 1'b0;
        a_temp = 8'b0;
        b_temp = 8'b0;
        cin = 1'b0; 

        case(ctrl)
            3'b000: begin
               a_temp = a;
                b_temp = flag ? ~b : b;
                cin = flag;
                
                out = add_out;
                overflow = (flag == 0) ? add_overflow : ((a[7] ^ b[7]) & (a[7] ^ add_out[7]));
            end

            3'b001: begin
                if (flag == 1)
                    out = ~(a & b); // NAND
                else
                    out = ~(a | b); // NOR
            end

            3'b010: begin
                out = (a < b) ? 8'b1 : 8'b0; // SLTU
            end

            3'b011: begin
                if (flag == 1)
                    out = a << b[2:0]; // SLL
                else
                    out = a >> b[2:0]; // SRL
            end

            3'b100: begin
                out = a >>> b[2:0]; // SRA
            end

            default: begin
                out = 8'b0;
                overflow = 1'b0;
            end
        endcase
    end
endmodule

