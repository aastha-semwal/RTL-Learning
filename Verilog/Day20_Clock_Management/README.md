# Day 20 - Clock Management

## Objective

Design and verify different clock management circuits using Verilog HDL.

This module covers the fundamental concepts of clock generation, clock division, and frequency control used in digital systems and FPGA designs.

---

# Topics Covered

## 1. Frequency Divider (Divide-by-2)

A simple clock divider that toggles the output clock on every positive edge of the input clock.

### Files

- frequency_divider.v
- frequency_divider_tb.v

### Concepts

- Sequential Logic
- Toggle Flip-Flop
- Clock Division
- Frequency Reduction

---

## 2. Parameterized Clock Divider (Divide-by-N)

A reusable clock divider where the division factor can be changed using a parameter.

### Files

- parameterized_clock_divider.v
- parameterized_clock_divider_tb.v

### Concepts

- Parameter
- Counter
- Clock Divider
- Reusable RTL Design

---

# Clock Divider Theory

A Clock Divider reduces the frequency of the input clock.

Example:

Input Clock = 100 MHz

Output Clock (Divide-by-2)

= 50 MHz

Output Clock (Divide-by-4)

= 25 MHz

Output Clock (Divide-by-10)

= 10 MHz

Formula

Output Frequency = Input Frequency / Division Factor

---

# Clock Enable

Clock Enable controls when a circuit should operate without generating a new clock.

Clock Divider creates a new clock signal.

Clock Enable uses the original clock but allows the circuit to update only when enable is active.

---

# FPGA Clock Management

Typical FPGA Clock Flow

Crystal Oscillator

↓

PLL / MMCM

↓

Clock Divider

↓

Clock Enable

↓

Digital Logic

---

# PWM Introduction

Pulse Width Modulation (PWM) controls the amount of power delivered to a load by changing the duty cycle of a digital signal.

Applications

- LED Brightness Control
- DC Motor Speed Control
- Servo Motor Control
- Power Electronics

---

# Applications of Clock Management

- FPGA Design
- Digital Clock
- UART
- SPI
- I2C
- PWM
- Frequency Divider
- Timer
- Counter
- Embedded Systems

---

# Tools Used

- Verilog HDL
- Icarus Verilog
- GTKWave
- Git
- GitHub
- Visual Studio Code

---

# Interview Questions

### 1. What is a Clock Divider?

A circuit that reduces the frequency of the input clock.

---

### 2. Why is Clock Enable preferred in FPGA?

Because it avoids creating unnecessary internal clocks and simplifies timing.

---

### 3. What is the difference between Clock Divider and Clock Enable?

Clock Divider generates a new clock.

Clock Enable controls logic using the original clock.

---

### 4. What is a Parameter in Verilog?

A compile-time constant used to make a module configurable and reusable.

---

### 5. Why do we use Parameterized Design?

To avoid writing multiple versions of the same hardware module.

---

### 6. What is PWM?

PWM (Pulse Width Modulation) controls average power by varying the duty cycle of a digital signal.

---

# GATE Notes

Remember

Counter

↓

Clock Divider

↓

Frequency Divider

↓

Clock Generation

↓

PWM

These concepts are closely related and frequently appear in Digital Electronics and FPGA Design.

---

# Folder Structure

Day20_Clock_Management/

│── README.md

│── frequency_divider.v

│── frequency_divider_tb.v

│── parameterized_clock_divider.v

│── parameterized_clock_divider_tb.v

---

# Learning Outcomes

After completing this module, you will be able to:

✔ Design a Divide-by-2 Frequency Divider

✔ Design a Parameterized Clock Divider

✔ Understand Divide-by-N Clock Division

✔ Differentiate Clock Divider and Clock Enable

✔ Understand FPGA Clock Management

✔ Understand the basics of PWM

---

## Author

**Aastha Semwal**

RTL Learning Journey 🚀

GitHub Repository: RTL-Learning