# Day 06 - 2:1 Multiplexer (MUX)

Date: 16 July 2026

Today I learned about Multiplexers (MUX) and implemented a 2:1 MUX using different Verilog modeling styles.

A Multiplexer, or MUX, is a digital circuit that selects one input from multiple inputs and sends the selected input to a single output. Therefore, a MUX is also called a data selector.

A 2:1 MUX has two data inputs, one select input, and one output.

D0 = Data Input 0
D1 = Data Input 1
S = Select Line
Y = Output

The working of a 2:1 MUX is:

S = 0 → Y = D0
S = 1 → Y = D1

Truth Table:

S | Y
0 | D0
1 | D1

The Boolean expression of a 2:1 MUX is:

Y = (~S & D0) | (S & D1)

Here:

~ means NOT
& means AND
| means OR

When S = 0:

~S = 1

(~S & D0) = (1 & D0) = D0

(S & D1) = (0 & D1) = 0

Therefore:

Y = D0 | 0
Y = D0

Thus, when S = 0, D0 is selected.

When S = 1:

~S = 0

(~S & D0) = (0 & D0) = 0

(S & D1) = (1 & D1) = D1

Therefore:

Y = 0 | D1
Y = D1

Thus, when S = 1, D1 is selected.

A 2:1 MUX can be implemented using different Verilog modeling styles.

Gate-Level Modeling:

In Gate-Level Modeling, the circuit is described using basic Verilog gate primitives such as not, and, and or gates.

Code:

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

In this code, the NOT gate produces S_not = ~S. The first AND gate produces path0 = ~S & D0. The second AND gate produces path1 = S & D1. Finally, the OR gate combines both paths to produce the output Y.

Dataflow Modeling:

In Dataflow Modeling, the behavior of the circuit is described using Boolean expressions and the assign statement.

Code:

module mux2to1_dataflow(
    input D0,
    input D1,
    input S,
    output Y
);

assign Y = (~S & D0) | (S & D1);

endmodule

The assign statement continuously assigns the result of the Boolean expression to the output Y.

Behavioral Modeling Using if-else:

In Behavioral Modeling, we describe what the circuit should do using procedural blocks.

Code:

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

This code means that if S is 0, D0 is assigned to Y. Otherwise, D1 is assigned to Y.

Behavioral Modeling Using case:

The case statement can also be used to implement a 2:1 MUX.

Code:

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

The case statement checks the value of the select input S. When S is 0, D0 is selected. When S is 1, D1 is selected.

The same 2:1 MUX can therefore be implemented using Gate-Level Modeling, Dataflow Modeling, and Behavioral Modeling. Although the coding styles are different, all the implementations describe the same hardware behavior.

My Understanding:

Today I learned that a Multiplexer is a data selector that selects one input from multiple inputs and sends it to a single output. I learned the working of a 2:1 MUX, its truth table, and its Boolean expression. I also implemented a 2:1 MUX using Gate-Level Modeling, Dataflow Modeling using assign, and Behavioral Modeling using if-else and case statements. This helped me understand how the same digital circuit can be described using different Verilog modeling styles.