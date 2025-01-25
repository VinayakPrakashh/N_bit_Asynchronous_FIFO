module d_ff #(parameter WIDTH = 1) (
  input clk,
  input rst,
  input [WIDTH-1:0] d,
  output reg [WIDTH-1:0] q
);

  always @(posedge clk or posedge rst) begin
    if (rst) begin
      q <= 0; // Reset condition
    end else begin
      q <= d; // Normal operation
    end
  end

endmodule