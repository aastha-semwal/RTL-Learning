# Day 25 – SPI Communication (Verilog HDL)

## 📌 Overview

This project demonstrates the implementation of the **Serial Peripheral Interface (SPI)** protocol using **Verilog HDL**. The project is divided into three parts:

1. SPI Master
2. SPI Slave
3. SPI Master–Slave Integration

The design follows **SPI Mode-0 (CPOL = 0, CPHA = 0)** and demonstrates full-duplex serial communication between master and slave devices.

---

# 📂 Project Structure

```
Day25_SPI_Communication/
│
├── SPI_Master/
│   ├── spi_master.v
│   ├── spi_master_tb.v
│   └── README.md
│
├── SPI_Slave/
│   ├── spi_slave.v
│   ├── spi_slave_tb.v
│   └── README.md
│
├── SPI_Integration/
│   ├── spi_top.v
│   ├── spi_top_tb.v
│   └── README.md
│
└── README.md
```

---

# 🚀 Project Features

- SPI Master Controller
- SPI Slave Controller
- Full Duplex Communication
- Parameterized Data Width
- Configurable Clock Divider
- Shift Register Based Data Transfer
- Busy & Done Status Signals
- Synthesizable RTL
- Self-Checking Testbench
- GTKWave Compatible

---

# 📡 SPI Signals

| Signal | Description |
|---------|-------------|
| MOSI | Master Out Slave In |
| MISO | Master In Slave Out |
| SCLK | Serial Clock |
| CS_N | Chip Select (Active Low) |

---

# ⚙ SPI Mode

- CPOL = 0
- CPHA = 0

- Idle Clock = LOW
- Data sampled on Rising Edge
- Data shifted on Falling Edge

---

# 📁 Modules

## 1️⃣ SPI Master

Responsible for:

- Generating SPI Clock
- Controlling Chip Select
- Sending MOSI Data
- Receiving MISO Data
- Managing SPI Transfer FSM

---

## 2️⃣ SPI Slave

Responsible for:

- Receiving MOSI Data
- Sending MISO Data
- Shift Register Operations
- Done Signal Generation

---

## 3️⃣ SPI Integration

Integrates both modules and performs complete SPI communication.

Connections:

```
Master MOSI ─────────► Slave MOSI

Slave MISO ◄───────── Master MISO

Master SCLK ─────────► Slave SCLK

Master CS_N ─────────► Slave CS_N
```

---

# 📊 Simulation Result

```
Master TX : A5
Master RX : 1E

Slave TX  : 3C
Slave RX  : A5
```

The simulation verifies:

- Successful Master-to-Slave communication
- Successful Slave data transmission
- Busy signal operation
- Done signal operation
- Complete SPI transaction

---

# ▶️ Compilation

### SPI Master

```bash
iverilog -Wall -o spi_master_sim spi_master.v spi_master_tb.v
```

### SPI Slave

```bash
iverilog -Wall -o spi_slave_sim spi_slave.v spi_slave_tb.v
```

### SPI Integration

```bash
iverilog -Wall -o spi_top_sim spi_top.v spi_top_tb.v ../SPI_Master/spi_master.v ../SPI_Slave/spi_slave.v
```

---

# ▶️ Run Simulation

```bash
vvp spi_master_sim
```

```bash
vvp spi_slave_sim
```

```bash
vvp spi_top_sim
```

---

# 📈 View Waveform

```bash
gtkwave spi_master.vcd
```

```bash
gtkwave spi_slave.vcd
```

```bash
gtkwave spi_top.vcd
```

---

# 📚 Concepts Learned

- SPI Protocol
- SPI Modes
- Full Duplex Communication
- Finite State Machine (FSM)
- Shift Registers
- Clock Divider
- Serial Data Transfer
- RTL Design
- Testbench Development
- Waveform Analysis
- Module Integration

---

# 💡 Applications

- EEPROM
- Flash Memory
- ADC/DAC Interfaces
- Sensors
- FPGA Communication
- Embedded Systems
- Microcontrollers
- Industrial Automation

---

# 🛠 Tools Used

- Verilog HDL
- Icarus Verilog
- GTKWave
- Visual Studio Code
- Git & GitHub

---

# 🎯 Learning Outcome

After completing this project, you will understand:

- SPI Protocol Architecture
- Master–Slave Communication
- Serial Interface Design
- RTL Coding Style
- Testbench Creation
- Digital Communication Timing
- Waveform Debugging
- Hierarchical Module Design

---

# 📅 RTL Learning Journey

- ✅ SPI Master Design
- ✅ SPI Master Testbench
- ✅ SPI Slave Design
- ✅ SPI Slave Testbench
- ✅ SPI Integration
- ✅ Complete Verification

---

# 👩‍💻 Author

**Aastha Semwal**

B.Tech – Electronics & Communication Engineering

RTL Design Learning Journey

**Day 25 – SPI Communication**

---

# 📜 License

This project is developed for educational and learning purposes.