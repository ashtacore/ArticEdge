`timescale 1ns / 1ps

module register #(
    parameter REG_WIDTH,
    parameter GROUNDED = 0
) (
    input logic clk,
    input logic rst_n, 
    input logic enable,
    input logic [REG_WIDTH-1:0] data_in,
    output logic [REG_WIDTH-1:0] data_out
);
    generate
        if (GROUNDED) begin : grounded_output
            assign data_out = {REG_WIDTH{1'b0}};
        end else begin : normal_register
            always_ff @(posedge clk or negedge rst_n) begin
                if (!rst_n)
                    data_out <= '0;
                else if (enable)
                    data_out <= data_in;
            end
        end
    endgenerate
endmodule