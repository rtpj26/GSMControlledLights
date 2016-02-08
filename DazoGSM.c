void initPorts();
void sendSMS(char*);
void sendATCommand(char*);
void detectBO();
void readSMS();

const unsigned char *recepientNumber = "09258741785";

const unsigned int SIZE = 255;
unsigned int BOSMSSent = 0;

void main() {
     initPorts();

     while(1){
         detectBO();
         readSMS();
     }
}

void readSMS(){
      char *indoorError = "There might be a problem with your INDOOR Lights. please check";
      char *indoorOn = "INDOOR Lights On";
      char *indoorOff = "INDOOR Lights Off";
      char *outdoorError = "There might be a problem with your OUTDOOR Lights. please check";
      char *outdoorOn = "OUTDOOR Lights On";
      char *outdoorOff = "OUTDOOR Lights Off";

      char *smart = "+639999521775";
      char *sun = "+639258741785";
      char *globe = "+639151618571";

      char inStr[100];
      unsigned int i=0;
      
      if(UART1_Data_Ready()){
        UART_Read_Text(inStr, "--", 100);
        Delay_ms(200);
        if(strstr(inStr, "INDOOR") && ((strstr(inStr, smart) || strstr(inStr, globe) || strstr(inStr, sun)))){
             PORTB.F0 = ~PORTB.F0;
             if(PORTB.RB5 == 0 && PORTB.RB0 == 1){
                  sendSMS(indoorError);
             }else{
                   if(PORTB.RB5 == 1){
                                sendSMS(indoorOn);
                   }else{
                                sendSMS(indoorOff);
                   }
             }
        }
        
        else if(strstr(inStr, "OUTDOOR") && ((strstr(inStr, smart) || strstr(inStr, globe) || strstr(inStr, sun)))){
              PORTB.F1 = ~PORTB.F1;
              if(PORTB.RB6 == 0 && PORTB.RB1 == 1){
                   sendSMS(outdoorError);
             }else{
                   if(PORTB.RB6 == 1){
                                sendSMS(outdoorOn);
                   }else{
                                sendSMS(outdoorOff);
                   }
             }
        }
        else{
        }
        EEPROM_Write(0x38, PORTB); //Kwa on ang previous status sng PIC
        sendATCommand("AT+CMGD=1,4\r\n");
      }
      Delay_ms(100);

}

void initPorts(){
     ADCON1 = 0x07;
     TRISB = 0xF0;
     TRISA= 0xFF;
     PORTB = 0x00;
     UART1_Init(9600);
     sendATCommand("AT+CNMI=1,0,2,0,1\r\n");
     sendATCommand("AT+CMGF=1\r\n");
     sendSMS("Device On");
}

void sendATCommand(char *cmd){
      char in;
      int i;
      UART1_Write_Text(cmd);
      Delay_ms(500);
     }


void sendSMS(char *msg){
      char in;
     int i;
     Delay_ms(2000);
     UART1_Write_Text("AT+CMGS=\"");
     for(i=0; i < 11; i++)
              UART1_Write(*(recepientNumber+i));
     UART1_Write_Text("\"\r\n");
     Delay_ms(1000);
     if(UART1_Data_Ready()){
            for(i=0; UART1_Data_Ready(); i++){
                 in = UART1_Read();
            }
      }
      UART1_Write_Text(msg);
      Delay_ms(1000);
      UART1_Write(26);
      Delay_ms(500);
}

void detectBO(){
      if(PORTB.F4 == 0 && BOSMSSent == 0){
              sendSMS("The power is off");
              BOSMSSent = 1;
              while(BOSMSSent == 1){
                  if(PORTB.F4 == 1) BOSMSSent = 0;
              }
              sendSMS("The power is back");
              PORTB = EEPROM_Read(0x38); //if magbalik ang suga, kwaun ang status kag ebalik sa portB
      }
      BOSMSSent = 0;
}