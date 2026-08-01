`timescale 1ns/1ps

module uart_loopback_tb;

reg clk;
reg reset;
reg tx_start;
reg [7:0] tx_data;

wire tx;
wire busy;
wire [7:0] rx_data;
wire data_ready;

// DUT
uart_loopback uut(

    .clk(clk),
    .reset(reset),
    .tx_start(tx_start),
    .tx_data(tx_data),

    .tx(tx),
    .busy(busy),
    .rx_data(rx_data),
    .data_ready(data_ready)

);

// Clock Generation
always #5 clk = ~clk;

initial
begin

    $dumpfile("uart_loopback.vcd");
    $dumpvars(0, uart_loopback_tb);

    $monitor("Time=%0t Start=%b TX_Data=%h TX=%b RX_Data=%h Ready=%b Busy=%b",
              $time,
              tx_start,
              tx_data,
              tx,
              rx_data,
              data_ready,
              busy);

    clk = 0;
    reset = 1;
    tx_start = 0;
    tx_data = 8'h00;

    // Reset
    #20;
    reset = 0;

    // Send 'A'
    #20;
    tx_data = 8'h41;
    tx_start = 1;

    #10;
    tx_start = 0;

    #200;

    // Send '5'
    tx_data = 8'h35;
    tx_start = 1;

    #10;
    tx_start = 0;

    #200;

    $finish;

end

endmodule