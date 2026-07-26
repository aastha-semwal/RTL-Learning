`timescale 1ns/1ps

module ring_counter4_tb;

reg clk;
reg reset;

wire [3:0] Q;

// DUT Instantiation
ring_counter4 uut(

    .clk(clk),
    .reset(reset),
    .Q(Q)

);

// Clock Generation
always #5 clk = ~clk;

initial
begin

    $dumpfile("ring_counter4.vcd");
    $dumpvars(0, ring_counter4_tb);

    $monitor("Time=%0t Reset=%b Q=%b",
             $time, reset, Q);

    // Initialize Signals
    clk = 0;
    reset = 1;

    // Apply Reset
    @(posedge clk);
    reset = 0;

    // Run Counter
    repeat(10)
        @(posedge clk);

    // Apply Reset Again
    reset = 1;
    @(posedge clk);

    reset = 0;

    // Run Again
    repeat(5)
        @(posedge clk);

    $finish;

end

endmodule