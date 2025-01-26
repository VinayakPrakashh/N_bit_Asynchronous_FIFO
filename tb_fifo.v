module tb_fifo;

  parameter DATA_SIZE = 4;
  parameter ADDR_SIZE = 4;

  reg wr_clk, rd_clk;
  reg wr_rst, rd_rst;
  reg wr_en, rd_en;
  reg [DATA_SIZE-1:0] wr_data;
  wire [DATA_SIZE-1:0] rd_data;
  wire full, empty;

  // Internal wires
  wire [ADDR_SIZE-1:0] wr_ptr, rd_ptr;
  wire [ADDR_SIZE:0] wr_ptr_gray, rd_ptr_gray;
  wire [ADDR_SIZE:0] wq2_ptr, rq2_wptr;
  wire [ADDR_SIZE:0] rgray_next;

  // Instantiate the FIFO top module
  fifo_top #(DATA_SIZE, ADDR_SIZE) uut (
    .wr_clk(wr_clk),
    .rd_clk(rd_clk),
    .wr_rst(wr_rst),
    .rd_rst(rd_rst),
    .wr_en(wr_en),
    .rd_en(rd_en),
    .wr_data(wr_data),
    .rd_data(rd_data),
    .full(full),
    .empty(empty)
  );

  // Assign internal wires to the uut
  assign wr_ptr = uut.wr_ptr;
  assign rd_ptr = uut.rd_ptr;
  assign wr_ptr_gray = uut.wr_ptr_gray;
  assign rd_ptr_gray = uut.rd_ptr_gray;
  assign wq2_ptr = uut.wq2_ptr;
  assign rq2_wptr = uut.rq2_wptr;
  assign rgray_next = uut.rd.rgray_next;

  // Clock generation
  always #5 wr_clk = ~wr_clk;
  always #7 rd_clk = ~rd_clk;

  initial begin
    // Initialize signals
    wr_clk = 0;
    rd_clk = 0;
    wr_rst = 1;
    rd_rst = 1;
    wr_en = 0;
    rd_en = 0;
    wr_data = 0;

    // Reset the FIFO
    #10;
    wr_rst = 0;
    rd_rst = 0;

    // Write data to the FIFO
    #10;
    wr_en = 1;
    wr_data = 4'b0001;
    #10;
    wr_en = 0;
    #10;
    wr_en = 1;
    wr_data = 4'b0010;
    #10;
    wr_en = 0;
    #10;
    wr_en = 1;
    wr_data = 4'b0011;
    #10;
    wr_en = 0;
    #10;
    wr_en = 1;
    wr_data = 4'b0100;
    #10;
    wr_en = 0;
    #10;
    wr_en = 1;
    wr_data = 4'b0101;
    #10;
    wr_en = 0;
    #10;
    wr_en = 1;
    wr_data = 4'b0110;
    #10;
    wr_en = 0;
    #10;
    wr_en = 1;
    wr_data = 4'b0111;
    #10;
    wr_en = 0;
    #10;
    wr_en = 1;
    wr_data = 4'b1000;
    #10;
    wr_en = 0;
    #10;
    wr_en = 1;
    wr_data = 4'b1001;
    #10;
    wr_en = 0;
    #10;
    wr_en = 1;
    wr_data = 4'b1010;
    #10;
    wr_en = 0;
    #10;
    wr_en = 1;
    wr_data = 4'b1011;
    #10;
    wr_en = 0;
    #10;
    wr_en = 1;
    wr_data = 4'b1100;
    #10;
    wr_en = 0;
    #10;
    wr_en = 1;
    wr_data = 4'b1101;
    #10;
    wr_en = 0;
    #10;
    wr_en = 1;
    wr_data = 4'b1110;
    #10;
    wr_en = 0;
    #10;
    wr_en = 1;
    wr_data = 4'b1111;
    #10;
    wr_en = 0;
        #10;
    wr_en = 1;
    wr_data = 4'b1110;
    #10;
    wr_en = 0;
    #10 
    rd_en=1;
    #10 rd_en =0;
    #100;
    $finish;
  end

  initial begin
    $dumpfile("tb_fifo.vcd");
    $dumpvars(0, tb_fifo);
  end

endmodule