`timescale 1ns/1ps
module reset_sync(
    input clk,
    input rst,
    output reg rst_sync
);

reg rst_sync_reg;

always @(posedge clk or negedge rst) begin
    if(!rst) begin
        rst_sync_reg <= 1'b0;
        rst_sync <= 1'b0;

    end else begin
        rst_sync_reg <= 1'b1;
        rst_sync <= rst_sync_reg;
    end
end
endmodule