`timescale 1ns/1ps

module up_down_counter4_tb;

reg clk;
reg reset;
reg up_down;

wire [3:0] Q;

// DUT
up_down_counter4 uut(
    .clk(clk),
    .reset(reset),
    .up_down(up_down),
    .Q(Q)
);

// Clock Generation
always #5 clk = ~clk;

initial
begin
    $dumpfile("up_down_counter4.vcd");
    $dumpvars(0, up_down_counter4_tb);

    $monitor("Time=%0t Reset=%b Up_Down=%b Q=%b",
             $time, reset, up_down, Q);

    clk = 0;
    reset = 1;
    up_down = 1;

    // Hold reset for one full clock cycle
    #12;
    reset = 0;

    // Up Count
    repeat(8)
        @(posedge clk);

    // Down Count
    up_down = 0;

    repeat(8)
        @(posedge clk);

    // Reset Again
    reset = 1;
    @(posedge clk);
    reset = 0;

    up_down = 1;

    repeat(5)
        @(posedge clk);

    $finish;

end

endmodule