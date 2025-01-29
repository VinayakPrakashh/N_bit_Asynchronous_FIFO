    module d_ff (
      input clk,
      input rst,
      input [4:0] d,
      output reg [4:0] q
    );
    
      always @(posedge clk or posedge rst) begin
        if (rst) begin
          q <= 0; // Reset condition
        end else begin
          q <= d; // Normal operation
        end
      end
    
    endmodule
