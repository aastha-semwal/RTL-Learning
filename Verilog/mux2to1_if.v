module mux2to1_if(
    input D0,
    input D1,
    input S,
    output reg Y
);

always @(*) begin
    if (S == 0)
        Y = D0;
    else
        Y = D1;
end

endmodule