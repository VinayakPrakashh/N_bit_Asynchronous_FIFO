module sync_rst (
    input i_rst_async,
    input i_clk,
    output reg o_rst_sync
);

reg sync_rst_reg;

always @(posedge i_clk or negedge i_rst_async) begin
    if(!i_rst_async) begin
        sync_rst_reg <= 1'b0;
        o_rst_sync <= 1'b0;
    end
    else begin
        sync_rst_reg <= 1'b1;
        o_rst_sync <= sync_rst_reg;
    end
end
endmodule