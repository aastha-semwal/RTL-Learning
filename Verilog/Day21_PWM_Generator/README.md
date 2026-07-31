# Day 21 - PWM Generator

## 📌 Project Overview
Designed an 8-bit PWM (Pulse Width Modulation) Generator in Verilog HDL.

The PWM signal is generated using an 8-bit counter and an adjustable duty cycle input.

---

## 📚 Topics Covered
- Pulse Width Modulation (PWM)
- 8-bit Counter
- Duty Cycle Control
- Sequential Logic
- Digital Design using Verilog HDL

---

## 📂 Files
- pwm_generator.v
- pwm_generator_tb.v
- README.md

---

## ⚙️ Tools Used
- Verilog HDL
- Icarus Verilog
- GTKWave
- VS Code
- Git & GitHub

---

## ▶️ Simulation Flow

Compile

```bash
iverilog -o pwm_generator_sim pwm_generator.v pwm_generator_tb.v
```

Run

```bash
vvp pwm_generator_sim
```

Open Waveform

```bash
gtkwave pwm_generator.vcd
```

---

## 🧪 Test Cases

| Duty Cycle | Decimal Value |
|------------|--------------:|
| 25% | 64 |
| 50% | 128 |
| 75% | 192 |
| 100% | 255 |
| 0% | 0 |

---

## ✅ Results
- Successfully Compiled
- Successfully Simulated
- Verified using GTKWave
- PWM output generated correctly for different duty cycles

---

## 📅 RTL Learning Progress

**Day 21** of my RTL Design Learning Journey.