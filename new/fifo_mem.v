module fifo_mem #(
    DATA_SIZE = 8,
    ADDR_SIZE = 4
    MEM_DEPTH = 16
) (
    input i_wr_clk,
    input i_wr_en,
    input i_wr_rst,
    input [DATA_SIZE-1:0] i_wr_data,
    input [ADDR_SIZE-1:0] i_wr_ptr,
    input [ADDR_SIZE-1:0] i_rd_ptr,
    output  [DATA_SIZE-1:0] o_rd_data,
);
    
endmodule