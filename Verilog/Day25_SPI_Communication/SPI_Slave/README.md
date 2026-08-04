# Day 25 - SPI Slave Controller (Verilog)

## 📌 Project Overview

This project implements an SPI (Serial Peripheral Interface) Slave Controller using Verilog HDL.

The SPI Slave communicates with an SPI Master through the standard SPI interface and receives/transmits serial data using shift registers.

This implementation follows **SPI Mode-0**.

---

# Features

- Parameterized Data Width
- SPI Mode-0 Compatible
- Shift Register Based Design
- Serial Data Reception (MOSI)
- Serial Data Transmission (MISO)
- Chip Select (CS_N) Support
- Done Flag Generation
- Synthesizable RTL

---

# SPI Signals

| Signal | Description |
|---------|-------------|
| MOSI | Master Out Slave In |
| MISO | Master In Slave Out |
| SCLK | Serial Clock |
| CS_N | Chip Select (Active Low) |

---

# SPI Mode

- CPOL = 0
- CPHA = 0

- Idle Clock = LOW
- Data sampled on Rising Edge
- Data shifted on Falling Edge

---

# Block Diagram

```text
        +----------------------+
MOSI --->|                      |
SCLK --->|      SPI SLAVE       |----> MISO
CS_N --->|                      |
        +----------------------+
```

---

# Internal Architecture

- Receive Shift Register
- Transmit Shift Register
- Bit Counter
- Done Flag Logic

---

# Operation

1. CS_N goes LOW to select the slave.
2. Slave loads transmit data into the transmit shift register.
3. On every clock:
   - Samples MOSI.
   - Shifts out MISO.
4. After all bits are transferred:
   - Received data is stored.
   - DONE becomes HIGH.

---

# Directory Structure

```text
SPI_Slave/
│
├── spi_slave.v
├── spi_slave_tb.v
├── spi_slave.vcd
└── README.md
```

---

# Compile

```bash
iverilog -Wall -o spi_slave_sim spi_slave.v spi_slave_tb.v
```

---

# Run

```bash
vvp spi_slave_sim
```

---

# View Waveform

```bash
gtkwave spi_slave.vcd
```

---

# Simulation Summary

- RTL compiled successfully.
- Testbench executed successfully.
- DONE flag asserted after transfer.
- Waveform generated for analysis.

---

# Learning Outcomes

After completing this project, you will understand:

- SPI Slave Operation
- SPI Timing
- Shift Registers
- Serial Data Communication
- Bit Counter Logic
- Chip Select Handling
- Verilog Testbench Writing
- GTKWave Debugging

---

# Applications

- EEPROM
- Flash Memory
- Sensors
- ADC/DAC
- Microcontroller Communication
- FPGA Peripherals
- Embedded Systems

---

# Future Improvements

- SPI Modes 0/1/2/3
- FIFO Buffer
- Variable Data Width
- Error Detection
- Multi-Slave Support

---

# Author

**Aastha Semwal**

B.Tech Electronics & Communication Engineering

RTL Design Learning Journey

Day 25 – SPI Slave Controller

---

# License

This project is created for educational purposes.