# GreenerPlus
### 1. Download and Installation:
- Download the APK on your Android Phone.
- Install the APK in your phone to use the app directly.
### 2. Requirements:
- The app requires an ESP32 and some sensors to track real-time data.
- Follow [Esp32 Steps](##Esp32Steps) this steps and use the Esp 32 code.
## HomePage Features:
### Location Activation
Enable location services to test the weather API. Gemini will use weather data to provide tailored plant care advice.

### Chatbot
Interact with the chatbot by entering text or uploading images for assistance and plant information.

### Plant Information
Search for details about any plant by its name.

### Add New Plant
- Scan sensors via Bluetooth to connect them to the internet and Firebase.
- Enter new plant details using Gemini.
- Track plant information on the dashboard and receive risk notifications.

### Environment Check
- Add sensors to monitor the environment.
- Enter the plant name and let Gemini predict its thriving potential. (If you don’t have sensors, you can use the weather API as an alternative.)

### Reminder Page
- View the next plant watering schedule and upcoming events.
- Click on events to view details and join if interested.

### Profile Page
- **View Information**: Check your score, plants, and any added sensors.
- **Settings**: Toggle between dark and light mode and edit your profile.

### Plant Management
- Edit, delete, or view plant details.
- Download plant barcodes.

### Scanning Page
- **QR Scanning**: Scan QR codes for real-time plant info on the dashboard.
- **Image Scanning**: Scan plant images to get names and additional information (via Gemini).
- **Disease Scanning**: Use Gemini to identify plant diseases.

### Wallet Page
- **Score Management**: View your score and its conversion.
- **Coupons**: Obtain and use coupons with your score.

##Esp32Steps
### Required Equipement:
- **DHT Sensor**: To track humidity and temperature.
- **Light Sensor**: To track light intensity.
- **Soil moisture**: To track the humidity of the soil.
### Circuit Diagram
- Follow This Circuit To get the code work perfectly
![Esp Ciruit](https://github.com/user-attachments/assets/8639225d-99f8-4fbc-97be-d60a4c573ff0)
### Run Code
1. Download this code
2. install all the required library on your arduino ide
3. Select Esp32 Dev Module and Run

