`timescale 1ns / 1ps

module full_adder(
    input a,
    input b,
    input cin,
    output sum,
    output cout
);

    assign sum = a ^ b ^ cin;
    assign cout = (a & b) | (cin & a) | (cin & b);
    // Here is a slightly faster implementation of calculating cout:
    // assign cout = (a & b) | (cin & (a ^ b));
    // This allows us to reuse the (a ^ b) calculation, 

endmodule