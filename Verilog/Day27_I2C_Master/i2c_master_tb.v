`timescale 1ns/1ps

module i2c_master_tb;

reg clk;
reg reset;

reg start;

reg [6:0] slave_addr;
reg rw;

wire scl;
wire sda;

wire busy;
wire done;

//=====================================
// DUT
//=====================================

i2c_master dut
(
    .clk(clk),
    .reset(reset),

    .start(start),

    .slave_addr(slave_addr),
    .rw(rw),

    .scl(scl),
    .sda(sda),

    .busy(busy),
    .done(done)
);

//=====================================
// Clock Generation
//=====================================

always #10 clk = ~clk;

//=====================================
// Test Sequence
//=====================================

initial
begin

    clk = 0;
    reset = 1;
    start = 0;

    slave_addr = 7'h42;
    rw = 1'b0;

    $dumpfile("i2c_master.vcd");
    $dumpvars(0, i2c_master_tb);

    $monitor(
        "T=%0t START=%b BUSY=%b DONE=%b SCL=%b SDA=%b",
        $time,
        start,
        busy,
        done,
        scl,
        sda
    );

    #40;
    reset = 0;
        // Release reset
    #20;

    // Start I2C Transaction
    start = 1'b1;

    #20;
    start = 1'b0;

    // Wait until transaction finishes
    wait(done);

    #20;

    $display("");
    $display("====================================");
    $display("    I2C MASTER SIMULATION DONE");
    $display("====================================");
    $display("Slave Address : %h", slave_addr);
    $display("Read/Write    : %b", rw);
    $display("====================================");
    $display("");

    #50;
    $finish;

end

endmodule