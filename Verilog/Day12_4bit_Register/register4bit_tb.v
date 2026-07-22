`timescale 1ns/1ps

module register4bit_tb;

reg clk;
reg reset;
reg [3:0] D;

wire [3:0] Q;

// DUT Instantiation
register4bit uut (
    .clk(clk),
    .reset(reset),
    .D(D),
    .Q(Q)
);

// Clock Generation
always #5 clk = ~clk;

initial begin

    $dumpfile("register4bit.vcd");
    $dumpvars(0, register4bit_tb);

    $monitor("Time=%0t Reset=%b D=%b Q=%b",
             $time, reset, D, Q);

    clk = 0;
    reset = 1;
    D = 4'b0000;

    // Initial Reset
    @(posedge clk);
    reset = 0;

    // Test 1
    D = 4'b1010;
    @(posedge clk);

    // Test 2
    D = 4'b0101;
    @(posedge clk);

    // Test 3
    D = 4'b1111;
    @(posedge clk);

    // Apply Reset Again
    reset = 1;
    @(posedge clk);
    reset = 0;

    // Test 4
    D = 4'b0011;
    @(posedge clk);

    $finish;

end

endmodule