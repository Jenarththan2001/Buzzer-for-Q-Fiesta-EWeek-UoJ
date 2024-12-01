const int numButtons = 3; // number of buttons including reset
const int buttonPins[] = {2,3,13}; // pins for the buttons; 13 for reset
const int buzzerPin = 12; // pin for the buzzer

void setup() {
  Serial.begin(9600); // start serial communication at 9600 baud
  for (int i = 0; i < numButtons; i++) {
    pinMode(buttonPins[i], INPUT_PULLUP); // set the button pins as inputs with pull-up resistors
  }
  
  pinMode(buzzerPin, OUTPUT); // set the buzzer pin as output
}

void loop() {
  for (int i = 0; i < numButtons; i++) {
    int buttonState = digitalRead(buttonPins[i]); // read the state of the button
    Serial.print(buttonState);
    Serial.write(i | (buttonState << 4)); // send the button number and state over serial
    
    // Check if the button is pressed (LOW)
    if (buttonState == LOW) {
      // Add buzzer sound here
      tone(buzzerPin, 1500, 200); // Example: 1kHz tone for 200 milliseconds
     // Add a delay to avoid continuous buzzing for a single press
    }
  }
  delay(10); // delay for 10 milliseconds
}
