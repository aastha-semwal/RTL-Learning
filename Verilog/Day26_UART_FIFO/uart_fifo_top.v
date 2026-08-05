`timescale 1ns/1ps

module uart_fifo_top
#(
    parameter DATA_BITS = 8
)
(
    input  wire clk,
    input  wire reset,

    input  wire wr_en,
    input  wire rd_en,

    input  wire [DATA_BITS-1:0] tx_data,

    output wire tx,

    input  wire rx,

    output wire [DATA_BITS-1:0] rx_data,

    output wire fifo_full,
    output wire fifo_empty,

    output wire tx_busy,
    output wire rx_done
);

//=====================================
// Internal Signals
//=====================================

wire baud_tick;

wire [DATA_BITS-1:0] fifo_data_out;

reg uart_start;
//=====================================
// Baud Generator
//=====================================

baud_gen baud_gen_inst
(
    .clk(clk),
    .reset(reset),
    .baud_tick(baud_tick)
);

//=====================================
// FIFO
//=====================================

fifo fifo_inst
(
    .clk(clk),
    .reset(reset),

    .wr_en(wr_en),
    .rd_en(rd_en),

    .data_in(tx_data),
    .data_out(fifo_data_out),

    .full(fifo_full),
    .empty(fifo_empty)
);

// UART starts transmitting whenever a FIFO read is requested


//=====================================
// UART Start Logic
//=====================================

always @(posedge clk or posedge reset)
begin
    if(reset)
    begin
        uart_start <= 1'b0;
    end
    else
    begin
        if(rd_en && !fifo_empty && !tx_busy)
            uart_start <= 1'b1;
        else
            uart_start <= 1'b0;
    end
end
//=====================================
// UART Transmitter
//=====================================
uart_tx uart_tx_inst
(
    .clk(clk),
    .reset(reset),

    .baud_tick(baud_tick),

    .tx_start(uart_start),
    .tx_data(fifo_data_out),

    .tx(tx),
    .busy(tx_busy)
);

//=====================================
// UART Receiver
//=====================================

uart_rx uart_rx_inst
(
    .clk(clk),
    .reset(reset),

    .baud_tick(baud_tick),

    .rx(tx),              // Internal Loopback

    .rx_data(rx_data),
    .data_ready(rx_done)
);

endmodule