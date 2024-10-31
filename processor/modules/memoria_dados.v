module memoria_dados (input wire[7:0] position, data_in, input clk, mw, r, output wire[7:0] data_out);
    parameter SIZE = 8'Hff;
    reg[7:0] ram[0:SIZE];

    integer i;
    always @(posedge clk) begin
        if (r == 1'b1) begin
            for (i = 0; i < SIZE; i = i + 1) begin
                ram[i] <= 8'b0;
            end
        end else begin
            if (mw == 1'b1) begin
                ram[position] <= data_in;
            end
        end
    end

    assign data_out = ram[position];
endmodule