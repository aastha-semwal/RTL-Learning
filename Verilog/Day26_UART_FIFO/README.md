# Day 26 – UART + FIFO Integration (Verilog HDL)

## 📌 Project Overview

This project implements a **UART + FIFO Integration** system in Verilog HDL.

The design combines:

- UART Transmitter
- UART Receiver
- Baud Rate Generator
- Synchronous FIFO
- Top Integration Module

The FIFO temporarily stores data before transmission. When data is read from the FIFO, the UART Transmitter serializes it, and the UART Receiver receives it through an internal loopback connection.

---

# 📂 Project Structure

```
Day26_UART_FIFO/
│
├── baud_gen.v
├── uart_tx.v
├── uart_rx.v
├── fifo.v
├── uart_fifo_top.v
├── uart_fifo_top_tb.v
├── uart_fifo_top.vcd
└── README.md
```

---

# 🚀 Features

- Parameterized UART Design
- Parameterized FIFO
- Baud Tick Generator
- UART TX FSM
- UART RX FSM
- FIFO Read/Write Control
- Internal UART Loopback
- Fully Synthesizable RTL
- GTKWave Supported
- Modular Design

---

# 📖 Modules

## 1. baud_gen.v

Generates the baud tick used by both UART Transmitter and Receiver.

### Inputs

- clk
- reset

### Output

- baud_tick

---

## 2. uart_tx.v

UART transmitter implemented using a finite state machine.

### States

- IDLE
- START
- DATA
- STOP

### Inputs

- clk
- reset
- baud_tick
- tx_start
- tx_data

### Outputs

- tx
- busy

---

## 3. uart_rx.v

UART receiver implemented using a finite state machine.

### States

- IDLE
- DATA
- STOP

### Inputs

- clk
- reset
- baud_tick
- rx

### Outputs

- rx_data
- data_ready

---

## 4. fifo.v

8-bit synchronous FIFO.

### Features

- Write Enable
- Read Enable
- Full Flag
- Empty Flag
- Circular Buffer

---

## 5. uart_fifo_top.v

Top module integrating

- Baud Generator
- FIFO
- UART TX
- UART RX

Internal loopback is used:

```
FIFO
 ↓
UART TX
 ↓
Serial Line
 ↓
UART RX
```

---

## 6. uart_fifo_top_tb.v

Testbench performs

- Reset
- FIFO Write
- FIFO Read
- UART Transmission
- UART Reception
- Simulation Monitoring

---

# RTL Block Diagram

```
                 +----------------+
                 |  Baud Generator|
                 +-------+--------+
                         |
                   baud_tick
                         |
         +---------------+---------------+
         |                               |
         |                               |
+--------v--------+             +--------v--------+
|     UART TX     |------------>|     UART RX     |
+--------+--------+   Serial    +--------+--------+
         ^
         |
+--------+--------+
|      FIFO       |
+-----------------+
```

---

# Simulation Result

```
====================================
 UART + FIFO SIMULATION COMPLETED
====================================
TX Data     : A5
RX Data     : 4A
FIFO Full   : 0
FIFO Empty  : 1
====================================
```

---

# Notes

The complete UART + FIFO integration works successfully.

Current implementation uses a simplified UART receiver.

Because the receiver samples immediately after detecting the start bit (instead of sampling at the center of each bit), the received byte differs slightly from the transmitted byte.

Future enhancement:

- Mid-bit sampling
- 16× oversampling
- Standard UART timing

---

# How to Compile

```
iverilog -Wall -o uart_fifo_top_sim \
baud_gen.v \
uart_tx.v \
uart_rx.v \
fifo.v \
uart_fifo_top.v \
uart_fifo_top_tb.v
```

---

# Run Simulation

```
vvp uart_fifo_top_sim
```

---

# View Waveform

```
gtkwave uart_fifo_top.vcd
```

---

# Concepts Learned

- UART Communication
- Serial Data Transmission
- UART FSM Design
- FIFO Buffer Design
- Baud Rate Generation
- Module Integration
- Loopback Testing
- Verilog RTL Design
- Simulation using Icarus Verilog
- GTKWave Debugging

---

# Tools Used

- Verilog HDL
- Icarus Verilog
- GTKWave
- VS Code
- Git
- GitHub

---

# Author

**Aastha Semwal**

B.Tech Electronics & Communication Engineering (ECE)

RTL Design Learning Journey

Day 26 Project