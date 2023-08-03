#include <SPI.h>
#include <MFRC522.h>

#define SS_PIN 10
#define RST_PIN 9
#define LED_G 6
#define LED_R 7 
#define BUZZER 8 
MFRC522 mfrc522(SS_PIN, RST_PIN);  // Create MFRC522 instance.

int readsuccess;
byte readcard[4];
char str[32] = "";
String StrUID;

void setup() {
  Serial.begin(9600); // Initialize serial communications with the PC
  SPI.begin();      // Init SPI bus
  mfrc522.PCD_Init(); // Init MFRC522 card

  Serial.println("CLEARDATA");
  Serial.println("LABEL,Date,Time,RFID UID");
  delay(1000);
  pinMode(LED_G, OUTPUT);
  pinMode(LED_R, OUTPUT);
  pinMode(BUZZER, OUTPUT);
  noTone(BUZZER);
  Serial.println("Scan Card");
  Serial.println("");
}
// --------------------------------------------------------------------
void loop() {
  readsuccess = getid();
  if(readsuccess){
    if(StrUID == "50FE6056"){
    Serial.println ("Access Granted" );
    delay(100);
    digitalWrite(LED_G, HIGH);
    tone(BUZZER, 1200);
    
    delay(500);
    noTone(BUZZER);
    digitalWrite(LED_G, LOW);
    delay(500);
    Serial.println( (String) "DATA,DATE,TIME,SAGAR,GRANTED," + StrUID );
    Serial.println("");
  }
  else if(StrUID == "3BDBE4A9"){
    Serial.println ("Access Granted" );
    delay(100);
    digitalWrite(LED_G, HIGH);
    tone(BUZZER, 1200);
    
    delay(500);
    noTone(BUZZER);
    digitalWrite(LED_G, LOW);
    delay(500);
    Serial.println( (String) "DATA,DATE,TIME,SOWMYA,GRANTED," + StrUID );
    Serial.println("");
  }
  else if(StrUID == "66C0E4FA"){
    Serial.println ("Access Granted" );
    delay(100);
    digitalWrite(LED_G, HIGH);
    tone(BUZZER, 1200);
    
    delay(500);
    noTone(BUZZER);
    digitalWrite(LED_G, LOW);
    delay(500);
    Serial.println( (String) "DATA,DATE,TIME,KEERTHIKA,GRANTED," + StrUID );
    Serial.println("");
  }
  else
  {
    Serial.println("Access denied");
    delay(100);
    int n=0;
    while(n<=2){
    digitalWrite(LED_R, HIGH);
    tone(BUZZER, 100);
    delay(200);
    digitalWrite(LED_R, LOW);
    noTone(BUZZER);
    delay(200);
    n++;
    }
    Serial.println( (String) "DATA,DATE,TIME,DENIED," + StrUID );
    Serial.println("");
  }
  }
}
// --------------------------------------------------------------------
int getid(){  
  if(!mfrc522.PICC_IsNewCardPresent()){
    return 0;
  }
  if(!mfrc522.PICC_ReadCardSerial()){
    return 0;
  }
 
  
  Serial.println("Scanned Card");
  
  for(int i=0;i<4;i++){
    readcard[i]=mfrc522.uid.uidByte[i]; //storing the UID of the tag in readcard
    array_to_string(readcard, 4, str);
    StrUID = str;
  }
  mfrc522.PICC_HaltA();
  Serial.println( (String) "" + StrUID);
  return readcard;
}
// --------------------------------------------------------------------
void array_to_string(byte array[], unsigned int len, char buffer[])
{
    for (unsigned int i = 0; i < len; i++)
    {
        byte nib1 = (array[i] >> 4) & 0x0F;
        byte nib2 = (array[i] >> 0) & 0x0F;
        buffer[i*2+0] = nib1  < 0xA ? '0' + nib1  : 'A' + nib1  - 0xA;
        buffer[i*2+1] = nib2  < 0xA ? '0' + nib2  : 'A' + nib2  - 0xA;
    }
    buffer[len*2] = '\0';
}
