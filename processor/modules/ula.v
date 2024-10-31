module ula (input wire[7:0] s_ra, s_rb, input wire[3:0] op, output wire[7:0] s, output wire zero);
    wire[7:0] not_b, and_b, or_b, xor_b, sum, inc, sub, slr, slf, srr;

    assign zero = ~|s_ra;

    assign not_b = ~s_rb;
    assign and_b = s_ra & s_rb;
    assign or_b = s_ra | s_rb;
    assign xor_b = s_ra ^ s_rb;
    assign sum = s_ra + s_rb;
    assign inc = s_rb + 8'b1;
    assign sub = s_ra - s_rb;
    assign slr = s_ra << s_rb;
    assign slf = s_rb << 8'b100;
    assign srr = s_ra >> s_rb;

    assign s = (op[2:0] == 3'b000) ? not_b : 
               (op[2:0] == 3'b001) ? and_b :
               (op[2:0] == 3'b010) ? or_b :
               (op[2:0] == 3'b011) ? xor_b :
               (op[2:0] == 3'b100) ? (op[3] == 1'b1) ? inc : sum :
               (op[2:0] == 3'b101) ? sub :
               (op[2:0] == 3'b110) ? (op[3] == 1'b1) ? slf : slr : srr;
endmodule