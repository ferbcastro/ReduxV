module contador_de_programa (input wire[7:0] next_pc, input clk, r, output reg[7:0] curr_pc);
    always @(posedge clk) begin
        if (r == 1'b1) begin
            curr_pc <= 8'b0;
        end
        else begin
            curr_pc <= next_pc;
        end
    end
endmodule