# Day 27 – I²C Master Controller (Verilog HDL)

## 📌 Project Overview

This project implements a basic **I²C Master Controller** in Verilog HDL.

The design demonstrates the working of the I²C protocol by generating:

- START Condition
- 7-bit Slave Address Transmission
- Read/Write Bit
- ACK State
- STOP Condition

The controller is implemented using a Finite State Machine (FSM) and verified through simulation.

---

# 📂 Project Structure

```
Day27_I2C_Master/
│
├── i2c_master.v
├── i2c_master_tb.v
├── i2c_master.vcd
└── README.md
```

---

# 🚀 Features

- I²C Master FSM
- START Condition Generation
- 7-bit Address Transmission
- Read/Write Bit Support
- ACK State
- STOP Condition
- Synthesizable RTL
- GTKWave Compatible
- Parameterized Design

---

# Module Description

## i2c_master.v

Implements the I²C Master Controller.

### Inputs

- clk
- reset
- start
- slave_addr[6:0]
- rw

### Outputs

- scl
- sda
- busy
- done

---

# FSM States

```
IDLE
   ↓
START
   ↓
ADDRESS
   ↓
ACK
   ↓
STOP
   ↓
FINISH
   ↓
IDLE
```

---

# RTL Block Diagram

```
                 +----------------------+
                 |    I2C Master FSM    |
                 +----------+-----------+
                            |
             +--------------+--------------+
             |                             |
           SCL                           SDA
```

---

# Simulation Result

```
====================================
    I2C MASTER SIMULATION DONE
====================================
Slave Address : 42
Read/Write    : 0
====================================
```

---

# GTKWave

Signals observed:

- clk
- start
- busy
- done
- scl
- sda

Waveform verifies:

- START condition
- Address transmission
- STOP condition
- Transaction completion

---

# How to Compile

```bash
iverilog -Wall -o i2c_master_sim i2c_master.v i2c_master_tb.v
```

---

# Run Simulation

```bash
vvp i2c_master_sim
```

---

# Open Waveform

```bash
gtkwave i2c_master.vcd
```

---

# Concepts Learned

- I²C Protocol Basics
- Serial Communication
- START & STOP Conditions
- Address Transmission
- FSM Design
- Verilog RTL Coding
- Testbench Development
- Simulation & Debugging
- GTKWave Analysis

---

# Tools Used

- Verilog HDL
- Icarus Verilog
- GTKWave
- VS Code
- Git
- GitHub

---

# Future Improvements

- ACK Detection from Slave
- NACK Handling
- Multi-byte Data Transfer
- Clock Stretching
- Repeated START Support
- Read Transaction Support

---

# Author

**Aastha Semwal**

B.Tech Electronics & Communication Engineering (ECE)

RTL Design Learning Journey

**Day 27 Project**