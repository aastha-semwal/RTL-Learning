`timescale 1ns/1ps

module uart_tx_tb;

reg clk;
reg reset;
reg tx_start;
reg [7:0] tx_data;

wire tx;
wire busy;

// DUT
uart_tx uut(

    .clk(clk),
    .reset(reset),
    .tx_start(tx_start),
    .tx_data(tx_data),
    .tx(tx),
    .busy(busy)

);

// Clock Generation
always #5 clk = ~clk;

initial
begin

    $dumpfile("uart_tx.vcd");
    $dumpvars(0, uart_tx_tb);

    $monitor("Time=%0t Reset=%b Start=%b Data=%h TX=%b Busy=%b",
              $time, reset, tx_start, tx_data, tx, busy);

    clk = 0;
    reset = 1;
    tx_start = 0;
    tx_data = 8'h00;

    // Reset
    #20;
    reset = 0;

    // Send Character 'A' (0x41)
    #20;
    tx_data = 8'h41;
    tx_start = 1;

    #10;
    tx_start = 0;

    // Wait for transmission
    #150;

    // Send Character '5' (0x35)
    tx_data = 8'h35;
    tx_start = 1;

    #10;
    tx_start = 0;

    #150;

    $finish;

end

endmodule