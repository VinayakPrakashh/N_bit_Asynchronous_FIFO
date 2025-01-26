module cdc_synchronizer #(parameter WIDTH = 4) (
  input clk,
  input rst,
  input [WIDTH-1:0] data_in,
  output [WIDTH-1:0] data

);

  wire [WIDTH-1:0] sync1_wire;

  // Instantiate the d_ff modules for synchronization
  d_ff #(WIDTH) ff1 (
    .clk(clk),
    .rst(rst),
    .d(data_in),
    .q(sync1_wire)
  );

  d_ff #(WIDTH) ff2 (
    .clk(clk),
    .rst(rst),
    .d(sync1_wire),
    .q(data)
  );
endmodule