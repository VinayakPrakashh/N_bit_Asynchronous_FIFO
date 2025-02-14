module fifo_mem #(
    DATA_SIZE = 8,
    ADDR_SIZE = 4,
    MEM_DEPTH = 16
) (
    input i_wr_clk,
    input i_wr_en,
    input i_wr_rst,
    input i_full,
    input [DATA_SIZE-1:0] i_wr_data,
    input [ADDR_SIZE-1:0] i_wr_addr,
    input [ADDR_SIZE-1:0] i_rd_addr,
    output  [DATA_SIZE-1:0] o_rd_data
);
    

reg [DATA_SIZE-1:0] mem [MEM_DEPTH-1:0];

wire we_en_r;

assign we_en_r = i_wr_en & !i_full;

always @(posedge i_wr_clk or negedge i_wr_rst) begin
    if(!i_wr_rst) begin
        mem[0] <= 0;
        mem[1] <= 0;
        mem[2] <= 0;
        mem[3] <= 0;
        mem[4] <= 0;
        mem[5] <= 0;
        mem[6] <= 0;
        mem[7] <= 0;
        mem[8] <= 0;
        mem[9] <= 0;
        mem[10] <= 0;
        mem[11] <= 0;
        mem[12] <= 0;
        mem[13] <= 0;
        mem[14] <= 0;
        mem[15] <= 0;
    end
    else begin
        if(we_en_r) begin
            mem[i_wr_addr] <= i_wr_data;
        end
    end
end
assign o_rd_data = mem[i_rd_addr];

endmodule