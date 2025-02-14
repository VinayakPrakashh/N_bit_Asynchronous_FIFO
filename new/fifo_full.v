module fifo_full #(
    ADDRSIZE    = 4
) (
    input i_wr_clk,
    input i_wr_rst,
    input i_wr_en,
    input [ADDRSIZE:0] i_rd_ptr_clx,
    output reg o_full,
    output [ADDRSIZE-1:0] o_wr_addr,
    output reg [ADDRSIZE:0] o_wr_ptr
);

// register declaration
reg        [ADDRSIZE : 0]   wr_bin_r             ;    // write pointer(binary)
reg                         full_r               ;    // full flag reg

// wire declaration
wire       [ADDRSIZE : 0]   wr_gray_next_s       ;    // write pointer(gray coding style)
wire       [ADDRSIZE : 0]   wr_bin_next_s        ;    // write pointer(binary coding style)
wire                        full_s               ;    // full flag wire

always @(posedge i_wr_clk or negedge i_wr_rst) begin
    if(!i_wr_rst) begin
        wr_bin_r <= 0;
        o_wr_ptr <= 0;
    end
    else begin
        wr_bin_r <= wr_bin_next_s;
        o_wr_ptr <= wr_gray_next_s;
    end
end

assign o_wr_addr = wr_bin_r[ADDRSIZE-1:0];

assign wr_bin_next_s  = {wr_bin_r + (i_wr_en & !full_r)};

assign wr_gray_next_s = (wr_bin_next_s >> 1) ^ wr_bin_next_s ;

assign full_s = (wr_gray_next_s == i_rd_ptr_clx);

assign full_s         = ((wr_gray_next_s[ADDRSIZE]     != i_rd_ptr_clx[ADDRSIZE] ) &&
                         (wr_gray_next_s[ADDRSIZE-1]   != i_rd_ptr_clx[ADDRSIZE-1]) &&
                         (wr_gray_next_s[ADDRSIZE-2:0] == i_rd_ptr_clx[ADDRSIZE-2:0]));

always @(posedge i_wr_clk or negedge i_wr_rst) begin
    if(!i_wr_rst) begin
        o_full <= 0;
    end
    else begin
        o_full <= full_s;
    end
    end
always @(posedge i_wr_clk or negedge i_wr_rst)
begin 
   if (!i_wr_rst) 
      full_r <= 1'b0                                                                         ;
   else 
      full_r <= full_s                                                                       ;
end

endmodule