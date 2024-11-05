module branchCtrl(input wire [2:0] bCtrl,
                  input wire [7:0] r1, r2,
                  output reg bSel);
    wire r1sign = r1[7];
    wire r2sign = r2[7];
  always_comb
    begin
      bSel = 1'b0;
      case(bCtrl)
        3'b000: begin // BEQ
          if (r1 == r2)
            bSel = 1'b1;
          else
            bSel = 1'b0;
        end
        3'b001: begin // BNE
          if (r1 != r2)
            bSel = 1'b1;
          else
            bSel = 1'b0;
        end
        3'b010: begin // BLT
          if (r1sign != r2sign)
            bSel = r1sign;
          else
              bSel = (r1 < r2);
        end
        3'b011: begin // BLTU
          if (r1 < r2)
            bSel = 1'b1;
          else
            bSel = 1'b0;
        end
        3'b100: begin // BGE
          if (r1sign != r2sign)
            bSel = ~r1sign;
          else
            bSel = (r1 >= r2);
        end
        3'b101: begin // BGEU
          if (r1 >= r2)
            bSel = 1'b1;
          else
            bSel = 1'b0;
        end
        default: begin 
          bSel = 1'b0;
        end
      endcase
    end
endmodule