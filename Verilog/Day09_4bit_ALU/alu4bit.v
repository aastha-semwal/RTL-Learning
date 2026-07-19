module alu4bit(
    input  [3:0] A,
    input  [3:0] B,
    input  [2:0] OP,
    output reg  [3:0] Y
);

always @(*) begin

    case (OP)

        3'b000: Y = A + B;  // Addition
        3'b001: Y = A - B;  // Subtraction
        3'b010: Y = A & B;  // AND
        3'b011: Y = A | B;  // OR
        3'b100: Y = A ^ B;  // XOR
        3'b101: Y = ~A;     // NOT A

        default: Y = 4'b0000;

    endcase

end

endmodule