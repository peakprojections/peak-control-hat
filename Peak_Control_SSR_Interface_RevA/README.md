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

Primary SSR: **Omron G3VM-61GR2** (60 V PhotoMOS, SOP-4).

Each output channel is conceptually:

`Pi GPIO -> 390R -> G3VM-61GR2 input LED`

`+24V field -> G3VM-61GR2 output -> SW +24V terminal -> external contactor coil -> field 0V`

Each channel also includes board-side flyback suppression across the output terminals.

## I2C expansion

A dedicated 4-position terminal block is included:

1. 3V3
2. GND
3. SDA (GPIO2 / physical pin 3)
4. SCL (GPIO3 / physical pin 5)

Optional SDA/SCL pull-up footprints are intended to be DNP by default because the Raspberry Pi already supplies I2C pull-ups. Series-resistor footprints allow 0-ohm links initially or modest damping if useful during testing.

Raw I2C should be treated as a short-range internal expansion interface. Longer remote runs should eventually use an appropriate extender, CAN, RS-485, or similar robust field bus.

## Current files

- `Peak_Control_HAT_SSR_RevA.sch` — initial schematic source in KiCad legacy format, ready to open/import and save into the current `.kicad_sch` format.
- `Peak_Control_HAT_SSR_RevA.kicad_pcb` — separate SSR mechanical/placement skeleton using the corrected Pi/header/mounting geometry.
- `Peak_Control_HAT_SSR_RevA.kicad_pro` — project container; KiCad will populate normal project settings when opened/saved.
- `Electrical_Design_SSR_RevA.md` — electrical architecture, protection intent, routing targets, and fabrication hold points.
- `Pin_Map_SSR_RevA.csv` — GPIO/function map for the simplified board.

## Important fabrication note

The G3VM symbols and PCB locations are currently **design placeholders**. The exact Omron G3VM-61GR2 pin numbering and recommended SOP-4 land pattern must be verified and substituted before routing or fabrication. The proof-input, IR-buffer, and fan-control circuits also remain to be finalized.

## Status

The SSR revision is now established as an independent project without modifying the TPS-based design. The next step is to open/import the schematic in KiCad, save it in the current `.kicad_sch` format, then continue detailed schematic capture and verified footprint assignment before routing.
