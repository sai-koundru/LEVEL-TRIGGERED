# LEVEL-TRIGGERED

# 🔁 Level-Triggered Serial Data Shifter (Verilog)

This project implements a **level-triggered serial data transmitter** in Verilog. It outputs one bit at a time from a parallel 8-bit data word (`10101101`) using a **custom slower serial clock (`sclk`)** derived from a high-speed system clock.

---

## ⚙️ Module Overview

### 📌 Module Name: `level_triggered_data_shift`

This module simulates how data bits are shifted out serially using a **level-triggered protocol** with controlled timing. It mimics a simplified behavior similar to that seen in protocols like I²C or SPI (but without protocol complexity).

---

## 🧠 Behavior Description

| Signal | Direction | Description                                          |
|--------|-----------|------------------------------------------------------|
| `clk`  | Input     | Fast system clock (e.g., 100 MHz)                    |
| `sclk` | Output    | Serial clock generated internally (slower)          |
| `sda`  | Output    | Serial data line, shifts out 1 bit per `sclk` cycle |

- **Data**: `10101101` (MSB first)
- **Clock division**: `sclk` toggles every 50 `clk` cycles
- **Shifting happens**:
  - On falling edge of `sclk`: `sda` is updated with the next bit
  - On rising edge: internal counter is incremented

---

## 📊 Internal Design Summary

| Component     | Purpose                                  |
|---------------|------------------------------------------|
| `data[7:0]`   | Parallel data to be serialized            |
| `bit_cnt[3:0]`| Tracks current bit being transmitted      |
| `clk_div[7:0]`| Clock divider to slow down `sclk`         |
| `state`       | Tracks the high/low level of `sclk`       |

---

## 💾 Example Code Snippet

```verilog
if (~state) begin
    sda <= data[7 - bit_cnt];  // Output new bit on falling edge of sclk
end else begin
    bit_cnt <= bit_cnt + 1;    // Increment bit index on rising edge
end
