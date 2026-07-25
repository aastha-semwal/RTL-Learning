`timescale 1ns/1ps

module counter4bit_tb;

reg clk;
reg reset;

wire [3:0] Q;

// DUT Instantiation
counter4bit uut(
    .clk(clk),
    .reset(reset),
    .Q(Q)
);

// Clock Generation
always #5 clk = ~clk;

initial
begin

    $dumpfile("counter4bit.vcd");
    $dumpvars(0, counter4bit_tb);

    $monitor("Time=%0t Reset=%b Q=%b",
             $time, reset, Q);

    // Initialize Signals
    clk = 0;
    reset = 1;

    // Initial Reset
    @(posedge clk);
    reset = 0;

    // Count for 10 Clock Cycles
    repeat(10)
        @(posedge clk);

    // Apply Reset Again
    reset = 1;
    @(posedge clk);

    reset = 0;

    // Count Again
    repeat(5)
        @(posedge clk);

    $finish;

end

endmodule