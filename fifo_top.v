module fifo_top #(
    parameter DATA_SIZE = 4,ADDR_SIZE = 4
) (
    input wr_clk,rd_clk,
    input wr_rst,rd_rst,
    input wr_en,rd_en,
    input [DATA_SIZE-1:0] wr_data,
    output [DATA_SIZE-1:0] rd_data,
    output full,
    output empty
);

wire [ADDR_SIZE-1:0] wr_ptr,rd_ptr;
wire [ADDR_SIZE:0] wr_ptr_gray,rd_ptr_gray;
wire [ADDR_SIZE:0] wq2_ptr,rq2_wptr;

assign en = wr_en & ~full;

fifomem #(DATA_SIZE,ADDR_SIZE) mem (wr_clk,wr_ptr,rd_ptr,en,wr_data,rd_data);
wr_logic #(ADDR_SIZE) wr (wr_clk,wr_en,wr_rst,wq2_ptr,wr_ptr,wr_ptr_gray,full);
rd_logic #(ADDR_SIZE) rd (rd_clk,rd_en,rd_rst,rq2_wptr,rd_ptr,rd_ptr_gray,empty);
cdc_synchronizer #(ADDR_SIZE+1) wr_sync (wr_clk,wr_rst,wr_ptr_gray,rq2_wptr);
cdc_synchronizer #(ADDR_SIZE+1) rd_sync (rd_clk,rd_rst,rd_ptr_gray,wq2_ptr);
endmodule
