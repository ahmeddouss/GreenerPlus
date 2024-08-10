#include <Firebase_ESP_Client.h>
#include <addons/TokenHelper.h>
#include <ArduinoJson.h>
#include <DHT.h>
#include <Adafruit_Sensor.h>
#include <WiFi.h>
#include <time.h>
#include <HTTPClient.h>
#include <NimBLEDevice.h>



#define DEVICE_NAME "ESP32_Test"
#define DEVICE_ID "123456"  // Your specified ID

NimBLEServer* pServer;
NimBLEAdvertising* pAdvertising;
NimBLEService* pService;
NimBLECharacteristic* pCharacteristic;

const char* ssid;
const char* password;
String plantRef;
String espRef;
String userRef;
bool isConnected = false;
bool ifFirebase = false;


#define PROJECT_ID "greenerai"                                                    // Taken from "project_id" key in JSON file.
#define CLIENT_EMAIL "firebase-adminsdk-o11mi@greenerai.iam.gserviceaccount.com"  // Taken from "client_email" key in JSON file.
const char PRIVATE_KEY[] PROGMEM = "-----BEGIN PRIVATE KEY-----\nMIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQCxi7fGITTKVgKo\nGRt1LvY20XaFCRy3LEmvaElfx128wKMvOeNTmLPWAkbTj0UNY3h9dGHCXhaQMHvT\nozp+FbpZBf9Wp8rPX9gLn8qWYJmYkD8JRz91m/YzIL5u9J5Cw50wk94962spHPHV\nnuipE7IgjVLGYAQP8NUqEzg/n0IuVW4MUnWAh/RiAMaVhmctfcrQn83nUTFbCZfs\nehyhFTQrU44h/gDR9UrGzmFPmQVev+y8iPsjXyRr/S1wvNAAEI/4fJ+KhbYhTyGs\nnQ5ZHO6qQbeQVq7plwduSaC575+VWGedF7CPOBmexBOyCzHkXcXI7xGYdZKQbtVP\nPJfnTlT1AgMBAAECggEAN7vxc7vm04GOkfBXw0B7wBefCgIjRokblHm7VtrB3Ufn\nsiKM7ygnhA3w5+a4uYw5PcC0E4zvrlHZ/UTnTr9JYTrVvgEsVE71BikiMnSeotrd\nPu9jx2qvLbugrDoUGEdJ5/7zLCLj3+MbM4EP7kulhjx2+JkZjVt/vxaLeMVoxBw8\n16apa3Hp8xXP+nG1DOHPVZvdAOUy407R4iFRkICoI4RolgSc3CK9INQsqwUbdVWz\nrDFoEdh72NNRBA8rOXhBx/mK1MzxRVxICKk17LPwbaNz6FLbYkdkYxxWyysSDO5S\njJeBjaI5aN43cR/TFG5q84vpq/Cnzjysj8vMdQ2C3QKBgQDqvofLBbf1d8CgZgVj\nvQa5UOz9qmIxi0dPaezkEOxJecfQLzcTvXisIM+cmvSfZDFFQ/1GpD/C5hkyFaJM\nlftlw90uwhW3EWY977hrFrIhWPbZZtQ7iJV8y9sPi/OfgenpfpYDxzq/tzzEdoro\nP3zn43Tv3mt+AWR3HjL1X3MPswKBgQDBn01+9qiOsxqeaVICGbxWre+hLgLmK/Gn\nOv/BMeXJ4Ly7EY9OIUVxJd+KnfKzBfp26uzirwXs5hOkdVHYlQgYmFp3+8UL9lgK\n3GWh1FsvDdNHb9fXcqQoQy4sV/ucoKK/1ZZEYOkXt2B7YLEAXHN4pOWkDJw+qAvD\nnNTFkst0twKBgCqcGxoHF7U+34A+BIxuK2JIBjylSN2lYnRPzeg4CivsJxDrARxc\nMCNOcWED35NvJGJmTPsdpVVDXx9wPd2Y++ElBGkQYdCxH9XuRZNqszrKY0RjHfMQ\nf9H/TuwrgzVY55SynZhh+ZADOsyOl/hATfPpnbhMr0ZYClx05tsTUFdxAoGADNY7\n9BP0Xume9Su0ZTFBnFmRzpTXWl1FezndJPji7Dx7JsfmQV7RVMwXAwCvy5C051dx\n9yF1ehxS5w9kKsDOtZq8PMIzcTSW57lu/4ittvPqswzGOaF/IrA5inUW2G6J+7/0\nY3otWgYtXmCtu4FlonUESJkRbtIDXaezL5oo5QcCgYEAlgBxi1e775LS2dWSZmKK\n+lRxR9xXXDThPP+T7PnRg8gbhTpKi1WTuoiwXv3iWZyhhz4IoMYYO0k3zrQJgoCM\nTDG1kk8gd4jWjHhZ2KRImjo5jjXRfbe5e2gEwhDmADxMW75bLrM43hK4vekG+lBo\n1s9n1MVNmjVnsi8mVf9uyx0=\n-----END PRIVATE KEY-----\n";
const char* token;  // Change token type to String
const char* serverName = "https://fcm.googleapis.com/v1/projects/greenerai/messages:send";
String PLANT_PATH = "plants/SnweuvW7UwxUfgbFH22H";
String ESP_PATH = "/espCard/Mj736GYbZhfJxPREO0Pk";
String WATER_PATH = PLANT_PATH + "/water_routine/";

char nextWatering[25];

// Sensor configuration
#define DHTPIN 13             // Pin where the DHT11 is connected
#define DHTTYPE DHT11         // DHT 11
#define LIGHT_SENSOR_PIN 33   // Analog pin for light sensor
#define SOIL_MOISTURE_PIN 32  // Analog pin for soil moisture sensor
DHT dht(DHTPIN, DHTTYPE);

//timer schduling(make them initiate after delay if esp work all time(momory managemnt))
unsigned long previousMillis = 0;      // Stores the last time the function was called
const unsigned long interval = 30000;  // 1 hour in milliseconds
const char* plantName;
String deviceToken = "fSo_G-ZhQtO01eXSqgNWrc:APA91bGuEBbbW7Z1mYSdbVDX0Pmszr1jOeP0TYqowpeh_iYmP-qkHtOCA9ZDF5bGL8y2C3pR_h-0DqUsiVmjIK_uLhHkjALyJ-4E6QUXfSFy7deKPF6W7O1A6mHaERBR3dVHDlEV6Ru8";

// Sensor values structure
struct SensorValues {
  int lightValue;
  int soilMoistureValue;
  int humidity;
  int temperature;
};
//check values structure
struct VarainceResult {
  bool lightCheck = false;
  bool humidityCheck = false;
  bool temperatureCheck = false;
  bool watering = false;
};

struct WateringRoutine {
  bool status;
  int interval;
  int score;
};

// Firebase configuration
#define API_KEY "AIzaSyD2VtF7LknNiN0nZrDhWFOkcczxEjGZLGw"
#define FIREBASE_PROJECT_ID "greenerai"
#define USER_EMAIL "Esp@sensor.com"
#define USER_PASSWORD "EspSensor"

// NTP configuration
const char* ntpServer = "pool.ntp.org";
const long gmtOffset_sec = 0;
const int daylightOffset_sec = 0;
// Set current time
struct tm timeinfo;
// Define Firebase Data object
FirebaseData fbdo;
FirebaseAuth auth;
FirebaseConfig config;
String path = "fill";
FirebaseJson content;
char iso8601[25];

// Setup function
void setup() {
  Serial.begin(115200);


  // Initialize sensors
  dht.begin();
  pinMode(LIGHT_SENSOR_PIN, INPUT);
  pinMode(SOIL_MOISTURE_PIN, INPUT);
  connectBluetooth();
}

// Main loop
void loop() {
  if (ifFirebase) {
    connectFirebase();
    // Set the timezone and NTP server
    configTime(gmtOffset_sec, daylightOffset_sec, ntpServer);

    // Attempt to obtain local time
    if (!getLocalTime(&timeinfo)) {
      Serial.println("Failed to obtain time");
    }
    ifFirebase = false;
  }

  if (isConnected) {
    if (Firebase.ready()) {
      token = Firebase.getToken();
      Serial.println("token");
    }
    SensorValues sensorValues = getSensorCurrentValues();
    if (plantRef == "null") {
      checkPlace(sensorValues);
    } else {
      dailySensorData(sensorValues);
      VarainceResult checkValues=checkVariance(sensorValues);
      creatingNotifications(checkValues);

      if (sensorValues.soilMoistureValue < 2000) {
        setWateringStatus(plantRef);
      }
    }
  }
  delay(4000);
}


String extractTextInsideParentheses(String input) {
  int startIndex = input.indexOf('(') + 1;  // Find the index of '(' and move one position ahead
  int endIndex = input.indexOf(')');        // Find the index of ')'

  if (startIndex != -1 && endIndex != -1 && startIndex < endIndex) {
    return input.substring(startIndex, endIndex);  // Extract text between '(' and ')'
  }

  return "";  // Return an empty string if parentheses are not found or are invalid
}

class MyServerCallbacks : public NimBLEServerCallbacks {
  void onConnect(NimBLEServer* pServer) {
    Serial.println("Client Connected");
  }

  void onDisconnect(NimBLEServer* pServer) {
    Serial.println("Client Disconnected");
    // Restart advertising after disconnection
    NimBLEDevice::getAdvertising()->start();
    Serial.println("Advertising restarted");
  }
};

class MyCharacteristicCallbacks : public NimBLECharacteristicCallbacks {
  void onWrite(NimBLECharacteristic* pCharacteristic) {
    std::string value = pCharacteristic->getValue();
    Serial.print("Received Value: ");
    Serial.println(value.c_str());

    // Parse JSON
    StaticJsonDocument<200> doc;
    DeserializationError error = deserializeJson(doc, value);
    if (error) {
      Serial.print("deserializeJson() failed: ");
      Serial.println(error.c_str());
      return;
    }

    ssid = doc["ssid"];
    password = doc["password"];
    plantRef = String(doc["plant_path"]);
    espRef = String(doc["esp_path"]);
    userRef = String(doc["user_path"]);


    connectWifi(ssid, password);


    Serial.print("SSID: ");
    Serial.println(ssid);
    Serial.print("Password: ");
    Serial.println(password);
    Serial.print("plantRef: ");
    Serial.println(plantRef);
    Serial.print("espRef: ");
    Serial.println(espRef);
  }
};

void connectBluetooth() {

  // Initialize serial communication for debugging

  Serial.println("Starting BLE work!");
  // Initialize NimBLE
  NimBLEDevice::init(DEVICE_NAME);
  // Create BLE server
  pServer = NimBLEDevice::createServer();
  pServer->setCallbacks(new MyServerCallbacks());
  // Set the advertising power to a specific RSSI value (e.g., -70 dBm)
  NimBLEDevice::setPower(ESP_PWR_LVL_N14);  // Possible values: ESP_PWR_LVL_N12, ESP_PWR_LVL_N10, ESP_PWR_LVL_N8, ESP_PWR_LVL_N6, ESP_PWR_LVL_N4, ESP_PWR_LVL_N2, ESP_PWR_LVL_N0, ESP_PWR_LVL_P3, ESP_PWR_LVL_P6, ESP_PWR_LVL_P9
  // Create BLE service
  pService = pServer->createService("4fafc201-1fb5-459e-8fcc-c5c9c331914b");  // Example service UUID

  // Create a writable characteristic
  pCharacteristic = pService->createCharacteristic(
    "beb5483e-36e1-4688-b7f5-ea07361b26a8",  // Example characteristic UUID
    NIMBLE_PROPERTY::WRITE);
  pCharacteristic->setCallbacks(new MyCharacteristicCallbacks());
  // Start the service
  pService->start();
  // Create advertising object
  pAdvertising = NimBLEDevice::getAdvertising();
  // Create an advertisement data object
  NimBLEAdvertisementData advData;
  // Add a custom service UUID (e.g., for identifying your device)
  advData.setName(DEVICE_NAME);
  advData.setManufacturerData(DEVICE_ID);
  // Set the advertisement data
  pAdvertising->setAdvertisementData(advData);
  // Start advertising
  pAdvertising->start();
  Serial.println("Advertising started!");
}


// Connect to Firebase
void connectFirebase() {
  config.api_key = API_KEY;
  auth.user.email = USER_EMAIL;
  auth.user.password = USER_PASSWORD;
  config.service_account.data.client_email = CLIENT_EMAIL;
  config.service_account.data.project_id = PROJECT_ID;
  config.service_account.data.private_key = PRIVATE_KEY;
  /* Expired period in seconds (optional). Default is 3600 sec. */
  config.signer.expiredSeconds = 3600;
  /* Seconds to refresh the token before expired (optional). Default is 60 sec. */
  config.signer.preRefreshSeconds = 60;
  config.token_status_callback = tokenStatusCallback;
  config.signer.tokens.scope = "https://www.googleapis.com/auth/userinfo.email,https://www.googleapis.com/auth/firebase.database,https://www.googleapis.com/auth/firebase.messaging";


  Firebase.begin(&config, &auth);
  Firebase.reconnectWiFi(true);
}

// Connect to Wi-Fi
bool connectWifi(const char* ssid, const char* password) {
  WiFi.begin(ssid, password);
  Serial.print("Connecting to Wi-Fi");

  unsigned long startAttemptTime = millis();
  const unsigned long connectionTimeout = 10000;  // 10 seconds

  while (WiFi.status() != WL_CONNECTED && millis() - startAttemptTime < connectionTimeout) {
    Serial.print(".");
    delay(300);
  }

  Serial.println();

  if (WiFi.status() == WL_CONNECTED) {
    Serial.print("Connected with IP: ");
    Serial.println(WiFi.localIP());
    isConnected = true;
    ifFirebase = true;



    return true;
  } else {
    Serial.println("Failed to connect to Wi-Fi.");
    return false;
  }
}



// Create a new Firestore document
void createDocument() {
  // Get the current time
  configTime(gmtOffset_sec, daylightOffset_sec, ntpServer);
  struct tm timeinfo;
  if (!getLocalTime(&timeinfo)) {
    Serial.println("Failed to obtain time");
    return;
  }

  char iso8601[25];  // Buffer to store the timestamp in ISO 8601 format
  strftime(iso8601, sizeof(iso8601), "%Y-%m-%dT%H:%M:%SZ", &timeinfo);

  Serial.println("Creating New Value");
  content.set("fields/time/timestampValue", String(iso8601).c_str());
  content.set("fields/uid/stringValue", "FvnfmrGS67OaY16V2jYaIWlpwYN2");

  if (Firebase.Firestore.createDocument(&fbdo, FIREBASE_PROJECT_ID, "", path.c_str(), content.raw())) {
    // Serial.printf("Document created successfully\n%s\n\n", fbdo.payload().c_str());
  } else {
    Serial.printf("Failed to create document: %s\n", fbdo.errorReason().c_str());
  }
}

// Update an existing Firestore document
void updateDocument(String documentIdPath) {
  content.clear();
  content.set("fields/status/booleanValue", "true");
  Serial.print("Editing existing value ");
  if (Firebase.Firestore.patchDocument(&fbdo, FIREBASE_PROJECT_ID, "", documentIdPath.c_str(), content.raw(), "status")) {
    Serial.println(fbdo.payload().c_str());
    Serial.println("---------------------");
  } else {
    Serial.printf("Failed to update document: %s\n", fbdo.errorReason().c_str());
  }
}

// Read a Firestore document
FirebaseData* readDocument(String documentIdPath, String mask) {
  if (Firebase.Firestore.getDocument(&fbdo, FIREBASE_PROJECT_ID, "", documentIdPath.c_str(), mask.c_str())) {
    //Serial.printf("Document data:\n%s\n\n", fbdo.payload().c_str());
    return &fbdo;
  } else {
    Serial.printf("Failed to read document: %s\n", fbdo.errorReason().c_str());
    return nullptr;
  }
}

// Query a Firestore document
FirebaseData* queryDocument(String documentIdPath, String collectionId, String field) {
  FirebaseJson structuredQuery;
  FirebaseJson orderByClause;
  FirebaseJson fieldReference;
  FirebaseJson fromClause;

  // Setting up the orderBy field
  fieldReference.set("fieldPath", field);
  orderByClause.set("field", fieldReference);
  orderByClause.set("direction", "DESCENDING");

  // Setting up the from collection
  fromClause.set("collectionId", collectionId);

  // Build the structured query
  FirebaseJsonArray orderByArray;
  orderByArray.add(orderByClause);
  structuredQuery.set("orderBy", orderByArray);

  FirebaseJsonArray fromArray;
  fromArray.add(fromClause);
  structuredQuery.set("from", fromArray);

  structuredQuery.set("limit", 1);

  if (Firebase.Firestore.runQuery(&fbdo, FIREBASE_PROJECT_ID, "", documentIdPath.c_str(), &structuredQuery)) {
    //Serial.println("Query succeeded:");
    //Serial.println(fbdo.payload());  // Print the returned JSON data
    return &fbdo;
  } else {
    Serial.println("Query failed:");
    Serial.println(fbdo.errorReason());
    return nullptr;
  }
}

// Get current sensor values
SensorValues getSensorCurrentValues() {
  SensorValues sensorValues;

  // Read light sensor value
  sensorValues.lightValue = 4080-analogRead(LIGHT_SENSOR_PIN);

  // Read soil moisture sensor value
  sensorValues.soilMoistureValue = analogRead(SOIL_MOISTURE_PIN);

  // Read DHT11 sensor values
  float rawHumidity = dht.readHumidity();
  float rawTemperature = dht.readTemperature();

  // Check if any reads failed
  if (isnan(rawHumidity) || isnan(rawTemperature)) {
    Serial.println("Failed to read from DHT sensor!");
    sensorValues.humidity = -1;     // Indicate failure
    sensorValues.temperature = -1;  // Indicate failure
  } else {
    sensorValues.humidity = round(rawHumidity);
    sensorValues.temperature = round(rawTemperature);
  }

  //Serial.print("Receiving Sensors Data!");
  // Uncomment to print sensor values
  //Serial.print("Light: ");
  //Serial.println(sensorValues.lightValue);
  Serial.print("Soil Moisture: ");
  Serial.println(sensorValues.soilMoistureValue);
  //Serial.print("Humidity: ");
  //Serial.println(sensorValues.humidity);
  // Serial.println(" %");
  // Serial.print("Temperature: ");
  //Serial.print(sensorValues.temperature);
  //Serial.println(" *C");

  return sensorValues;
}

// Handle daily sensor data updates
void dailySensorData(SensorValues sensorValues) {
  struct tm timeinfo;

  // Set the timezone and NTP server
  configTime(gmtOffset_sec, daylightOffset_sec, ntpServer);

  // Attempt to obtain local time
  if (!getLocalTime(&timeinfo)) {
    Serial.println("Failed to obtain time");
    return;
  }

  // Buffer to store the date in "YYYY-MM-DD" format
  char todayDate[11];
  strftime(todayDate, sizeof(todayDate), "%Y-%m-%d", &timeinfo);

  // Buffer to store the timestamp in ISO 8601 format
  char iso8601[25];
  strftime(iso8601, sizeof(iso8601), "%Y-%m-%dT%H:%M:%SZ", &timeinfo);

  FirebaseData* data = queryDocument(espRef, "dataSensors", "time");

  //Serial.printf("Document updated successfully\n%s\n\n", data->payload().c_str());
  if (data != nullptr) {

    DynamicJsonDocument doc(1024);

    // Parse the JSON data
    DeserializationError error = deserializeJson(doc, data->payload().c_str());
    if (error) {
      //Serial.print(F("deserializeJson() failed: "));
      Serial.println(error.f_str());
      return;
    }
    JsonObject obj = doc[0];
    // Extract the timestampValue
    const char* timestampValue = obj["document"]["fields"]["time"]["timestampValue"];
    const char* document_name = obj["document"]["name"];
    int startIndex = String(document_name).indexOf("dataSensors/") + strlen("dataSensors/");
    String documentId = String(espRef) + "/dataSensors/" + String(document_name).substring(startIndex);
    String createTimeDate = String(timestampValue).substring(0, 10);
    content.clear();
    //content.set("fields/time/timestampValue", String(iso8601).c_str());
    content.set("fields/humidity/integerValue", sensorValues.humidity);
    content.set("fields/light/integerValue", sensorValues.lightValue);
    content.set("fields/temperature/integerValue", sensorValues.temperature);

    //   Serial.println("khra:",sensorValues.lightValue.c_str());
    if (createTimeDate.equals(todayDate)) {

      Serial.print("Editing existing value ");


      if (Firebase.Firestore.patchDocument(&fbdo, FIREBASE_PROJECT_ID, "", documentId.c_str(), content.raw(), "humidity,light,temperature")) {
        // Serial.println(fbdo.payload().c_str());
        Serial.println("---------------------");

      } else {
        Serial.printf("Get document failed: %s\n", fbdo.errorReason().c_str());
      }
      return;
    }
  }




  content.set("fields/time/timestampValue", String(iso8601).c_str());
  Serial.println("Creating New Value");
  if (Firebase.Firestore.createDocument(&fbdo, FIREBASE_PROJECT_ID, "", String(espRef) + "/dataSensors", content.raw())) {
    // Serial.printf("ok\n%s\n\n", fbdo.payload().c_str());
  } else {
    Serial.printf("failed: %s\n", fbdo.errorReason().c_str());
  }
}

void checkPlace(SensorValues sensorValues) {
  //infinity loop

  if (readDocument(espRef, "") != nullptr) {
    Serial.println("Sending Sensor check place");
    dailySensorData(sensorValues);
  } else {
    Serial.println("Done!");
    ESP.restart();
  }
}

VarainceResult checkVariance(SensorValues sensorCurrentVariable) {
  SensorValues sensorConst;
  VarainceResult varianceCheckResult;
  //watering check
  varianceCheckResult.watering = (sensorCurrentVariable.soilMoistureValue < 2000);
  FirebaseData* data = readDocument(plantRef, "humidity,light,temperature,interval,name");

  //avoid case of check place add null pointer for not having plant
  if (data != nullptr) {
    DynamicJsonDocument doc(1024);
    // Parse the JSON data
    DeserializationError error = deserializeJson(doc, data->payload().c_str());
    if (error) {
      Serial.println(error.f_str());
      return varianceCheckResult;
    }

    // Extract the values from the JSON document
    int interval = doc["fields"]["interval"]["integerValue"].as<int>();
    sensorConst.lightValue = doc["fields"]["light"]["integerValue"].as<int>();
    sensorConst.humidity = doc["fields"]["humidity"]["integerValue"].as<int>();
    sensorConst.temperature = doc["fields"]["temperature"]["integerValue"].as<int>();
    plantName = doc["fields"]["name"]["stringValue"];

    varianceCheckResult = risqueVariance(sensorCurrentVariable, sensorConst);
    //varianceCheckResult.watering = wateringVariance();
  }


  return varianceCheckResult;
}

VarainceResult risqueVariance(SensorValues currentValueSensor, SensorValues constantValueSensor) {
  VarainceResult results;
  //Serial.println("--------------------------");
  //Serial.println(constantValueSensor.humidity);
  //Serial.println(currentValueSensor.humidity);
  //Serial.println("--------------------------");
  results.lightCheck = (currentValueSensor.lightValue > 1100) && (currentValueSensor.lightValue < 200);
  //results.soilMoistureValueGreater = (currentValueSensor.soilMoistureValue > constantValueSensor.soilMoistureValue)&&(currentValueSensor.soilMoistureValue < constantValueSensor.soilMoistureValue-20);
  results.humidityCheck = ((currentValueSensor.humidity < constantValueSensor.humidity - 30) || (currentValueSensor.humidity > constantValueSensor.humidity + 30));
  results.temperatureCheck = ((currentValueSensor.temperature < constantValueSensor.temperature - 20) || (currentValueSensor.temperature > constantValueSensor.temperature + 20));

  return results;
}

bool checkTimer() {
  // Get the current time in milliseconds
  unsigned long currentMillis = millis();

  // Check if the interval has passed
  if (currentMillis - previousMillis >= interval) {
    // Save the last time the function was called
    //previousMillis = currentMillis;
    return true;
  } else if (previousMillis == 0) {
    return true;
  }
  return false;
}

void restartTimer() {
  // Restart the timer
  previousMillis = millis();
  Serial.println("Timer restarted!");
  //add condition watering bool var if it's new date set it true
}

//make commun notif style
void sendNotification(String title,String message, const char* bearerToken,String phoneToken) {  // Change bearerToken type to String
  if (WiFi.status() == WL_CONNECTED) {
    HTTPClient http;

    // Specify request destination
    http.begin(serverName);

    // Specify content-type header
    http.addHeader("Content-Type", "application/json");
    http.addHeader("Authorization", "Bearer " + String(bearerToken));

    // Prepare JSON payload
    String httpRequestData = "{\"message\":{\"token\":\""+ phoneToken +"\",\"notification\":{\"title\":\""+ title +"\",\"body\":\"" + message + "\"}}}";

    // Send HTTP POST request
    int httpResponseCode = http.POST(httpRequestData);

    // Check response
    if (httpResponseCode > 0) {
      String response = http.getString();
      Serial.println(httpResponseCode);
      Serial.println(response);
    } else {
      Serial.print("Error on sending POST: ");
      Serial.println(httpResponseCode);
    }

    // Free resources
    http.end();
  } else {
    Serial.println("WiFi Disconnected");
  }
}
void creatingNotifications(VarainceResult checkValues) {
  bool risque = false;
  String message = "Please check ";
  if (checkTimer()) {

    if (checkValues.humidityCheck) {
      message += "humidity, ";
      risque = true;
    }
    if (checkValues.lightCheck) {
      message += "light, ";
      risque = true;
    }
    if (checkValues.temperatureCheck) {
      message += "temperature, ";
      risque = true;
    }
    message += "for your ";
    message += plantName;
    message += " plant.";

    if (risque) {
      Serial.println("message");
      sendNotification("Alert!",message, token,deviceToken);
      restartTimer();
    }
  }

  //daily check if is time for reminder to send watering notification
  char todayDate[11];
  strftime(todayDate, sizeof(todayDate), "%Y-%m-%dT%H:%M:%SZ", &timeinfo);
  if (nextWatering == todayDate) {
    message = "Don't forget to water your ";
    message += plantName;
    message += " plant.";
    sendNotification("Reminder!",message, token,deviceToken);
  }
}

bool schedulingWaterNotif() {
  //send notif //Add condition in the flutter if watering or risuqe condition on the title
 // sendNotification("reminder of the plant.. use plantName(make it outside the check)", token);
  return false;
}

void setWateringStatus(String documentIdPath) {
  FirebaseData* data = queryDocument(plantRef, "water_routine", "date");

  //Serial.printf("Document updated successfully\n%s\n\n", data->payload().c_str());
  if (data != nullptr) {

    DynamicJsonDocument doc(1024);

    // Parse the JSON data
    DeserializationError error = deserializeJson(doc, data->payload().c_str());
    if (error) {
      //Serial.print(F("deserializeJson() failed: "));
      Serial.println(error.f_str());
      return;
    }


    //updating status

    Serial.println("-----------Checked----------");
    JsonObject obj = doc[0];
    // Extract the timestampValue
    const char* timestampValue = obj["document"]["fields"]["date"]["timestampValue"];
    int score = obj["document"]["fields"]["score"]["integerValue"].as<int>();
    const char* document_name = obj["document"]["name"];
    int startIndex = String(document_name).indexOf("water_routine/") + strlen("water_routine/");
    String documentId = String(plantRef) + "/water_routine/"+String(document_name).substring(startIndex);
    String createTimeDate = String(timestampValue).substring(0, 10);


    // Buffer to store the date in "YYYY-MM-DD" format
    char todayDate[11];


    strftime(todayDate, sizeof(todayDate), "%Y-%m-%d", &timeinfo);

    // add condition if scheduling bool true (for a new date (make the check on time a day the bool schedul outside the check(query)))
    if (createTimeDate.equals(todayDate)) {
      bool status = obj["document"]["fields"]["status"]["booleanValue"].as<bool>();
      if (!status) {
        Serial.println("-----------Setting Status----------");
        //setting status
        updateDocument(documentId);
        setNextFill(todayDate, String(plantRef) + "/water_routine/", score);
        //add score
      } else {
        Serial.println("-----------Already Set----------");
      }
    }
  }
}

void setNextFill(char* today, String documentIdPath, int oldScore) {


  struct tm futureTime = timeinfo;
  futureTime.tm_mday += 33;  // Add the interval to the current day
  mktime(&futureTime);       // Normalize the time structure


  strftime(iso8601, sizeof(nextWatering), "%Y-%m-%dT00:00:41.363421Z", &futureTime);

  oldScore = +1;

  content.clear();
  //content.set("fields/time/timestampValue", String(iso8601).c_str());
  content.set("fields/score/integerValue", String(oldScore).c_str());
  content.set("fields/date/timestampValue", String(nextWatering).c_str());
  content.set("fields/status/booleanValue", "false");

  if (Firebase.Firestore.createDocument(&fbdo, FIREBASE_PROJECT_ID, "", documentIdPath.c_str(), content.raw())) {
    Serial.println("-----------Setting Next Fill----------");
    //Serial.println(fbdo.payload().c_str());

  } else {
    Serial.printf("Failed to update document: %s\n", fbdo.errorReason().c_str());
  }
}