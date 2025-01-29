module fifo_top (
    input wr_clk,rd_clk,
    input wr_rst,rd_rst,
    input wr_en,rd_en,
    input [3:0] wr_data,
    output [3:0] rd_data,
    output full,
    output empty
);

wire [3:0] wr_ptr,rd_ptr;
wire [4:0] wr_ptr_gray,rd_ptr_gray;
wire [4:0] wq2_ptr,rq2_wptr;
wire en;

assign en = wr_en & ~full;

fifomem mem (wr_clk,wr_ptr,rd_ptr,en,wr_data,rd_data);
wr_logic wr (wr_clk,wr_en,wr_rst,wq2_ptr,wr_ptr,wr_ptr_gray,full);
rd_logic rd (rd_clk,rd_en,rd_rst,rq2_wptr,rd_ptr,rd_ptr_gray,empty);
cdc_synchronizer wr_sync (wr_clk,wr_rst,wr_ptr_gray,rq2_wptr);
cdc_synchronizer rd_sync (rd_clk,rd_rst,rd_ptr_gray,wq2_ptr);

endmodule
