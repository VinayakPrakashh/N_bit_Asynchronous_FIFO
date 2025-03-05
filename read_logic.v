
module fifo_empty  (
    input rd_clk,
    input rd_en,
    input rd_rst,
    input [4:0] wr_ptr_addr_sync,
    output reg empty,
    output reg [4:0] rd_addr_grey,
    output  [3:0] rd_addr_bin
);
    
reg [4:0] rd_addr_bin_r;
reg empty_r;

wire empty_n;
wire [4:0] rd_addr_grey_next, rd_addr_bin_next;

always @(posedge rd_clk or negedge rd_rst) begin
    if(!rd_rst) begin
        rd_addr_bin_r <= 5'b0;
        rd_addr_grey <= 5'b0;
    end
    else begin
        rd_addr_bin_r <= rd_addr_bin_next;
        rd_addr_grey <= rd_addr_grey_next;
    end
end

assign rd_addr_bin = rd_addr_bin_r[3:0]; // read pointer

assign rd_addr_bin_next = {rd_addr_bin_r+(!empty_r & rd_en)};

assign rd_addr_grey_next = (rd_addr_bin_next >>1) ^ rd_addr_bin_next;

assign empty_n = (rd_addr_grey_next == wr_ptr_addr_sync); //empty condition

always @(posedge rd_clk or negedge rd_rst) begin
    if(!rd_rst) begin
        empty <= 1'b1;
    end
    else begin
        empty <= empty_n;
    end
end
always @(posedge rd_clk or negedge rd_rst) begin
    if (!rd_rst) begin
        empty_r <= 1'b1;
    end
    else begin
        empty_r <= empty_n;
    end
end
endmodule