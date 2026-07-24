`timescale 1ns/1ps

module universal_shift_register_tb;

reg clk;
reg reset;
reg [1:0] mode;
reg serial_left;
reg serial_right;
reg [3:0] D;

wire [3:0] Q;

// DUT Instantiation
universal_shift_register uut (

    .clk(clk),
    .reset(reset),
    .mode(mode),
    .serial_left(serial_left),
    .serial_right(serial_right),
    .D(D),
    .Q(Q)

);

// Clock Generation
always #5 clk = ~clk;

initial begin

    $dumpfile("universal_shift_register.vcd");
    $dumpvars(0, universal_shift_register_tb);

    $monitor("Time=%0t Reset=%b Mode=%b SL=%b SR=%b D=%b Q=%b",
             $time, reset, mode, serial_left,
             serial_right, D, Q);

    // Initial Values
    clk = 0;
    reset = 1;
    mode = 2'b00;
    serial_left = 0;
    serial_right = 0;
    D = 4'b0000;

    // Reset
    @(posedge clk);
    reset = 0;

    // -----------------------------
    // Test 1 : Parallel Load
    // -----------------------------
    mode = 2'b11;
    D = 4'b1010;
    @(posedge clk);

    // -----------------------------
    // Test 2 : Hold
    // -----------------------------
    mode = 2'b00;
    @(posedge clk);

    // -----------------------------
    // Test 3 : Shift Right
    // -----------------------------
    mode = 2'b01;
    serial_right = 1;
    @(posedge clk);

    // -----------------------------
    // Test 4 : Shift Left
    // -----------------------------
    mode = 2'b10;
    serial_left = 0;
    @(posedge clk);

    // -----------------------------
    // Test 5 : Parallel Load Again
    // -----------------------------
    mode = 2'b11;
    D = 4'b0110;
    @(posedge clk);

    // -----------------------------
    // Test 6 : Shift Left
    // -----------------------------
    mode = 2'b10;
    serial_left = 1;
    @(posedge clk);

    // -----------------------------
    // Test 7 : Shift Right
    // -----------------------------
    mode = 2'b01;
    serial_right = 0;
    @(posedge clk);

    // -----------------------------
    // Test 8 : Reset Again
    // -----------------------------
    reset = 1;
    @(posedge clk);

    reset = 0;
    @(posedge clk);

    $finish;

end

endmodule