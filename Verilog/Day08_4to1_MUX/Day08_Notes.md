# Day 08 — 4:1 Multiplexer: Design, Testbench and Simulation

## What I Learned

Today I learned how to design and simulate a 4:1 Multiplexer using Verilog HDL and Dataflow Modeling.

A 4:1 Multiplexer is a combinational circuit that selects one input from four input signals and sends the selected input to a single output.

## 4:1 MUX Structure

Inputs:
D0, D1, D2, D3

Select Lines:
S1, S0

Output:
Y

Since there are 4 inputs, 2 select lines are required:

Number of select lines = log2(4) = 2

## Selection Table

S1 S0 | Selected Input | Output
0  0  | D0             | Y = D0
0  1  | D1             | Y = D1
1  0  | D2             | Y = D2
1  1  | D3             | Y = D3

## Boolean Expression

Y = (~S1 & ~S0 & D0) |
    (~S1 & S0 & D1)  |
    (S1 & ~S0 & D2)  |
    (S1 & S0 & D3)

## Verilog Design Code

module mux4to1_dataflow(
    input D0,
    input D1,
    input D2,
    input D3,
    input S1,
    input S0,
    output Y
);

assign Y = (~S1 & ~S0 & D0) |
           (~S1 & S0 & D1)  |
           (S1 & ~S0 & D2)  |
           (S1 & S0 & D3);

endmodule

## Testbench

`timescale 1ns/1ps

module mux4to1_tb;

reg D0;
reg D1;
reg D2;
reg D3;

reg S1;
reg S0;

wire Y;

mux4to1_dataflow uut(
    .D0(D0),
    .D1(D1),
    .D2(D2),
    .D3(D3),
    .S1(S1),
    .S0(S0),
    .Y(Y)
);

initial begin

    $monitor("Time=%0t D0=%b D1=%b D2=%b D3=%b S1=%b S0=%b Y=%b",
             $time, D0, D1, D2, D3, S1, S0, Y);

    D0 = 0; D1 = 1; D2 = 0; D3 = 1;

    S1 = 0; S0 = 0;
    #10;

    S1 = 0; S0 = 1;
    #10;

    S1 = 1; S0 = 0;
    #10;

    S1 = 1; S0 = 1;
    #10;

    $finish;

end

endmodule

## Compilation

The design and testbench were compiled using Icarus Verilog:

iverilog -o mux4_sim mux4to1_dataflow.v mux4to1_tb.v

## Simulation

The compiled simulation was run using:

./mux4_sim

## Simulation Output

Time=0     D0=0 D1=1 D2=0 D3=1 S1=0 S0=0 Y=0
Time=10000 D0=0 D1=1 D2=0 D3=1 S1=0 S0=1 Y=1
Time=20000 D0=0 D1=1 D2=0 D3=1 S1=1 S0=0 Y=0
Time=30000 D0=0 D1=1 D2=0 D3=1 S1=1 S0=1 Y=1

## Verification

The simulation results were verified successfully:

S1S0 = 00 → Y = D0 = 0
S1S0 = 01 → Y = D1 = 1
S1S0 = 10 → Y = D2 = 0
S1S0 = 11 → Y = D3 = 1

All outputs matched the expected results.

## Tools Used

- Verilog HDL
- Visual Studio Code
- Icarus Verilog
- MSYS2 UCRT64

## Day 08 Learning Outcome

Today I learned how to:

- Understand the working of a 4:1 Multiplexer
- Use two select lines to select one of four inputs
- Derive the Boolean expression of a 4:1 MUX
- Implement a 4:1 MUX using Verilog Dataflow Modeling
- Create a Verilog testbench
- Compile Verilog code using Icarus Verilog
- Run a simulation
- Verify the output using simulation results

This was my second Verilog mini-project, and I successfully designed, simulated, and verified a 4:1 Multiplexer.