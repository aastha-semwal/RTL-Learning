`timescale 1ns/1ps

module uart_loopback(

    input clk,
    input reset,
    input tx_start,
    input [7:0] tx_data,

    output tx,
    output busy,
    output [7:0] rx_data,
    output data_ready

);

wire serial_line;

// UART Transmitter
uart_tx tx_unit(

    .clk(clk),
    .reset(reset),
    .tx_start(tx_start),
    .tx_data(tx_data),

    .tx(serial_line),
    .busy(busy)

);

// UART Receiver
uart_rx rx_unit(

    .clk(clk),
    .reset(reset),
    .rx(serial_line),

    .rx_data(rx_data),
    .data_ready(data_ready)

);

// Output
assign tx = serial_line;

endmodule