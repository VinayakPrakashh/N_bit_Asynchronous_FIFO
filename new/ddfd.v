module fifo_top (
    input wr_clk_pad,
    input rd_clk_pad,
    input wr_en_pad,
    input rd_en_pad,
    input wr_rst_pad,
    input rd_rst_pad,
    input [7:0] wr_data_pad,
    output [7:0] rd_data_pad,
    output  empty_pad,
    output  full_pad
);

wire read_clk,write_clk,wr_clk,rd_clk;
wire wr_en,rd_en,wr_rst,rd_rst;
wire [7:0] wr_data,rd_data;
wire full,empty;


pc3d01 pc3d01_1(.PAD (rd_clk_pad), .CIN (read_clk)); 
pc3c01 pc3c01_1(.CCLK (read_clk), .CP (rd_clk)); 

pc3d01 pc3d01_2(.PAD (wr_clk_pad), .CIN (write_clk)); 
pc3c01 pc3c01_2(.CCLK (write_clk), .CP (wr_clk)); 


pc3d01 pc3d01_3(.PAD (wr_rst_pad), .CIN (wr_rst)); 
pc3d01 pc3d01_4(.PAD (rd_rst_pad), .CIN (rd_rst)); 
pc3d01 pc3d01_5(.PAD (wr_en_pad), .CIN (wr_en)); 
pc3d01 pc3d01_6(.PAD (rd_en_pad), .CIN (rd_en)); 

pc3d01 pc3d01_7(.PAD (wr_data_pad[7]), .CIN (wr_data[7])); 
pc3d01 pc3d01_8(.PAD (wr_data_pad[6]), .CIN (wr_data[6])); 
pc3d01 pc3d01_9(.PAD (wr_data_pad[5]), .CIN (wr_data[5])); 
pc3d01 pc3d01_10(.PAD (wr_data_pad[4]), .CIN (wr_data[4])); 
pc3d01 pc3d01_11(.PAD (wr_data_pad[3]), .CIN (wr_data[3])); 
pc3d01 pc3d01_12(.PAD (wr_data_pad[2]), .CIN (wr_data[2])); 
pc3d01 pc3d01_13(.PAD (wr_data_pad[1]), .CIN (wr_data[1])); 
pc3d01 pc3d01_14(.PAD (wr_data_pad[0]), .CIN (wr_data[0])); 

pc3o05 pc3o05_1(.I (rd_data[7]), .PAD (rd_data_pad[7])); 
pc3o05 pc3o05_2(.I (rd_data[6]), .PAD (rd_data_pad[6])); 
pc3o05 pc3o05_3(.I (rd_data[5]), .PAD (rd_data_pad[5])); 
pc3o05 pc3o05_4(.I (rd_data[4]), .PAD (rd_data_pad[4])); 
pc3o05 pc3o05_5(.I (rd_data[3]), .PAD (rd_data_pad[3])); 
pc3o05 pc3o05_6(.I (rd_data[2]), .PAD (rd_data_pad[2])); 
pc3o05 pc3o05_7(.I (rd_data[1]), .PAD (rd_data_pad[1])); 
pc3o05 pc3o05_8(.I (rd_data[0]), .PAD (rd_data_pad[0])); 
pc3o05 pc3o05_9(.I (full), .PAD (full_pad)); 
pc3o05 pc3o05_10(.I (empty), .PAD (empty_pad)); 


wire [4:0] wr_addr_grey_sync, rd_addr_grey_sync;
wire [4:0] wr_addr_grey, rd_addr_grey;
wire [3:0] wr_addr, rd_addr;
fifo_full f(.wr_clk(wr_clk), .wr_en(wr_en), .wr_rst(wr_rst), .rd_ptr_addr_sync(rd_addr_grey_sync), .full(full), .wr_addr_grey(wr_addr_grey), .wr_addr_bin(wr_addr));
fifo_empty e(.rd_clk(rd_clk), .rd_en(rd_en), .rd_rst(rd_rst), .wr_ptr_addr_sync(wr_addr_grey_sync), .empty(empty), .rd_addr_grey(rd_addr_grey), .rd_addr_bin(rd_addr));

cdc_synchronizer wr_addr_sync(.clk(wr_clk), .rst(wr_rst), .in_data(rd_addr_grey), .out_data(rd_addr_grey_sync));
cdc_synchronizer rd_addr_sync(.clk(rd_clk), .rst(rd_rst), .in_data(wr_addr_grey), .out_data(wr_addr_grey_sync));

fifo_memory m(.clk(wr_clk), .rst(wr_rst), .wr_en(wr_en), .full(full), .wr_addr(wr_addr), .rd_addr(rd_addr), .wr_data(wr_data), .rd_data(rd_data));

endmodule

module fifo_full (
    input wr_clk,
    input wr_en,
    input wr_rst,
    input [4:0] rd_ptr_addr_sync,
    output reg full,
    output reg [4:0] wr_addr_grey,
    output  [3:0] wr_addr_bin
);

reg [4:0] wr_addr_bin_r;
reg full_r;

wire full_n;
wire [4:0] wr_addr_grey_next;
wire [4:0] wr_addr_binary_next;

always @(posedge wr_clk or negedge wr_rst) begin
    if(!wr_rst) begin
        wr_addr_bin_r <= 5'b0;
        wr_addr_grey <= 5'b0;
    end
    else begin
        wr_addr_bin_r <= wr_addr_binary_next;
        wr_addr_grey <= wr_addr_grey_next;
    end
end

assign wr_addr_bin = wr_addr_bin_r[3:0]; // write pointer

assign wr_addr_binary_next = {wr_addr_bin_r+(!full_r & wr_en)};

assign wr_addr_grey_next = (wr_addr_binary_next >>1) ^ wr_addr_binary_next;

assign full_n         = ((wr_addr_grey_next[4]     != rd_ptr_addr_sync[4] ) &&
                         (wr_addr_grey_next[3]   != rd_ptr_addr_sync[3]) &&
                         (wr_addr_grey_next[2:0] == rd_ptr_addr_sync[2:0]))       ;                   
always @(posedge wr_clk or negedge wr_rst) begin
    if(!wr_rst) begin
        full <= 1'b0;
    end
    else begin
        full <= full_n;
    end
end
always @(posedge wr_clk or negedge wr_rst) begin
    if (!wr_rst) begin
        full_r <= 1'b0;
    end
    else begin
        full_r <= full_n;
    end
end
endmodule

module fifo_empty  (
    input rd_clk,
    input rd_en,
    input rd_rst,
    input [4:0] wr_ptr_addr_sync,
    output reg empty,
    output reg [4:0] rd_addr_grey,
    output  [3:0] rd_addr_bin
);
    
reg [4:0] rd_addr_bin_r;
reg empty_r;

wire empty_n;
wire [4:0] rd_addr_grey_next, rd_addr_bin_next;

always @(posedge rd_clk or negedge rd_rst) begin
    if(!rd_rst) begin
        rd_addr_bin_r <= 5'b0;
        rd_addr_grey <= 5'b0;
    end
    else begin
        rd_addr_bin_r <= rd_addr_bin_next;
        rd_addr_grey <= rd_addr_grey_next;
    end
end

assign rd_addr_bin = rd_addr_bin_r[3:0]; // read pointer

assign rd_addr_bin_next = {rd_addr_bin_r+(!empty_r & rd_en)};

assign rd_addr_grey_next = (rd_addr_bin_next >>1) ^ rd_addr_bin_next;

assign empty_n = (rd_addr_grey_next == wr_ptr_addr_sync); //empty condition

always @(posedge rd_clk or negedge rd_rst) begin
    if(!rd_rst) begin
        empty <= 1'b1;
    end
    else begin
        empty <= empty_n;
    end
end
always @(posedge rd_clk or negedge rd_rst) begin
    if (!rd_rst) begin
        empty_r <= 1'b1;
    end
    else begin
        empty_r <= empty_n;
    end
end
endmodule
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

module dff(
    input clk,
    input rst,
    input [4:0] wr_data,
    output reg [4:0] rd_data
);

always @(posedge clk or negedge rst) begin
    if(!rst) begin
        rd_data <= 5'b0;
    end else begin
        rd_data <= wr_data;
    end
end

endmodule


module cdc_synchronizer(
    input clk,
    input rst,
    input [4:0] in_data,
    output [4:0] out_data
);

wire [4:0] in_data_n;

dff dff_1(
    .clk(clk),
    .rst(rst),
    .wr_data(in_data),
    .rd_data(in_data_n)
);
dff dff_2(
    .clk(clk),
    .rst(rst),
    .wr_data(in_data_n),
    .rd_data(out_data)
);
endmodule