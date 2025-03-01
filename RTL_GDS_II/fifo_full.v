`timescale 1ns/1ps
module fifo_full (
    input wr_clk,
    input wr_en,
    input wr_rst,
    input [4:0] rd_ptr_addr_sync,
    output reg full,
    output reg [4:0] wr_addr_grey,
    output  [3:0] wr_addr_bin
);

reg [4:0] wr_addr_bin_r;
reg full_r;

wire full_n;
wire [4:0] wr_addr_grey_next;
wire [4:0] wr_addr_binary_next;

always @(posedge wr_clk or negedge wr_rst) begin
    if(!wr_rst) begin
        wr_addr_bin_r <= 5'b0;
        wr_addr_grey <= 5'b0;
    end
    else begin
        wr_addr_bin_r <= wr_addr_binary_next;
        wr_addr_grey <= wr_addr_grey_next;
    end
end

assign wr_addr_bin = wr_addr_bin_r[3:0]; // write pointer

assign wr_addr_binary_next = {wr_addr_bin_r+(!full_r & wr_en)};

assign wr_addr_grey_next = (wr_addr_binary_next >>1) ^ wr_addr_binary_next;

assign full_n         = ((wr_addr_grey_next[4]     != rd_ptr_addr_sync[4] ) &&
                         (wr_addr_grey_next[3]   != rd_ptr_addr_sync[3]) &&
                         (wr_addr_grey_next[2:0] == rd_ptr_addr_sync[2:0]))       ;                   
always @(posedge wr_clk or negedge wr_rst) begin
    if(!wr_rst) begin
        full <= 1'b0;
    end
    else begin
        full <= full_n;
    end
end
always @(posedge wr_clk or negedge wr_rst) begin
    if (!wr_rst) begin
        full_r <= 1'b0;
    end
    else begin
        full_r <= full_n;
    end
end
endmodule