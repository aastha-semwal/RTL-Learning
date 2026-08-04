# Day 25 - SPI Master Controller (Verilog)

## 📌 Project Overview

This project implements an SPI (Serial Peripheral Interface) Master Controller using Verilog HDL.

The SPI Master communicates with an SPI Slave using four standard SPI signals.

- MOSI (Master Out Slave In)
- MISO (Master In Slave Out)
- SCLK (Serial Clock)
- CS_N (Chip Select - Active Low)

This implementation supports SPI Mode-0.

---

# Features

- Parameterized Data Width
- Parameterized Clock Divider
- FSM Based Design
- SPI Mode-0 Communication
- Serial Data Transmission
- Serial Data Reception
- Busy Flag
- Done Flag
- Shift Register Based Design
- Synthesizable RTL

---

# SPI Signals

| Signal | Description |
|---------|-------------|
| MOSI | Master Transmits Data |
| MISO | Slave Transmits Data |
| SCLK | SPI Clock |
| CS_N | Chip Select (Active Low) |

---

# SPI Mode

- CPOL = 0
- CPHA = 0

Idle Clock = LOW

Data changes on Falling Edge.

Data is sampled on Rising Edge.

---

# FSM

```
           +------+
           | IDLE |
           +------+
               |
            Start=1
               |
               V
          +---------+
          |  LOAD   |
          +---------+
               |
               V
        +--------------+
        |  TRANSFER    |
        +--------------+
               |
      All Bits Completed
               |
               V
         +-----------+
         |  FINISH   |
         +-----------+
               |
               V
             IDLE
```

---

# Directory Structure

```
SPI_Master/
│
├── spi_master.v
├── spi_master_tb.v
├── spi_master.vcd
└── README.md
```

---

# Compile

```bash
iverilog -Wall -o spi_master_sim spi_master.v spi_master_tb.v
```

---

# Run

```bash
vvp spi_master_sim
```

---

# View Waveform

```bash
gtkwave spi_master.vcd
```

---

# Simulation Result

Example Output

```
SPI MASTER SIMULATION COMPLETED

Last TX Data : 3C

Last RX Data : 55
```

---

# Learning Outcomes

After completing this project you will understand

- SPI Protocol
- SPI Timing
- Master Controller Design
- Clock Divider
- FSM Design
- Shift Registers
- Serial Communication
- Testbench Writing
- GTKWave Debugging

---

# Applications

- EEPROM
- Flash Memory
- SD Card
- ADC
- DAC
- Sensors
- Display Controllers
- FPGA to MCU Communication

---

# Future Improvements

- SPI Mode 0,1,2,3
- Configurable Clock Frequency
- Multiple Slave Support
- FIFO Interface
- Interrupt Support
- AXI/APB Wrapper

---

# Author

**Aastha Semwal**

B.Tech Electronics & Communication Engineering

RTL Design Learning Journey

Day 25 of 30 Days Verilog Challenge

---

# License

This project is created for educational purposes.