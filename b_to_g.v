module binary_to_gray #(parameter N = 8) (
  input  [N-1:0] binary,
  output  [N-1:0] gray
);

assign gray = binary ^ (binary >> 1);

endmodule