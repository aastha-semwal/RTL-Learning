# Day 07 — 2:1 MUX Mini Project: Testbench and Simulation

## What I Learned

Today I learned how to create and run a testbench for a 2:1 Multiplexer.

A testbench is a Verilog module used to apply different input values (stimulus) to a Design Under Test (DUT) and observe or verify its output.

DUT/UUT means the actual design being tested.

Stimulus means the input values applied to the design for testing.

In the testbench, `reg` is used for signals whose values are controlled or assigned by the testbench, while `wire` is used for signals that receive output from the design.

A 2:1 Multiplexer has two data inputs (D0 and D1), one select line (S), and one output (Y).

MUX Operation:

S = 0 → Y = D0
S = 1 → Y = D1

Boolean Expression:

Y = (~S & D0) | (S & D1)

The `#10` delay creates a delay of 10 simulation time units between two test cases.

The `$monitor` system task automatically displays the values of specified signals whenever any of them changes.

The `$finish` system task stops the simulation.

## Testbench Code

`timescale 1ns/1ps

module mux2to1_tb;

reg D0;
reg D1;
reg S;

wire Y;

mux2to1_dataflow uut(
    .D0(D0),
    .D1(D1),
    .S(S),
    .Y(Y)
);

initial begin

    $monitor("Time=%0t D0=%b D1=%b S=%b Y=%b",
             $time, D0, D1, S, Y);

    D0 = 0; D1 = 0; S = 0;
    #10;

    D0 = 0; D1 = 1; S = 0;
    #10;

    D0 = 0; D1 = 1; S = 1;
    #10;

    D0 = 1; D1 = 0; S = 0;
    #10;

    D0 = 1; D1 = 0; S = 1;
    #10;

    D0 = 1; D1 = 1; S = 0;
    #10;

    D0 = 1; D1 = 1; S = 1;
    #10;

    $finish;

end

endmodule

## Compilation

The design and testbench were compiled using Icarus Verilog:

iverilog -o mux_sim mux2to1_dataflow.v mux2to1_tb.v

## Simulation

The compiled simulation was run using:

./mux_sim

## Simulation Output

Time=0     D0=0 D1=0 S=0 Y=0
Time=10000 D0=0 D1=1 S=0 Y=0
Time=20000 D0=0 D1=1 S=1 Y=1
Time=30000 D0=1 D1=0 S=0 Y=1
Time=40000 D0=1 D1=0 S=1 Y=0
Time=50000 D0=1 D1=1 S=0 Y=1
Time=60000 D0=1 D1=1 S=1 Y=1

## Verification

All test cases produced the expected output according to the 2:1 MUX operation:

S = 0 → Y = D0
S = 1 → Y = D1

Therefore, the 2:1 MUX design was successfully compiled, simulated, and verified.

## Tools Used

Verilog HDL
Visual Studio Code
Icarus Verilog
MSYS2 UCRT64

## Day 07 Learning Outcome

Today I learned the complete basic RTL verification flow:

Design → Testbench → Stimulus → Simulation → Output Observation → Verification

I successfully created and simulated my first Verilog mini-project: a 2:1 Multiplexer.