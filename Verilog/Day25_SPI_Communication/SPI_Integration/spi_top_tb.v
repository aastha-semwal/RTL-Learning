`timescale 1ns/1ps

module spi_top_tb;

parameter DATA_WIDTH = 8;
parameter CLK_DIV    = 4;

reg clk;
reg reset;
reg start;

reg [DATA_WIDTH-1:0] master_tx_data;
reg [DATA_WIDTH-1:0] slave_tx_data;

wire [DATA_WIDTH-1:0] master_rx_data;
wire [DATA_WIDTH-1:0] slave_rx_data;

wire busy;
wire done;

//======================================
// DUT
//======================================

spi_top #(
    .DATA_WIDTH(DATA_WIDTH),
    .CLK_DIV(CLK_DIV)
)
dut
(
    .clk(clk),
    .reset(reset),
    .start(start),

    .master_tx_data(master_tx_data),
    .slave_tx_data(slave_tx_data),

    .master_rx_data(master_rx_data),
    .slave_rx_data(slave_rx_data),

    .busy(busy),
    .done(done)
);

//======================================
// Clock Generation
//======================================

always #5 clk = ~clk;

initial
begin

    clk = 0;
    reset = 1;
    start = 0;

    master_tx_data = 8'hA5;
    slave_tx_data  = 8'h3C;

    $dumpfile("spi_top.vcd");
    $dumpvars(0,spi_top_tb);

    $monitor(
    "T=%0t Busy=%b Done=%b MasterTX=%h MasterRX=%h SlaveTX=%h SlaveRX=%h",
    $time,
    busy,
    done,
    master_tx_data,
    master_rx_data,
    slave_tx_data,
    slave_rx_data
    );

    #20;
    reset = 0;

    #20;
    start = 1;

    #10;
    start = 0;
        // Wait until SPI transfer completes
    wait(done);

    #50;

    $display("\n====================================");
    $display(" SPI MASTER + SLAVE INTEGRATION");
    $display("====================================");
    $display(" Master TX : %h", master_tx_data);
    $display(" Master RX : %h", master_rx_data);
    $display(" Slave  TX : %h", slave_tx_data);
    $display(" Slave  RX : %h", slave_rx_data);
    $display("====================================\n");

    #50;
    $finish;

end

endmodule