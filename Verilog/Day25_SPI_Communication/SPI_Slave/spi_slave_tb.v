`timescale 1ns/1ps

module spi_slave_tb;

parameter DATA_WIDTH = 8;

reg reset;
reg sclk;
reg cs_n;
reg mosi;

wire miso;

reg  [DATA_WIDTH-1:0] tx_data;
wire [DATA_WIDTH-1:0] rx_data;

wire done;

//=====================================
// DUT
//=====================================

spi_slave #(
    .DATA_WIDTH(DATA_WIDTH)
)
dut
(
    .reset(reset),

    .sclk(sclk),
    .cs_n(cs_n),

    .mosi(mosi),
    .miso(miso),

    .tx_data(tx_data),
    .rx_data(rx_data),

    .done(done)
);

//=====================================
// Clock Generation
//=====================================

always #10 sclk = ~sclk;

//=====================================
// Test
//=====================================

initial
begin

    reset = 1;
    sclk  = 0;
    cs_n  = 1;
    mosi  = 0;

    tx_data = 8'h5A;

    $dumpfile("spi_slave.vcd");
    $dumpvars(0,spi_slave_tb);

    $monitor(
    "T=%0t CS=%b SCLK=%b MOSI=%b MISO=%b RX=%h DONE=%b",
    $time,
    cs_n,
    sclk,
    mosi,
    miso,
    rx_data,
    done
    );

    #20;
    reset = 0;

    // Select Slave
    #20;
    cs_n = 0;

    // Send 8 bits : A5
        // Send 10100101 (A5)
    repeat (8)
    begin
        @(negedge sclk);

        case ($time)

            50  : mosi = 1;
            70  : mosi = 0;
            90  : mosi = 1;
            110 : mosi = 0;
            130 : mosi = 0;
            150 : mosi = 1;
            170 : mosi = 0;
            190 : mosi = 1;

            default : mosi = 0;

        endcase
    end

    // Deselect Slave
    #20;
    cs_n = 1;

    #50;

    $display("\n====================================");
    $display(" SPI SLAVE SIMULATION COMPLETED");
    $display(" Slave TX Data : %h", tx_data);
    $display(" Slave RX Data : %h", rx_data);
    $display("====================================\n");

    $finish;

end

endmodule