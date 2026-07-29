`timescale 1ns/1ps

module mod10_counter_tb;

reg clk;
reg reset;

wire [3:0] Q;

// DUT
mod10_counter uut(
    .clk(clk),
    .reset(reset),
    .Q(Q)
);

// Clock Generation
always #5 clk = ~clk;

initial
begin

    $dumpfile("mod10_counter.vcd");
    $dumpvars(0, mod10_counter_tb);

    $monitor("Time=%0t Reset=%b Q=%b",
             $time, reset, Q);

    clk = 0;
    reset = 1;

    // Hold reset
    #12;
    reset = 0;

    // Count for 15 clocks
    repeat(15)
        @(posedge clk);

    // Apply reset again
    reset = 1;
    @(posedge clk);

    reset = 0;

    repeat(5)
        @(posedge clk);

    $finish;

end

endmodule