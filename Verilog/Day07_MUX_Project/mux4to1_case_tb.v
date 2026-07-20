`timescale 1ns/1ps

module mux4to1_case_tb;

reg D0;
reg D1;
reg D2;
reg D3;

reg S1;
reg S0;

wire Y;

mux4to1_case uut(
    .D0(D0),
    .D1(D1),
    .D2(D2),
    .D3(D3),
    .S1(S1),
    .S0(S0),
    .Y(Y)
);

initial begin

    $monitor("Time=%0t D0=%b D1=%b D2=%b D3=%b S1=%b S0=%b Y=%b",
             $time, D0, D1, D2, D3, S1, S0, Y);

    D0 = 0; D1 = 1; D2 = 0; D3 = 1;

    S1 = 0; S0 = 0;
    #10;

    S1 = 0; S0 = 1;
    #10;

    S1 = 1; S0 = 0;
    #10;

    S1 = 1; S0 = 1;
    #10;

    $finish;

end

endmodule