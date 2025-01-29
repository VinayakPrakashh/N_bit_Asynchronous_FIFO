module rd_logic (
    input rd_clk,
    input rd_en,
    input rd_rst,
    input [4:0] rq2_wptr,
    output [3:0] rd_ptr,
    output reg [4:0] rd_ptr_gray,
    output reg empty
);
    
reg [4:0] rbin;         // Binary read pointer

wire [4:0] rgray_next, rbin_next;   // Next read pointer in gray and binary code
wire rempty_val;

always @(posedge rd_clk or posedge rd_rst) begin
    if(rd_rst) begin
         {rbin, rd_ptr_gray} <= 0;
         empty <= 1;
    end
    else  begin
        {rbin, rd_ptr_gray} <= {rbin_next, rgray_next}; // Shift the read pointer
        empty <= rempty_val;
    end
end

assign rd_ptr = rbin[3:0];
assign rbin_next = rbin + (rd_en & ~empty);
assign rempty_val = (rgray_next == rq2_wptr);

binary_to_gray b2g(rbin_next,rgray_next);

endmodule