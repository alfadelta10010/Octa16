module mux (d0, d1, sel, y);

    parameter WIDTH = 3;
    input [WIDTH-1:0] d0, d1;
    input sel;
    output [WIDTH-1:0] y;

    assign y = sel ? d1 : d0;

endmodule

