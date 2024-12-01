import processing.serial.*; // Import the serial library
import processing.sound.*;

Serial myPort; // Create a Serial object
SinOsc sine;

int[] buttonState = new int[10]; // Array to store the state of the buttons
long[][] duration = new long[10][2]; // Array to store the time duration
String[] schools = {
    "KM/AL-MANAR CENTRAL COLLEGE",
    "MN/ST. XAVIER'S GIRLS' COLLEGE",
    "J/VEMBADI GIRLS' HIGH SCHOOL",
    "J/METHODIST GIRLS' HIGH SCHOOL",
    "T/R. K. M SRI KONESHWARA HINDU COLLEGE",
    "V/VAVUNIYA TAMIL MADHYA MAHA VIDYALAYAM",
    "KN/KILINOCHCHI MAHA VIDYALAYAM",
    "N/HZ/HIGHLANDS COLLEGE.",
    "MU/VIDYANANDA COLLEGE",
    "BT/PD/PADDIRUPPU MADHYA MAHA VIDYALAYAM"
    
    /*
    "J/VEMBADI GIRLS' HIGH SCHOOL",
    "J/METHODIST GIRLS' HIGH SCHOOL",
    "KN/KILINOCHCHI MAHA VIDYALAYAM",
    "MU/VIDYANANDA COLLEGE",
    "BT/PD/PADDIRUPPU MADHYA MAHA VIDYALAYAM",
    "T/R. K. M.SRI KONESHWARA HINDU COLLEGE",
    "V/VAVUNIYA TAMIL MADHYA MAHA VIDYALAYAM",
    "MN/ST. XAVIER'S GIRLS' COLLEGE",
    "KM/AL-MANAR CENTRAL COLLEGE",
    "N/HZ/HIGHLANDS COLLEGE."
    */
};
String schName;

long startTime; // Variable to store the start time
boolean timerActive = true; // Flag to control the timer

PImage img1, img2, qf;

int b = 0;

PFont font, c_font, s_font; // Declare font variables globally

void setup() {
    size(1760, 990, P3D);
    surface.setTitle("QFiest");
    surface.setResizable(true);
    pixelDensity(displayDensity());
    smooth();

    myPort = new Serial(this, Serial.list()[0], 9600);

    // Load fonts
    font = createFont("Arial", 30); 
    c_font = createFont("DS-Digital", 150);
    s_font = createFont("DS-Digital", 60);
    
    for (int i = 0; i < 10; i++) {
        buttonState[i] = 0;
        duration[i][1] = 0;
        duration[i][0] = 0;
    }
    
    startTime = millis(); // Store the start time in milliseconds
    
    img1 = loadImage("person.png");
    img2 = loadImage("redperson.png");
    qf = loadImage("qf7.png");
    
    sine = new SinOsc(this);
    
    frameRate(1000);
}

void draw() {
    long timeT = millis();
    long minutesT = 0, secondsT = 0, millisecondsT = 0;

    if (timerActive && (timeT - startTime) < 120000) {
        // Timer is running and hasn't reached 120 seconds
        minutesT = ((timeT - startTime) / 60000) % 60;
        secondsT = ((timeT - startTime) / 1000) % 60;
        millisecondsT = (timeT - startTime) % 1000;
        image(qf, 0, 0, width, height);
    } else {
        // Timer stops here
        timerActive = false;
        minutesT = (120000 / 60000) % 60;
        secondsT = (120000 / 1000) % 60;
        millisecondsT = 120000 % 1000;
        image(qf, 0, 0, width, height); // Optional: clear the screen
    }

    while (myPort.available() > 0) {
        int inByte = myPort.read();
        int button = inByte & 0b00001111;
        int state = inByte & 0b00010000;

        if (button != 10 && timerActive) { 
            if ((state == 0) && (buttonState[button] == 0)) {
                buttonState[button] = 1;
                duration[b][0] = button + 1;
                duration[b][1] = millis();
                b++;
            }

            if (state == 0) {
                sine.play();
                sine.freq(150);
                delay(10);
            } else {
                sine.stop();
            }
        }

        // Reset logic
        if ((button == 10) && (state == 0)) {
            for (int i = 0; i < 10; i++) {
                buttonState[i] = 0;
                duration[i][1] = 0;
                duration[i][0] = 0;
            }
            startTime = millis();
            b = 0;
            timerActive = true; // Reactivate the timer
        }
    }

    // Display logic for images and text
    for (int i = 0; i < 10; i++) {
        if (buttonState[i] == 1) {
            image(img2, 120 + i * 170, 50, 150, 150);
        } else {
            image(img1, 120 + i * 170, 50, 150, 150);
        }

        textSize(50);
        fill(255);
        textFont(font);
        text(i + 1, 190 + i * 171, 180);
    }

    int y = 0;
    for (int i = 0; i < 10; i++) {
        if (duration[i][0] > 0) {
            long minutes = (duration[i][1] - startTime) / 60000;
            long seconds = ((duration[i][1] - startTime) % 60000) / 1000;
            long milliseconds = (duration[i][1] - startTime) % 1000;

            schName = schools[(int)duration[i][0] - 1];

            textAlign(LEFT);
            textSize(30);
            fill(0, 0, 0);
            textFont(font);
            text(schName, 300, 450 + y * 60);
            textAlign(RIGHT);
            textSize(40);
            fill(0, 0, 0);
            textFont(s_font);
            text(minutes + " : " + seconds + " : " + milliseconds, 1750, 450 + y * 60);
            line(260, 460 + y * 60, 1800, 460 + y * 60);
            y++;
        }
    }

    // Change text color based on timer state
    if ((minutesT * 60 * 1000) + (secondsT * 1000) + millisecondsT >= 120000) {
        fill(255, 0, 0); // Red for stopped timer
    } else {
        fill(117, 4, 108); // Default purple
    }

    // Display the formatted time
    textAlign(CENTER);
    textSize(60);
    textFont(c_font);
    text(minutesT + " : " + secondsT + " : " + millisecondsT, 960, 350);
}
