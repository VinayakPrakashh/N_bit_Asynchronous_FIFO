module wr_logic (
    input wr_clk,
    input wr_en,
    input wr_rst,
    input [4:0] wq2_ptr,
    output [3:0] wr_ptr,
    output reg [4:0] wr_ptr_gray,
    output reg full
);

   reg [4:0] wbin;         // Binary write pointer

   wire [4:0] wgray_next, wbin_next;   // Next write pointer in gray and binary code
   wire wfull_val;   

 always @(posedge wr_clk or posedge wr_rst) begin
    if(wr_rst) begin
         {wbin, wr_ptr_gray} <= 0;
         full <= 0;
    end
    else  begin
        {wbin, wr_ptr_gray} <= {wbin_next, wgray_next}; // Shift the write pointer
        full <= wfull_val;
    end
 end   
assign wr_ptr = wbin[3:0];
assign wbin_next = wbin + (wr_en & ~full);
assign wfull_val = (wgray_next == {~wq2_ptr[4:3],wq2_ptr[2:0]});

binary_to_gray b2g(wbin_next,wgray_next);

endmodule