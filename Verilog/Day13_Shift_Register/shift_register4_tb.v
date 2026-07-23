`timescale 1ns/1ps

module shift_register4_tb;

reg clk;
reg reset;
reg serial_in;

wire [3:0] Q;

// DUT
shift_register4 uut (
    .clk(clk),
    .reset(reset),
    .serial_in(serial_in),
    .Q(Q)
);

// Clock
always #5 clk = ~clk;

initial begin

    $dumpfile("shift_register4.vcd");
    $dumpvars(0, shift_register4_tb);

    $monitor("Time=%0t Reset=%b SI=%b Q=%b",
             $time, reset, serial_in, Q);

    clk = 0;
    reset = 1;
    serial_in = 0;

    // Initial Reset
    @(posedge clk);
    reset = 0;

    // Send 1010
    serial_in = 1;
    @(posedge clk);

    serial_in = 0;
    @(posedge clk);

    serial_in = 1;
    @(posedge clk);

    serial_in = 0;
    @(posedge clk);

    // Apply Reset Again
    reset = 1;
    @(posedge clk);

    reset = 0;
    @(posedge clk);

    $finish;

end

endmodule