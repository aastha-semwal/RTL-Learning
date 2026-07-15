module or_gate_behavioral(
    input a,
    input b,
    output reg y
);

always @(*) begin
    if (a == 1 || b == 1)
        y = 1;
    else
        y = 0;
end

endmodule