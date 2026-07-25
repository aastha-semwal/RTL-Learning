# Day 15 - 4-bit Synchronous Binary Up Counter

## 📌 Objective

To design and verify a 4-bit Synchronous Binary Up Counter using Verilog HDL.

---

## 📖 Theory

A Counter is a sequential circuit that counts clock pulses.

In a Synchronous Counter, all flip-flops receive the same clock signal simultaneously, making it faster than an Asynchronous (Ripple) Counter.

The counter increments by 1 on every positive edge of the clock.

---

## 📂 Files

- counter4bit.v
- counter4bit_tb.v

---

## ⚙️ Inputs

- clk
- reset

---

## 📤 Output

- Q [3:0]

---

## 🔄 Counting Sequence

0000

↓

0001

↓

0010

↓

0011

↓

0100

↓

...

↓

1111

↓

0000 (Overflow)

---

## 💻 Verilog Concepts Used

- Module
- Always Block
- Positive Edge Triggering
- Non-Blocking Assignment (<=)
- Sequential Logic
- 4-bit Register
- Reset Logic

---

## 🧪 Simulation

Simulation performed using:

- Icarus Verilog
- GTKWave

---

## 📚 Applications

- Digital Clock
- Frequency Divider
- Timer
- Event Counter
- Program Counter (CPU)
- Embedded Systems

---

## 👩‍💻 Author

Aastha Semwal

RTL Learning Journey 🚀