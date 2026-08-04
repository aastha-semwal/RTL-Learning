`timescale 1ns/1ps

module spi_top
#(
    parameter DATA_WIDTH = 8,
    parameter CLK_DIV    = 4
)
(
    input  wire clk,
    input  wire reset,
    input  wire start,

    input  wire [DATA_WIDTH-1:0] master_tx_data,
    input  wire [DATA_WIDTH-1:0] slave_tx_data,

    output wire [DATA_WIDTH-1:0] master_rx_data,
    output wire [DATA_WIDTH-1:0] slave_rx_data,

    output wire busy,
    output wire done
);

//=====================================
// Internal SPI Signals
//=====================================

wire mosi;
wire miso;
wire sclk;
wire cs_n;
wire slave_done;
//=====================================
// SPI Master
//=====================================

spi_master #(
    .DATA_WIDTH(DATA_WIDTH),
    .CLK_DIV(CLK_DIV)
)
master_inst
(
    .clk(clk),
    .reset(reset),

    .start(start),
    .tx_data(master_tx_data),

    .miso(miso),

    .mosi(mosi),
    .sclk(sclk),
    .cs_n(cs_n),

    .busy(busy),
    .done(done),

    .rx_data(master_rx_data)
);
//=====================================
// SPI Slave
//=====================================

spi_slave #(
    .DATA_WIDTH(DATA_WIDTH)
)
slave_inst
(
    .reset(reset),

    .sclk(sclk),
    .cs_n(cs_n),

    .mosi(mosi),
    .miso(miso),

    .tx_data(slave_tx_data),
    .rx_data(slave_rx_data),

    .done(slave_done)
);

endmodule