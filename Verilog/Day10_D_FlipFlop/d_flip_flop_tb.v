`timescale 1ns/1ps

module d_flip_flop_tb;

reg clk;
reg reset;
reg D;

wire Q;

d_flip_flop uut (
    .clk(clk),
    .reset(reset),
    .D(D),
    .Q(Q)
);

// Clock generation: 10 ns period
always #5 clk = ~clk;

initial begin

    $dumpfile("dff.vcd");
    $dumpvars(0, d_flip_flop_tb);

    $monitor("Time=%0t Reset=%b D=%b Q=%b",
             $time, reset, D, Q);

    // Initial values
    clk = 0;
    reset = 1;
    D = 0;

    // Asynchronous reset
    #7;
    reset = 0;

    // D = 1, captured at next rising edge
    D = 1;
    #10;

    // D = 0, captured at next rising edge
    D = 0;
    #10;

    // D = 1 again
    D = 1;
    #10;

    // Test asynchronous reset again
    reset = 1;
    #3;
    reset = 0;

    #10;

    $finish;

end

endmodule