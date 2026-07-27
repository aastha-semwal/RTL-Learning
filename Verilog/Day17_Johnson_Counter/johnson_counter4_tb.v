`timescale 1ns/1ps

module johnson_counter4_tb;

reg clk;
reg reset;

wire [3:0] Q;

// DUT
johnson_counter4 uut(

    .clk(clk),
    .reset(reset),
    .Q(Q)

);

// Clock Generation
always #5 clk = ~clk;

initial
begin

    $dumpfile("johnson_counter4.vcd");
    $dumpvars(0, johnson_counter4_tb);

    $monitor("Time=%0t Reset=%b Q=%b",
             $time, reset, Q);

    clk = 0;
    reset = 1;

    @(posedge clk);
    reset = 0;

    repeat(12)
        @(posedge clk);

    reset = 1;
    @(posedge clk);

    reset = 0;

    repeat(8)
        @(posedge clk);

    $finish;

end

endmodule