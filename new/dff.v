
module dff(
    input clk,
    input rst,
    input [4:0] wr_data,
    output reg [4:0] rd_data
);

always @(posedge clk or negedge rst) begin
    if(!rst) begin
        rd_data <= 5'b0;
    end else begin
        rd_data <= wr_data;
    end
end

endmodule