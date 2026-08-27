# Peak Control HAT SSR Rev A

This directory is the first-revision **simple/production-oriented SSR version** of the Peak Projections Power Control HAT.

It is intentionally separate from `Peak_Control_HAT_RevA`, which remains the more advanced smart-switch/TPS272C45 design for possible future development.

## Design goals

- Keep the first hardware revision simple, robust, and economical.
- Use Omron PhotoMOS SSRs for isolated 24 V contactor/control outputs.
- Preserve the Raspberry Pi GPIO mapping used by the advanced design where practical so software can remain hardware-agnostic.
- Retain the corrected Raspberry Pi HAT mechanical geometry from the existing design.
- Provide I2C expansion directly from the Pi for future diagnostics/display/daughterboards.
- Keep mains/load switching off-board; this HAT controls 24 V contactor coils and low-voltage control circuits only.

## Proposed board

- 115 mm × 70 mm extended HAT-style PCB target
- Raspberry Pi 2×20 stacking header
- Raspberry Pi M2.5 mounting pattern
- 40 mm fan mechanical provision retained
- 24 V control input
- 4 isolated 24 V switched outputs
- 2 field/proof inputs
- 2 IR output connections
- 4-position I2C expansion terminal: `3V3`, `GND`, `SDA`, `SCL`
- 3-wire fan connector: `5V`, `GND`, `TACH`

## Output architecture

Primary SSR candidate: **Omron G3VM-61GR2** (60 V PhotoMOS, SOP-4).

Each output channel is conceptually:

`Pi GPIO -> LED current-limiting resistor -> G3VM-61GR2 input`

`24 V control supply -> contactor/load -> G3VM-61GR2 output -> control return`

Final polarity/topology, coil suppression, connector pinout, resistor values, footprints, and protection components will be locked in the schematic before routing/fabrication.

## I2C expansion

A dedicated 4-position terminal block is included in the V1 design intent:

1. 3V3
2. GND
3. SDA (GPIO2 / physical pin 3)
4. SCL (GPIO3 / physical pin 5)

Optional SDA/SCL pull-up footprints should be provided and normally left DNP because the Raspberry Pi already supplies I2C pull-ups. Series-resistor footprints may also be provided to allow 0-ohm links or modest series damping if useful during testing.

Raw I2C should be treated as a short-range internal expansion interface. Longer remote runs should eventually use an appropriate extender, CAN, RS-485, or similar robust field bus.

## Status

This directory establishes the SSR Rev A architecture and documentation without modifying the existing TPS-based files. The next KiCad work should create the dedicated SSR schematic and PCB project here using the corrected mechanical geometry as the reference.
