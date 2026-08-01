# Day 22 - UART Receiver (RX)

## 📌 Project Overview
Designed a UART Receiver using Verilog HDL.

The receiver detects the Start Bit, receives 8-bit serial data, and converts it into parallel data.

---

## UART Frame

Idle → Start Bit → 8-bit Data → Stop Bit

---

## Files

- uart_rx.v
- uart_rx_tb.v
- README.md

---

## Tools Used

- Verilog HDL
- Icarus Verilog
- GTKWave
- VS Code
- Git & GitHub

---

## Compile

```bash
iverilog -Wall -o uart_rx_sim uart_rx.v uart_rx_tb.v
```

## Run

```bash
vvp uart_rx_sim
```

## Open GTKWave

```bash
gtkwave uart_rx.vcd
```

---

## Results

- Successfully Compiled
- Successfully Simulated
- UART RX Verified
- Received Data = 0x41 ('A')

---

## Learning Outcomes

- UART Receiver
- Shift Register
- Start Bit Detection
- Data Reception
- FSM Design