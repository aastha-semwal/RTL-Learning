module mux2to1_case(
    input D0,
    input D1,
    input S,
    output reg Y
);

always @(*) begin
    case (S)
        1'b0: Y = D0;
        1'b1: Y = D1;
        default: Y = 1'b0;
    endcase
end

endmodule