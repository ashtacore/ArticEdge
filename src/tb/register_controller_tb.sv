`timescale 1ns / 1ps

module register_controller_tb();

    // Parameters
    localparam REG_WIDTH = 32;
    localparam NUM_REGS = 32;
    localparam ADDR_WIDTH = $clog2(NUM_REGS);
    localparam REG_ZERO_GROUND = 1;

    // Signals
    logic clk;
    logic rst_n;
    logic write_enable;
    logic [ADDR_WIDTH-1:0] write_addr;
    logic [REG_WIDTH-1:0] write_data;
    logic [ADDR_WIDTH-1:0] read_addr_0;
    logic [ADDR_WIDTH-1:0] read_addr_1;
    logic [REG_WIDTH-1:0] read_data_0;
    logic [REG_WIDTH-1:0] read_data_1;

    // Instantiate the Unit Under Test (UUT)
    register_controller #(
        .REG_WIDTH(REG_WIDTH),
        .NUM_REGS(NUM_REGS),
        .ADDR_WIDTH(ADDR_WIDTH),
        .REG_ZERO_GROUND(REG_ZERO_GROUND)
    ) uut (
        .clk(clk),
        .rst_n(rst_n),
        .write_enable(write_enable),
        .write_addr(write_addr),
        .write_data(write_data),
        .read_addr_0(read_addr_0),
        .read_addr_1(read_addr_1),
        .read_data_0(read_data_0),
        .read_data_1(read_data_1)
    );

    // Clock generation
    always begin
        clk = 0;
        #5;
        clk = 1;
        #5;
    end

    // Test procedure
    initial begin
        // Initialize inputs
        rst_n = 0;
        write_enable = 0;
        write_addr = 0;
        write_data = 0;
        read_addr_0 = 0;
        read_addr_1 = 0;

        // Reset
        #20;
        rst_n = 1;
        #10;

        // Test 1: Write to register 1 and read it back
        write_enable = 1;
        write_addr = 1;
        write_data = 32'hDEADBEEF;
        #10;
        write_enable = 0;
        read_addr_0 = 1;
        #10;
        if (read_data_0 !== 32'hDEADBEEF) $error("Test 1 failed: Expected 32'hDEADBEEF, got %h", read_data_0);
        else $display("Test 1 passed");

        // Test 2: Attempt to write to register 0 (should remain 0 if grounded)
        write_enable = 1;
        write_addr = 0;
        write_data = 32'h12345678;
        #10;
        write_enable = 0;
        read_addr_0 = 0;
        #10;
        if (read_data_0 !== 32'h0) $error("Test 2 failed: Expected 32'h0, got %h", read_data_0);
        else $display("Test 2 passed");

        // Test 3: Write to register 31 and read it back
        write_enable = 1;
        write_addr = 31;
        write_data = 32'hAABBCCDD;
        #10;
        write_enable = 0;
        read_addr_1 = 31;
        #10;
        if (read_data_1 !== 32'hAABBCCDD) $error("Test 3 failed: Expected 32'hAABBCCDD, got %h", read_data_1);
        else $display("Test 3 passed");

        // Test 4: Read from two different registers simultaneously
        read_addr_0 = 1;  // Should still contain 32'hDEADBEEF from Test 1
        read_addr_1 = 31; // Should still contain 32'hAABBCCDD from Test 3
        #10;
        if (read_data_0 !== 32'hDEADBEEF || read_data_1 !== 32'hAABBCCDD)
            $error("Test 4 failed: Expected 32'hDEADBEEF and 32'hAABBCCDD, got %h and %h", read_data_0, read_data_1);
        else $display("Test 4 passed");

        $display("All tests completed");
        $finish;
    end

endmodule