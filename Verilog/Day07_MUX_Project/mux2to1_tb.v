`timescale 1ns/1ps

module mux2to1_tb;

reg D0;
reg D1;
reg S;

wire Y;

mux2to1_dataflow uut(
    .D0(D0),
    .D1(D1),
    .S(S),
    .Y(Y)
);

initial begin

    $monitor("Time=%0t D0=%b D1=%b S=%b Y=%b",
             $time, D0, D1, S, Y);

    D0 = 0; D1 = 0; S = 0;
    #10;

    D0 = 0; D1 = 1; S = 0;
    #10;

    D0 = 0; D1 = 1; S = 1;
    #10;

    D0 = 1; D1 = 0; S = 0;
    #10;

    D0 = 1; D1 = 0; S = 1;
    #10;

    D0 = 1; D1 = 1; S = 0;
    #10;

    D0 = 1; D1 = 1; S = 1;
    #10;

    $finish;

end

endmodule