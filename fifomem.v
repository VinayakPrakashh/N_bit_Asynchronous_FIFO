module fifomem #(
    parameter DATA_SIZE = 4,
    parameter ADDR_SIZE = 4
) (
    input wr_clk,
    input [ADDR_SIZE-1:0] wr_addr,
    input [ADDR_SIZE-1:0] rd_addr,
    input wr_en,
    input [DATA_SIZE-1:0] wr_data,
    output [DATA_SIZE-1:0] rd_data
);
    
reg [DATA_SIZE-1:0] mem [(1<<ADDR_SIZE)-1:0];
//reg [DATA_SIZE-1:0] mem [1:0];

assign rd_data = mem[rd_addr];

always @(posedge wr_clk) if(wr_en) mem[wr_addr] <= wr_data;

endmodule