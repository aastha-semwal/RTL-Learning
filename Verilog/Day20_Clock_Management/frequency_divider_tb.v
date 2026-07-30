`timescale 1ns/1ps

module frequency_divider_tb;

reg clk;
reg reset;

wire clk_out;

// DUT
frequency_divider uut(

    .clk(clk),
    .reset(reset),
    .clk_out(clk_out)

);

// Clock Generation
always #5 clk = ~clk;

initial
begin

    $dumpfile("frequency_divider.vcd");
    $dumpvars(0, frequency_divider_tb);

    $monitor("Time=%0t Reset=%b clk_out=%b",
             $time, reset, clk_out);

    clk = 0;
    reset = 1;

    // Hold reset
    #12;
    reset = 0;

    // Run divider
    repeat(20)
        @(posedge clk);

    // Apply reset again
    reset = 1;
    @(posedge clk);

    reset = 0;

    repeat(10)
        @(posedge clk);

    $finish;

end

endmodule