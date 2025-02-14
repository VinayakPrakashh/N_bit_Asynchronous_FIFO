module fifo #(
    DATA_SIZE = 8,
    ADDR_SIZE = 4,
    MEM_DEPTH = 16
) (
    input i_wr_clk,
    input i_wr_en,
    input i_wr_rst,
    input i_wr_rst,
    input i_rd_clk,
    input i_rd_en,
    input i_rd_rst,
    input [DATA_SIZE-1:0] i_wr_data,
    output [DATA_SIZE-1:0] o_rd_data,
    output o_full,
    output o_empty
);

wire sync_wr_rst,sync_rd_rst;

wire [ADDR_SIZE:0] wr_ptr,rd_ptr;

wire [ADDR_SIZE-1:0] wr_addr,rd_addr;

wire [ADDR_SIZE:0] wr_ptr_clx,rd_ptr_clx;

wire full,empty;

sync_rst sr_wr(i_wr_rst, i_wr_clk, sync_wr_rst);
sync_rst sr_rd(i_rd_rst, i_rd_clk, sync_rd_rst);

cdc_sync #(ADDR_SIZE) cdc_wr(i_wr_clk, sync_wr_rst, rd_ptr, rd_ptr_clx);
cdc_sync #(ADDR_SIZE) cdc_rd(i_rd_clk, sync_rd_rst, wr_ptr, wr_ptr_clx);

fifo_mem #(DATA_SIZE, ADDR_SIZE, MEM_DEPTH) mem(i_wr_clk, i_wr_en, sync_wr_rst, full, i_wr_data, wr_addr, dr_addr, o_rd_data);

fifo_full #(ADDR_SIZE) full(i_wr_clk, sync_wr_rst, i_wr_en, rd_ptr_clx, full, wr_addr, wr_ptr);

fifo_empty #(ADDR_SIZE) empty(i_rd_clk, sync_rd_rst, i_rd_en, wr_ptr_clx, empty, rd_addr, rd_ptr);
endmodule
