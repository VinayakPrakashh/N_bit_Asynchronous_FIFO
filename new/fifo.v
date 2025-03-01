`timescale 1ns/1ps
module fifo_top (
    input wr_clk,
    input rd_clk,
    input wr_en,
    input rd_en,
    input wr_rst,
    input rd_rst,
    input [7:0] wr_data,
    output [7:0] rd_data,
    output  empty,
    output  full
);
    
wire [4:0] wr_addr_grey_sync, rd_addr_grey_sync;
wire [4:0] wr_addr_grey, rd_addr_grey;
wire [3:0] wr_addr, rd_addr;
fifo_full f(wr_clk, wr_en, wr_rst, rd_addr_grey_sync, full, wr_addr_grey, wr_addr);
fifo_empty e(rd_clk, rd_en, rd_rst, wr_addr_grey_sync, empty, rd_addr_grey, rd_addr);

cdc_synchronizer wr_addr_sync(wr_clk, wr_rst, rd_addr_grey, rd_addr_grey_sync);
cdc_synchronizer rd_addr_sync(rd_clk, rd_rst, wr_addr_grey, wr_addr_grey_sync);

fifo_memory m(wr_clk, wr_rst, wr_en, full, wr_addr, rd_addr, wr_data, rd_data);

endmodule
