module cdc_synchronizer (
  input clk,
  input rst,
  input [4:0] data_in,
  output [4:0] data
);

  wire [4:0] sync1_wire;

  // Instantiate the d_ff modules for synchronization
  d_ff ff1 (
    .clk(clk),
    .rst(rst),
    .d(data_in),
    .q(sync1_wire)
  );

  d_ff ff2 (
    .clk(clk),
    .rst(rst),
    .d(sync1_wire),
    .q(data)
  );
endmodule