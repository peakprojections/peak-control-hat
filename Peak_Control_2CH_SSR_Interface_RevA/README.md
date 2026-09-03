# Peak Control 2CH SSR Interface Rev A1.1

This directory is the first-revision **simple/production-oriented 2-Channel SSR version** of the Peak Projections Power Control Interface Board.

It is intentionally separate from `Peak_Control_HAT_RevA`, which remains the more advanced smart-switch/TPS272C45 design for possible future development. 

It is a scaled down version of the `Peak_Control_SSR_Interface_RevA` which is the 4-channel version.

## Design goals

- Keep the first hardware revision simple, robust, and economical.
- Use Omron PhotoMOS SSRs for isolated 24 V contactor/control outputs.
- Keep mains/load switching off-board; this board controls 24 V contactor coils from low-voltage control circuits only.

## Proposed board

- Raspberry Pi M2.5 mounting pattern
- 24 V control input
- 2 isolated 24 V switched outputs

## Output architecture

Primary SSR: **Omron G3VM-61GR2** (60 V PhotoMOS, SOP-4).

Each output channel is conceptually:

`Pi GPIO -> 390R -> G3VM-61GR2 input LED`

`+24V field -> G3VM-61GR2 output -> SW +24V terminal -> external contactor coil -> field 0V`

Each channel also includes board-side flyback suppression across the output terminals.

## Practical Implementations

This board is designed to work with a Raspberry Pi and has a mounting-hole pattern to be stacked above or below a Pi (long standoffs should be used to keep a distance). 

This board should support any 3.3v output microcontroller connection, it does not have to be a Raspberry Pi.
