module mux2to1_dataflow(
    input D0,
    input D1,
    input S,
    output Y
);

assign Y = (~S & D0) | (S & D1);

endmodule