module cdc_synchronizer #(parameter WIDTH = 1) (
  input clk_tx,
  input rst_tx,
  input [WIDTH-1:0] data_tx,
  input clk_rx,
  input rst_rx,
  output [WIDTH-1:0] data_rx
);

  wire [WIDTH-1:0] sync1_wire;

  // Instantiate the d_ff modules for synchronization
  d_ff #(WIDTH) ff1 (
    .clk(clk_rx),
    .rst(rst_rx),
    .d(data_tx),
    .q(sync1_wire)
  );

  d_ff #(WIDTH) ff2 (
    .clk(clk_rx),
    .rst(rst_rx),
    .d(sync1_wire),
    .q(data_rx)
  );
endmodule