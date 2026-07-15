module or_gate_case(
    input a,
    input b,
    output reg y
);

always @(*) begin
    case ({a,b})
        2'b00: y = 1'b0;
        2'b01: y = 1'b1;
        2'b10: y = 1'b1;
        default: y = 1'b1;
    endcase
end

endmodule