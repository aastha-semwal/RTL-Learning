# Day 21 - PWM Generator

## Objective

Design and verify an 8-bit PWM (Pulse Width Modulation) Generator using Verilog HDL.

---

# Theory

PWM (Pulse Width Modulation) is a technique used to control the average power delivered to a load by changing the duty cycle while keeping the frequency constant.

---

# Block Diagram

Clock

↓

8-bit Counter

↓

Comparator

↓

PWM Output

---

# Inputs

- clk
- reset
- duty_cycle [7:0]

---

# Output

- pwm_out

---

# Duty Cycle Examples

0 → 0%

64 → 25%

128 → 50%

192 → 75%

255 → 100%

---

# Applications

- LED Brightness Control
- DC Motor Speed Control
- Servo Motor Control
- FPGA Designs
- Power Electronics

---

# Tools Used

- Verilog HDL
- Icarus Verilog
- GTKWave
- VS Code
- Git
- GitHub

---

# Interview Questions

1. What is PWM?
2. What is Duty Cycle?
3. How is PWM generated?
4. Why is a counter used in PWM?
5. Difference between PWM Frequency and Duty Cycle?

---

# GATE Notes

PWM = Counter + Comparator

Duty Cycle = TON / (TON + TOFF)

---

## Author

Aastha Semwal

RTL Learning Journey