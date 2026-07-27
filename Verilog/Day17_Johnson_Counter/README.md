# Day 17 - 4-bit Johnson Counter

## Objective

Design and verify a 4-bit Johnson Counter using Verilog HDL.

---

## Theory

Johnson Counter is also known as Twisted Ring Counter.

The inverted output of the last flip-flop is fed back to the input of the first flip-flop.

It produces 2n states for n flip-flops.

---

## Initial State

0000

---

## Sequence

0000

↓

1000

↓

1100

↓

1110

↓

1111

↓

0111

↓

0011

↓

0001

↓

0000

Repeat...

---

## Files

- johnson_counter4.v
- johnson_counter4_tb.v

---

## Inputs

- clk
- reset

---

## Output

- Q[3:0]

---

## Concepts Used

- Sequential Logic
- Shift Register
- Johnson Counter
- Twisted Ring Counter
- Non-Blocking Assignment
- Reset Logic

---

## Applications

- Traffic Light Controller
- Sequence Generator
- FSM
- Timing Circuits
- Digital Systems

---

## Simulation Tool

- Icarus Verilog
- GTKWave

---

## Author

Aastha Semwal

RTL Learning Journey 🚀