# 📅 Day 28 – APB Master Controller (Verilog)

## 📌 Overview

This project implements an **AMBA APB (Advanced Peripheral Bus) Master Controller** in Verilog HDL. The controller performs APB write and read transactions using a finite state machine (FSM) following the APB protocol.

The design was verified using a self-checking testbench and simulated with **Icarus Verilog** and **GTKWave**.

---

## ✨ Features

- ✅ AMBA APB Master Protocol
- ✅ FSM-Based Design
- ✅ Write Transaction Support
- ✅ Read Transaction Support
- ✅ APB Handshake using `PREADY`
- ✅ Parameterized Address/Data Width
- ✅ Simulation Verified
- ✅ GTKWave Waveform Generated

---

## 📂 Project Structure

```
Day28_APB_Master/
│── apb_master.v
│── apb_master_tb.v
│── apb_master.vcd
│── README.md
```

---

## 🏗️ FSM States

```
          +-------+
          | IDLE  |
          +-------+
              |
              v
          +-------+
          | SETUP |
          +-------+
              |
              v
         +---------+
         | ACCESS  |
         +---------+
              |
        PREADY = 1
              |
              v
          +------+
          | DONE |
          +------+
              |
              +-------> IDLE
```

---

## 📡 APB Signals

| Signal | Description |
|---------|-------------|
| PSEL | Peripheral Select |
| PENABLE | Enable Signal |
| PWRITE | Read/Write Control |
| PADDR | Address Bus |
| PWDATA | Write Data |
| PRDATA | Read Data |
| PREADY | Transfer Complete |

---

## 🛠️ Tools Used

- Verilog HDL
- Icarus Verilog
- GTKWave
- VS Code
- Git & GitHub

---

## ▶️ Compile

```bash
iverilog -Wall -o apb_master_sim apb_master.v apb_master_tb.v
```

---

## ▶️ Run

```bash
vvp apb_master_sim
```

---

## 📊 View Waveform

```bash
gtkwave apb_master.vcd
```

---

## 📷 Simulation

The waveform verifies:

- APB Write Transaction
- APB Read Transaction
- PSEL Assertion
- PENABLE Assertion
- Address Transfer
- Data Transfer
- PREADY Handshake
- FSM State Transition

---

## 🎯 Learning Outcomes

- AMBA APB Protocol
- FSM Design
- Bus Interface Design
- RTL Coding Style
- Testbench Development
- Waveform Debugging

---

## 🚀 Progress

✅ Day 28 Completed

**RTL Learning Challenge**
- ✅ UART + FIFO
- ✅ I²C Master
- ✅ APB Master

➡️ Next Project: **Day 29 – AXI Lite Master Controller**

---

## 👩‍💻 Author

**Aastha Semwal**

B.Tech Electronics & Communication Engineering (ECE)

Passionate about RTL Design • Verilog HDL • FPGA • Digital Design

Preparing for **GATE 2027**