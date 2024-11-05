module adder_8(
    input [7:0] A,
    input [7:0] B,
    input Cin,
    output [7:0] Sum
);

    wire C4;  // Carry between lower and upper 4-bit additions
    wire Cout;
    // Instantiate lower 4-bit CLA
    cla lower_4bit (
        .A(A[3:0]), 
        .B(B[3:0]), 
        .Cin(Cin), 
        .S(Sum[3:0]), 
        .Cout(C4)
    );

    // Instantiate upper 4-bit CLA with carry-in from the lower 4-bit adder
    cla upper_4bit (
        .A(A[7:4]), 
        .B(B[7:4]), 
        .Cin(C4), 
        .S(Sum[7:4]), 
        .Cout(Cout)
    );

endmodule

