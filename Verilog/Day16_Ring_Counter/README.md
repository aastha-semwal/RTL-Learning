# Day 16 - 4-bit Ring Counter

## Objective

Design and verify a 4-bit Ring Counter using Verilog HDL.

---

## Theory

A Ring Counter is a special type of Shift Register in which the output of the last flip-flop is connected back to the input of the first flip-flop.

Only one bit remains HIGH (1) at any time.

Hence, Ring Counter is also known as a One-Hot Counter.

---

## Initial State

0001

---

## Sequence

0001

↓

0010

↓

0100

↓

1000

↓

0001

↓

Repeat...

---

## Files

- ring_counter4.v
- ring_counter4_tb.v

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
- Ring Counter
- Always Block
- Non Blocking Assignment
- Reset Logic

---

## Applications

- Sequence Generator
- Traffic Light Controller
- LED Chaser
- Digital Systems
- State Machines

---

## Simulation Tool

- Icarus Verilog
- GTKWave

---

## Author

Aastha Semwal

RTL Learning Journey 🚀