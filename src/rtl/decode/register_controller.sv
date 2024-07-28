`timescale 1ns / 1ps

module register_controller #(
    parameter REG_WIDTH = 32,
    parameter NUM_REGS = 32,
    parameter ADDR_WIDTH = $clog2(NUM_REGS),
    parameter REG_ZERO_GROUND = 0
) (
    input  logic clk,
    input  logic rst_n,
    input  logic write_enable,
    input  logic [ADDR_WIDTH-1:0] write_addr,
    input  logic [REG_WIDTH-1:0] write_data,
    input  logic [ADDR_WIDTH-1:0] read_addr_0,
    input  logic [ADDR_WIDTH-1:0] read_addr_1,
    output logic [REG_WIDTH-1:0] read_data_0,
    output logic [REG_WIDTH-1:0] read_data_1
);

    // Array to hold all register outputs
    logic [REG_WIDTH-1:0] registers [NUM_REGS-1:0];

    // Read operation
    assign read_data_0 = registers[read_addr_0];
    assign read_data_1 = registers[read_addr_1];

    // Instantiate the registers
    genvar i;
    generate
        for (i = 0; i < NUM_REGS; i++) begin : gen_regs
            register #(
                .REG_WIDTH(REG_WIDTH),
                .GROUNDED(i == 0 && REG_ZERO_GROUND)
            ) reg_inst (
                .clk(clk),
                .rst_n(rst_n),
                .enable(write_enable && (write_addr == i)),
                .data_in(write_data),
                .data_out(registers[i])
            );
        end
    endgenerate

endmodule