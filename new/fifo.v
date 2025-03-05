
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
fifo_full f(.wr_clk(wr_clk), .wr_en(wr_en), .wr_rst(wr_rst), .rd_ptr_addr_sync(rd_addr_grey_sync), .full(full), .wr_addr_grey(wr_addr_grey), .wr_addr_bin(wr_addr));
fifo_empty e(.rd_clk(rd_clk), .rd_en(rd_en), .rd_rst(rd_rst), .wr_ptr_addr_sync(wr_addr_grey_sync), .empty(empty), .rd_addr_grey(rd_addr_grey), .rd_addr_bin(rd_addr));

cdc_synchronizer wr_addr_sync(.clk(wr_clk), .rst(wr_rst), .in_data(rd_addr_grey), .out_data(rd_addr_grey_sync));
cdc_synchronizer rd_addr_sync(.clk(rd_clk), .rst(rd_rst), .in_data(wr_addr_grey), .out_data(wr_addr_grey_sync));

fifo_memory m(.clk(wr_clk), .rst(wr_rst), .wr_en(wr_en), .full(full), .wr_addr(wr_addr), .rd_addr(rd_addr), .wr_data(wr_data), .rd_data(rd_data));

endmodule
