module banco_registradores (input wire[7:0] dado, input wire[1:0] ra, rb, input clk, r,
                            rw, output wire[7:0] s_ra, s_rb);
    parameter SIZE = 4;
    reg [7:0] bank [SIZE:0];

    always @(posedge clk) begin
        if (r == 1'b1) begin
            bank[0] <= 8'b0;
            bank[1] <= 8'b0;
            bank[2] <= 8'b0;
            bank[3] <= 8'b0;
        end else begin
            if (rw == 1'b1) begin
                bank[ra] <= dado;
            end
        end
    end

    assign s_ra = bank[ra];
    assign s_rb = bank[rb];
endmodule