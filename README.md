# Buzzer for Q-Fiesta (E-Week UoJ)

This repository contains the code and assets for the Q-Fiesta event during E-Week at the University of Jaffna. The project was originally created by our seniors and has been updated with improvements, including integration with a physical buzzer and enhanced UI.

## Features
- Supports buzzer functionality for two teams or ten teams.
- Real-time interface with a timer and participant tracking.
- Physical buzzer integration via Arduino and breadboard setup.
- Customizable interface with school names and assets.

## Repository Structure
- `TwoTeams`: Code for the two-team buzzer setup.
  - `Arduino_Code`: Contains the Arduino sketch for the two-team buzzer.
  - `ShowNames_Code`: Processing code for the interface, including assets.
- `TenTeams`: Code for the ten-team buzzer setup.
  - `Arduino_Code`: Contains the Arduino sketch for the ten-team buzzer.
  - `ShowNames_Code`: Processing code for the interface, including assets.
- `Fonts`: Includes the `DS-Digital` font required for the timer.

## Setup and Usage
### Prerequisites
1. Install the [Arduino IDE](https://www.arduino.cc/en/software).
2. Install [Processing IDE](https://processing.org/download/).
3. Download the `DS-Digital` font and install it on your system.

### Steps
1. Connect the buttons and buzzer to the Arduino board as per the code's pin configuration.
2. Upload the appropriate Arduino sketch (`buzzer_two_teams.ino` or `buzzer_ten_teams.ino`) using the Arduino IDE.
3. Open the Processing code (`show_names.pde` or `show_names_ten.pde`) in the Processing IDE.
4. Place the assets (`person.png`, `redperson.png`, `qf7.png`) in the same folder as the Processing code.
5. Run the Processing sketch to start the buzzer system.


## Notes
- Ensure the correct COM port is selected in both Arduino and Processing IDEs.
- Modify school names in the Processing code as needed.
- Timer stops after 120 seconds.

## License
This repository is intended for educational use by students of the University of Jaffna.

**Enjoy Q-Fiesta!**