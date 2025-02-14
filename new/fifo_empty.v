module fifo_empty #(
    ADDR_SIZE = 4
) (
    input i_rd_clk,
    input i_rd_rst,
    input i_rd_en,
    input [ADDR_SIZE:0] i_wr_ptr_clx,
    output reg o_empty,
    output [ADDR_SIZE-1:0] o_rd_addr,
    output reg [ADDR_SIZE:0] o_rd_ptr
);
    
// register declaration
reg        [ADDR_SIZE : 0]   rd_bin_r             ;    // read pointer(binary)
reg                         empty_r              ;    // empty flag reg

// wire declaration
wire       [ADDR_SIZE : 0]   rd_gray_next_s       ;    // read pointer(gray coding style)
wire                        empty_s              ;    // empty flag
wire       [ADDR_SIZE : 0]   rd_bin_next_s        ;    // read pointer(binary coding style)


always @(posedge i_rd_clk or negedge i_rd_rst) begin
    if(!i_rd_rst) begin
        rd_bin_r <= 0;
        o_rd_ptr <= 0;
    end
    else begin
        rd_bin_r <= rd_bin_next_s;
        o_rd_ptr <= rd_gray_next_s;
    end
end

assign o_rd_addr = rd_bin_r[ADDR_SIZE-1:0];

assign rd_bin_next_s  = {rd_bin_r + (i_rd_en & !empty_r)};

assign rd_gray_next_s = (rd_bin_next_s >> 1) ^ rd_bin_next_s ;

assign empty_s = (rd_gray_next_s == i_wr_ptr_clx);

always @(posedge i_rd_clk or negedge i_rd_rst) begin
    if(!i_rd_rst) begin
        o_empty <= 1;
    end
    else begin
        o_empty <= empty_s;
    end
end

always  @(posedge i_rd_clk or negedge i_rd_rst) begin
    if (!i_rd_rst) 
       empty_r <= 1'b1;
    else 
       empty_r <= empty_s;
end

endmodule