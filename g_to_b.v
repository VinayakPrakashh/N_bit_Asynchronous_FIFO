module gray_to_binary #(parameter WIDTH = 4) (
  input [WIDTH-1:0] gray,
  output [WIDTH-1:0] bin
);

  assign bin[WIDTH-1] = gray[WIDTH-1]; // MSB is the same

  genvar i;
  generate
    for (i = WIDTH-2; i >= 0; i = i - 1) begin : gen_bin
      assign bin[i] = gray[i] ^ bin[i+1]; // XOR with the next higher bit of bin
    end
  endgenerate

endmodule