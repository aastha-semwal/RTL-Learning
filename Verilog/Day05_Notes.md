# Day 05 - Behavioral Modeling

Date: 15 July 2026

Today I learned Behavioral Modeling in Verilog. Behavioral Modeling describes the behavior of a digital circuit using procedural blocks such as always, if-else, and case statements. In Behavioral Modeling, we describe what the circuit should do.

The always block is a procedural block that executes whenever the specified input signals change.

Syntax:

always @(*) begin
    // statements
end

The always block executes whenever the relevant inputs change. The @(*) automatically includes all signals used inside the block. The begin keyword indicates the start of the block and end indicates the end of the block.

The wire and reg keywords are used differently in Verilog. A wire is generally used with continuous assignment using the assign statement, while reg is used for procedural assignment inside an always block.

Example of wire:

wire y;
assign y = a & b;

Example of reg:

reg y;

always @(*) begin
    y = a & b;
end

The keyword reg does not always mean that a physical register or flip-flop is created. For example, when reg is used with always @(*) for a logic operation, it can describe combinational logic. The reg keyword is used because the signal is assigned inside an always block.

A procedural assignment is an assignment made inside a procedural block such as an always block.

Example:

always @(*) begin
    y = a & b;
end

Here, y = a & b is a procedural assignment.

The if-else statement is used to execute different statements depending on whether a condition is true or false.

Syntax:

if (condition)
    statement;
else
    statement;

Example:

if (a == 1)
    y = 1;
else
    y = 0;

In Verilog, = is the assignment operator and is used to assign a value. For example, y = 1. The == operator is the comparison operator and is used to compare two values. For example, if (a == 1). The && operator represents Logical AND, where both conditions must be true. The || operator represents Logical OR, where at least one condition must be true.

For example:

if (a == 1 && b == 1)

means both a and b must be equal to 1.

if (a == 1 || b == 1)

means either a or b can be equal to 1.

A Behavioral AND Gate can be written as:

module and_gate_behavioral(
    input a,
    input b,
    output reg y
);

always @(*) begin
    if (a == 1 && b == 1)
        y = 1;
    else
        y = 0;
end

endmodule

A Behavioral OR Gate can be written as:

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

A Behavioral NOT Gate can be written as:

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

The case statement is used to check different possible values of an expression. It is useful when there are multiple possible values to check.

Syntax:

case (expression)
    value1: statement;
    value2: statement;
    default: statement;
endcase

Example:

case (a)
    0: y = 1;
    1: y = 0;
    default: y = 0;
endcase

The default statement is executed when none of the specified case values match.

For example:

case (a)
    0: y = 10;
    1: y = 20;
    default: y = 0;
endcase

If a is 2, then the default statement will execute.

In Verilog, binary values can be written using the format number_of_bits'bvalue.

For example, 1'b0 means a 1-bit binary 0. Here, 1 represents the number of bits, b represents binary, and 0 is the value. Similarly, 1'b1 means a 1-bit binary 1. 2'b00 means a 2-bit binary value 00.

Concatenation is used to combine two or more signals. The syntax {a,b} combines a and b into a 2-bit value. If a = 0 and b = 1, then {a,b} = 2'b01.

An OR Gate can also be implemented using a case statement:

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

The truth table for the OR Gate is:

A B Y
0 0 0
0 1 1
1 0 1
1 1 1

My Understanding:

Today I learned Behavioral Modeling in Verilog. I learned how to use the always block, wire and reg, procedural assignment, if-else statements, and case statements. I also learned the difference between assignment and comparison operators, logical AND and OR operators, binary notation, and concatenation. I implemented basic logic gates using Behavioral Modeling and implemented an OR gate using a case statement.


