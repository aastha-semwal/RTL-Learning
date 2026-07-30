`timescale 1ns/1ps

module parameterized_clock_divider_tb;

reg clk;
reg reset;

wire clk_out;

// DUT
parameterized_clock_divider #(

    .DIVISOR(4)

) uut (

    .clk(clk),
    .reset(reset),
    .clk_out(clk_out)

);

// Clock
always #5 clk = ~clk;

initial
begin

    $dumpfile("parameterized_clock_divider.vcd");
    $dumpvars(0, parameterized_clock_divider_tb);

    $monitor("Time=%0t Reset=%b clk_out=%b",
              $time, reset, clk_out);

    clk = 0;
    reset = 1;

    #12;
    reset = 0;

    repeat(30)
        @(posedge clk);

    $finish;

end

endmodule