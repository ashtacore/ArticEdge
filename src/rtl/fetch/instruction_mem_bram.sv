`timescale 1ns / 1ps

module instruction_mem_bram #(
    parameter ADDR_WIDTH = 8,
    parameter DATA_WIDTH = 32,
    parameter MEM_SIZE = 256
) (
    input  logic clk,
    input  logic enable,
    
    // Port A
    input  logic [ADDR_WIDTH-1:0] addr_a,
    input  logic [DATA_WIDTH-1:0] data_in_a,
    input  logic write_enable_a,
    output logic [DATA_WIDTH-1:0] data_out_a,
    
    // Port B
    input  logic [ADDR_WIDTH-1:0] addr_b,
    input  logic [DATA_WIDTH-1:0] data_in_b,
    input  logic write_enable_b,
    output logic [DATA_WIDTH-1:0] data_out_b
);

    // Memory declaration
    logic [DATA_WIDTH-1:0] mem [0:MEM_SIZE-1];

    // Port A
    always_ff @(posedge clk) begin
        if (write_enable_a & enable) begin
            mem[addr_a] <= data_in_a;
        end
        data_out_a <= mem[addr_a];
    end

    // Port B
    always_ff @(posedge clk) begin
        if (write_enable_b & enable) begin
            mem[addr_b] <= data_in_b;
        end
        data_out_b <= mem[addr_b];
    end

endmodule