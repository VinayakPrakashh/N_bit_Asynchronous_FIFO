module fifomem (
    input wr_clk,
    input [3:0] wr_addr,
    input [3:0] rd_addr,
    input wr_en,
    input [3:0] wr_data,
    output [3:0] rd_data
);
    
reg [3:0] mem [15:0];

assign rd_data = mem[rd_addr];

always @(posedge wr_clk) if(wr_en) mem[wr_addr] <= wr_data;

endmodule