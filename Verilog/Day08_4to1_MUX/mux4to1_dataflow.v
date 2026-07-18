module mux4to1_dataflow(
    input D0,
    input D1,
    input D2,
    input D3,
    input S1,
    input S0,
    output Y
);

assign Y = (~S1 & ~S0 & D0) |
           (~S1 & S0 & D1)  |
           (S1 & ~S0 & D2)  |
           (S1 & S0 & D3);

endmodule