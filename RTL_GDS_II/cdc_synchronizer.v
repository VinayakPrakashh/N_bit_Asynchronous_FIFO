`timescale 1ns/1ps
module cdc_synchronizer(
    input clk,
    input rst,
    input [4:0] in_data,
    output [4:0] out_data
);

wire [4:0] in_data_n;

dff dff_1(clk, rst, in_data, in_data_n);
dff dff_2(clk, rst, in_data_n, out_data);
endmodule
