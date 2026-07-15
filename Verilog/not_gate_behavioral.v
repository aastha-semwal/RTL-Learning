module not_gate_behavioral(
    input a,
    output reg y
);

always @(*) begin
    if (a == 0)
        y = 1;
    else
        y = 0;
end

endmodule