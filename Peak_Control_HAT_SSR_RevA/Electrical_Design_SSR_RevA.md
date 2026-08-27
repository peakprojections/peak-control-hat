# Peak Control HAT SSR Rev A — Electrical Design

## Purpose

Rev A SSR is the simplified first-production-oriented Peak Power Control HAT. The Raspberry Pi controls isolated 24 V contactor/control outputs through Omron G3VM-61GR2 PhotoMOS relays. Mains/load switching remains external to the HAT.

## 24 V field input

- J2: +24 V / 0 V field input.
- F1: 3 A input fuse target.
- D1: 24 V bus TVS target; SMBJ33A shown in the draft schematic.
- C1: 47 uF / 50 V bulk capacitance.
- C2: 1 uF / 50 V local bypass.
- Field-side 0 V remains isolated from Raspberry Pi ground across the four PhotoMOS output channels.

## Output channels

Four identical channels:

- OUT1 / Projector: GPIO16, physical pin 36.
- OUT2 / Viewer: GPIO19, physical pin 35.
- OUT3 / Aux1: GPIO22, physical pin 15.
- OUT4 / Aux2: GPIO23, physical pin 16.

Each Pi GPIO drives the input LED of one G3VM-61GR2 through a 390 ohm current-limiting resistor. The target LED current is approximately 4–5 mA from a 3.3 V GPIO.

The isolated output side switches +24 V to the corresponding field-output terminal. Each output connector exposes:

1. SW +24 V
2. FIELD GND / 0 V

The intended external load is a 24 VDC contactor/relay coil or similar low-voltage control load.

## Flyback suppression

Each output includes a board-mounted flyback diode across the external-load terminals:

- Cathode: SW +24 V output node.
- Anode: FIELD GND.

The draft schematic shows 1N4007. Final diode selection may be changed before BOM lock based on measured contactor-coil current and desired release time.

## Omron SSR

Primary device: Omron G3VM-61GR2, 60 V SOP-4 PhotoMOS relay.

The initial schematic intentionally represents each relay with a generic four-pin symbol, and the PCB uses a placeholder package. The exact current Omron pin numbering and recommended land pattern must be verified against the manufacturer datasheet before fabrication. Do not fabricate from the placeholder footprint.

## I2C expansion

J11 is a four-position field terminal:

1. 3V3
2. GND
3. SDA — GPIO2 / physical pin 3
4. SCL — GPIO3 / physical pin 5

Optional 4.7 k pull-up footprints are included in the schematic intent and should normally be DNP because the Raspberry Pi already provides I2C pull-ups. Series-resistor footprints should support 0 ohm links initially and 33–100 ohm damping if testing warrants it.

I2C is intended for short internal wiring only. Longer remote expansions should use a bus extender or a more robust field bus such as RS-485 or CAN.

## Retained functions

The SSR board keeps the same functional GPIO assignments where practical:

- Proof input 1: GPIO24 / pin 18.
- Proof input 2: GPIO25 / pin 22.
- IR1 TX: GPIO18 / pin 12.
- IR2 TX: GPIO13 / pin 33.
- Fan control candidate: GPIO12 / pin 32.
- Fan tach: GPIO26 / pin 37.
- HAT ID SDA/SCL: GPIO0/GPIO1 reserved.

GPIO5, GPIO6, GPIO20, and GPIO21 are freed by removal of the TPS SEL/FLT circuitry and remain reserved for future expansion.

## PCB routing intent

- GPIO/I2C: 0.30 mm minimum trace target.
- 3.3 V: 0.50 mm minimum target.
- 5 V fan: 0.75–1.0 mm target.
- 24 V individual branches: 1.0–1.5 mm target depending on final coil-current specification.
- 24 V main trunk: 2.0 mm minimum or copper pour.
- Preserve generous isolation spacing between Pi-side logic and field-side SSR pads/traces.
- Use an inner ground plane for Pi-side logic while preserving the intended galvanic isolation boundary at PhotoMOS channels.

## Mechanical baseline

- 115 mm × 70 mm extended PCB.
- Raspberry Pi reference footprint: 65 mm × 56.5 mm.
- Pi mounting-hole centers: 58 mm × 49 mm spacing, centers 3.5 mm from reference edges.
- GPIO header datum retained from corrected Rev A2 board.
- 40 mm fan provision: 32 mm mounting-hole spacing and 34 mm airflow cutout retained as a concept feature.

## Fabrication hold points

Before generating Gerbers or ordering boards:

1. Replace generic G3VM symbols with a verified custom or library symbol.
2. Replace all G3VM placeholder footprints with the verified Omron SOP-4 land pattern.
3. Confirm exact terminal-block manufacturer/part number and drill/pitch.
4. Finalize proof-input conditioning/isolation.
5. Finalize IR output buffers and connector power voltage.
6. Finalize fan-control circuit.
7. Assign all nets from the Pi header and run ERC/DRC.
8. Verify creepage/clearance across every isolation boundary.
9. Verify the board/fan/heatsink stack mechanically on the exact Raspberry Pi model.
