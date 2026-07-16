module mux2to1_gate(
    input D0,
    input D1,
    input S,
    output Y
);

wire S_not;
wire path0;
wire path1;

not (S_not, S);
and (path0, S_not, D0);
and (path1, S, D1);
or  (Y, path0, path1);

endmodule