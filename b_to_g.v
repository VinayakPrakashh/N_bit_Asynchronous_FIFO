module binary_to_gray (
  input  [4:0] binary,
  output  [4:0] gray
);

assign gray = binary ^ (binary >> 1);

endmodule