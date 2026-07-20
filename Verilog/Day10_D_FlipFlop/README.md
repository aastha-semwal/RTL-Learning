# Day 10 - D Flip-Flop with Asynchronous Reset

## Objective
Design and simulate a D Flip-Flop using Verilog HDL with an asynchronous reset.

## Concept
A D Flip-Flop stores the value of input D at the rising edge of the clock.

- Rising edge of CLK → Q captures D
- No rising edge → Q holds its previous value
- Reset = 1 → Q immediately becomes 0

## RTL Code
The design uses:

```verilog
always @(posedge clk or posedge reset)