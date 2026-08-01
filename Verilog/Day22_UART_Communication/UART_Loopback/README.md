# Day 22 - UART Loopback

## 📌 Project Overview

Integrated UART Transmitter and UART Receiver to build a complete UART Loopback System.

The transmitter serially sends 8-bit data and the receiver reconstructs the same data.

---

## Block Diagram

TX Data
   │
   ▼
UART Transmitter
   │
Serial Line
   │
   ▼
UART Receiver
   │
   ▼
RX Data

---

## Files

- uart_tx.v
- uart_rx.v
- uart_loopback.v
- uart_loopback_tb.v

---

## Tools

- Verilog HDL
- Icarus Verilog
- GTKWave
- VS Code
- GitHub

---

## Compile

```bash
iverilog -Wall -o uart_loopback_sim uart_tx.v uart_rx.v uart_loopback.v uart_loopback_tb.v
```

## Run

```bash
vvp uart_loopback_sim
```

## GTKWave

```bash
gtkwave uart_loopback.vcd
```

---

## Results

- UART TX Verified
- UART RX Verified
- Loopback Verified
- Successfully transmitted and received:
  - 0x41 ('A')
  - 0x35 ('5')

---

## Learning Outcomes

- UART Communication
- Module Integration
- Serial Communication
- RTL Hierarchy
- Testbench Design