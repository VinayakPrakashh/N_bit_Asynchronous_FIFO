
module cdc_synchronizer(
    input clk,
    input rst,
    input [4:0] in_data,
    output [4:0] out_data
);

wire [4:0] in_data_n;

dff dff_1(
    .clk(clk),
    .rst(rst),
    .wr_data(in_data),
    .rd_data(in_data_n)
);
dff dff_2(
    .clk(clk),
    .rst(rst),
    .wr_data(in_data_n),
    .rd_data(out_data)
);
endmodule