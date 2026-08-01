`timescale 1ns/1ps

module uart_rx_tb;

reg clk;
reg reset;
reg rx;

wire [7:0] rx_data;
wire data_ready;

// DUT
uart_rx uut(

    .clk(clk),
    .reset(reset),
    .rx(rx),

    .rx_data(rx_data),
    .data_ready(data_ready)

);

// Clock Generation
always #5 clk = ~clk;

initial
begin

    $dumpfile("uart_rx.vcd");
    $dumpvars(0, uart_rx_tb);

    $monitor("Time=%0t Reset=%b RX=%b Data=%h Ready=%b",
              $time, reset, rx, rx_data, data_ready);

    clk = 0;
    reset = 1;
    rx = 1;

    // Reset
    #20;
    reset = 0;

    // Start Bit
    #10;
    rx = 0;

    // Send 0x41 ('A') LSB First
    #10 rx = 1;   // bit0
    #10 rx = 0;   // bit1
    #10 rx = 0;   // bit2
    #10 rx = 0;   // bit3
    #10 rx = 0;   // bit4
    #10 rx = 0;   // bit5
    #10 rx = 1;   // bit6
    #10 rx = 0;   // bit7

    // Stop Bit
    #10;
    rx = 1;

    #50;

    $finish;

end

endmodule