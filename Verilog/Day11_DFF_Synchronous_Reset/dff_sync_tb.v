`timescale 1ns/1ps

module dff_sync_tb;

reg clk;
reg reset;
reg D;

wire Q;

// DUT Instantiation
dff_sync uut (
    .clk(clk),
    .reset(reset),
    .D(D),
    .Q(Q)
);

// Clock Generation (10 ns period)
always #5 clk = ~clk;

initial begin

    // Generate VCD file
    $dumpfile("dff_sync.vcd");
    $dumpvars(0, dff_sync_tb);

    // Monitor values
    $monitor("Time=%0t | Reset=%b | D=%b | Q=%b",
             $time, reset, D, Q);

    // Initial values
    clk = 0;
    reset = 1;
    D = 0;

    // Wait for first clock edge
    @(posedge clk);
    reset = 0;

    // Test 1: Load D = 1
    D = 1;
    @(posedge clk);

    // Test 2: Load D = 0
    D = 0;
    @(posedge clk);

    // Test 3: Load D = 1
    D = 1;
    @(posedge clk);

    // Test 4: Apply synchronous reset
    reset = 1;
    @(posedge clk);
    reset = 0;

    // Test 5: Load D = 0
    D = 0;
    @(posedge clk);

    $finish;

end

endmodule