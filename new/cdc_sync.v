module cdc_sync #(ADDR_SIZE = 4)(
    input i_clk,
    input i_rst_async,
    input [ADDR_SIZE:0] i_ptr,
    output reg [ADDR_SIZE:0] o_ptr
);
    
reg [ADDR_SIZE:0] ptr_reg;

always @(posedge i_clk or negedge i_rst_async) begin
    if(!i_rst_async) begin
        ptr_reg <= 0;
        o_ptr <= 0;
    end
    else begin
        ptr_reg <= i_ptr;
        o_ptr <= ptr_reg;
    end
end

endmodule