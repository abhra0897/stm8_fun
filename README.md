[Proper README will be written later]

Trying to make a POV display using stm8 mcu as I'm learning stm8. 

The stm8 is connected to a 4Mbit Adesto spi standard flash where images/animations might be stored. Currently preparing the flash driver. Once it works, I'll decide if ws2812 will be used or normal LEDs with LED driver IC will be used.

### TO DO:
- Complete the flash driver and make it work properly [ working here]
- Load data to flash using UART from PC (images/ animation)
- Read the loaded data from the flash
- Make the circuit in KiCAD
- Select what LED to use (WS2812? or normal LED with serial LED-driver IC?)
- Write LED driver and make it work
- Read from flash and drive LEDs based on that data
- And lots of other works related to the motor selection/body design/power transfer (slip ring or wireless?) etc..