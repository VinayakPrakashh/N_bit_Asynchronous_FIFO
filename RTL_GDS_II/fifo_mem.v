module fifo_memory (
    input clk,
    input rst,
    input wr_en,
    input full,
    input [3:0] wr_addr,
    input [3:0] rd_addr,
    input [7:0] wr_data,
    output [7:0] rd_data
);

reg [7:0] mem [15:0]; //memory array

wire wr_en_w1;

assign wr_en_w1 = (!full & wr_en); //write enable signal

always @(posedge clk or negedge rst) begin
    if(!rst) begin
        mem[0] <= 8'b0;
        mem[1] <= 8'b0;
        mem[2] <= 8'b0;
        mem[3] <= 8'b0;
        mem[4] <= 8'b0;
        mem[5] <= 8'b0;
        mem[6] <= 8'b0;
        mem[7] <= 8'b0;
        mem[8] <= 8'b0;
        mem[9] <= 8'b0;
        mem[10] <= 8'b0;
        mem[11] <= 8'b0;
        mem[12] <= 8'b0;
        mem[13] <= 8'b0;
        mem[14] <= 8'b0;
        mem[15] <= 8'b0;
    end else begin
        if(wr_en_w1) begin
            mem[wr_addr] <= wr_data; //synchronous write
        end
    end
end

assign rd_data = mem[rd_addr]; //asynchronous read

endmodule