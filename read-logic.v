module rd_logic #(
    ADDR_SIZE = 4
) (
    input rd_clk,
    input rd_en,
    input rd_rst,
    input [ADDR_SIZE:0] rq2_wptr,
    output [ADDR_SIZE-1:0] rd_ptr,
    output reg [ADDR_SIZE:0] rd_ptr_gray,
    output reg empty
);
    
always @(posedge rd_clk or posedge rd_rst) begin
    
end

endmodule