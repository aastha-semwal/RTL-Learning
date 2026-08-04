`timescale 1ns/1ps

module spi_master_tb;

parameter DATA_WIDTH = 8;
parameter CLK_DIV    = 4;

reg clk;
reg reset;
reg start;
reg [DATA_WIDTH-1:0] tx_data;
reg miso;

wire mosi;
wire sclk;
wire cs_n;
wire busy;
wire done;
wire [DATA_WIDTH-1:0] rx_data;

//=====================================
// DUT
//=====================================

spi_master #(
    .DATA_WIDTH(DATA_WIDTH),
    .CLK_DIV(CLK_DIV)
)
dut
(
    .clk(clk),
    .reset(reset),
    .start(start),
    .tx_data(tx_data),
    .miso(miso),

    .mosi(mosi),
    .sclk(sclk),
    .cs_n(cs_n),
    .busy(busy),
    .done(done),
    .rx_data(rx_data)
);

//=====================================
// Clock Generation
//=====================================

always #5 clk = ~clk;

//=====================================
// Test Sequence
//=====================================

initial
begin

    clk     = 0;
    reset   = 1;
    start   = 0;
    tx_data = 8'h00;
    miso    = 0;

    $dumpfile("spi_master.vcd");
    $dumpvars(0, spi_master_tb);

    $monitor(
    "T=%0t CS=%b SCLK=%b MOSI=%b MISO=%b Busy=%b Done=%b TX=%h RX=%h",
    $time,
    cs_n,
    sclk,
    mosi,
    miso,
    busy,
    done,
    tx_data,
    rx_data
    );

    #20;
    reset = 0;

    //----------------------------
    // Transaction 1
    //----------------------------

    tx_data = 8'hA5;
    start   = 1;

    #10;
    start = 0;

    wait(busy);
        repeat (8)
    begin
        @(negedge sclk);
        miso = ~miso;
    end

    wait(done);

    #50;

    //----------------------------
    // Transaction 2
    //----------------------------

    tx_data = 8'h3C;
    start   = 1;

    #10;
    start = 0;

    wait(busy);

    repeat (8)
    begin
        @(negedge sclk);
        miso = ~miso;
    end

    wait(done);

    #100;

    $display("\n====================================");
    $display(" SPI MASTER SIMULATION COMPLETED");
    $display(" Last TX Data : %h", tx_data);
    $display(" Last RX Data : %h", rx_data);
    $display("====================================\n");

    $finish;

end

endmodule