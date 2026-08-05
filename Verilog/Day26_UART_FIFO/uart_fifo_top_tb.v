`timescale 1ns/1ps

module uart_fifo_top_tb;

reg clk;
reg reset;

reg wr_en;
reg rd_en;

reg [7:0] tx_data;

wire tx;
wire [7:0] rx_data;

wire fifo_full;
wire fifo_empty;

wire tx_busy;
wire rx_done;

//=====================================
// DUT
//=====================================

uart_fifo_top dut
(
    .clk(clk),
    .reset(reset),

    .wr_en(wr_en),
    .rd_en(rd_en),

    .tx_data(tx_data),

    .tx(tx),
    .rx(tx),          // Internal Loopback

    .rx_data(rx_data),

    .fifo_full(fifo_full),
    .fifo_empty(fifo_empty),

    .tx_busy(tx_busy),
    .rx_done(rx_done)
);

//=====================================
// Clock
//=====================================

always #10 clk = ~clk;

initial
begin

    clk = 0;
    reset = 1;

    wr_en = 0;
    rd_en = 0;

    tx_data = 8'h00;

    $dumpfile("uart_fifo_top.vcd");
    $dumpvars(0, uart_fifo_top_tb);

    $monitor(
        "T=%0t WR=%b RD=%b TX=%h RX=%h FULL=%b EMPTY=%b BUSY=%b DONE=%b",
        $time,
        wr_en,
        rd_en,
        tx_data,
        rx_data,
        fifo_full,
        fifo_empty,
        tx_busy,
        rx_done
    );

    #40;
    reset = 0;
        //-------------------------------------
    // Write one byte into FIFO
    //-------------------------------------

    @(posedge clk);
    tx_data = 8'hA5;
    wr_en   = 1'b1;

    @(posedge clk);
    wr_en   = 1'b0;

    //-------------------------------------
    // Read from FIFO (starts UART TX)
    //-------------------------------------

    @(posedge clk);
rd_en = 1'b1;

@(posedge clk);
rd_en = 1'b1;

@(posedge clk);
rd_en = 1'b0;

    //-------------------------------------
    // Wait for UART Reception
    //-------------------------------------

    wait(rx_done);

    #100;

    $display("\n====================================");
    $display(" UART + FIFO SIMULATION COMPLETED");
    $display("====================================");
    $display("TX Data     : %h", tx_data);
    $display("RX Data     : %h", rx_data);
    $display("FIFO Full   : %b", fifo_full);
    $display("FIFO Empty  : %b", fifo_empty);
    $display("====================================\n");

    $finish;

end

endmodule