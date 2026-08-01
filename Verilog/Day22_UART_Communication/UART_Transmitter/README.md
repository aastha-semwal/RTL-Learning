# Day 22 - UART Transmitter (TX)

## 📌 Project Overview
Designed a UART (Universal Asynchronous Receiver Transmitter) Transmitter using Verilog HDL.

The transmitter serially sends 8-bit data with one Start Bit and one Stop Bit.

---

## UART Frame Format

Idle → Start Bit → 8-bit Data (LSB First) → Stop Bit

```
Idle = 1
Start = 0
Data = 8 Bits
Stop = 1
```

---

## Files

- uart_tx.v
- uart_tx_tb.v
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
iverilog -o uart_tx_sim uart_tx.v uart_tx_tb.v
```

## Run

```bash
vvp uart_tx_sim
```

## Open GTKWave

```bash
gtkwave uart_tx.vcd
```

---

## Results

- Successfully Compiled
- Successfully Simulated
- UART TX Verified
- GTKWave Verified

---

## Learning Outcomes

- UART Protocol
- Serial Communication
- FSM Design
- Shift Register
- Sequential Logic