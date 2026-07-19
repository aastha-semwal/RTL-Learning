# Day 09 — 4-bit ALU using Verilog HDL

## What I Learned

Today I designed and simulated a 4-bit Arithmetic Logic Unit (ALU) using Verilog HDL.

An ALU is a combinational digital circuit that performs arithmetic and logical operations based on an operation select code.

## ALU Inputs and Output

### Inputs

- A[3:0] → 4-bit input A
- B[3:0] → 4-bit input B
- OP[2:0] → 3-bit operation selector

### Output

- Y[3:0] → 4-bit result

Since the operation selector is 3 bits:

2³ = 8 possible operation codes

## Operation Table

| OP | Operation |
|----|-----------|
| 000 | Addition (A + B) |
| 001 | Subtraction (A - B) |
| 010 | AND (A & B) |
| 011 | OR (A | B) |
| 100 | XOR (A ^ B) |
| 101 | NOT A (~A) |
| 110 | Default |
| 111 | Default |

## ALU Design Code

```verilog
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