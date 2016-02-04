#line 1 "C:/Users/Ronilo/Downloads/Desktop/ECE Thesis/GSM Controller Lights/DazoGSM/DazoGSM.c"
void initPorts();
void sendSMS(char*);
void sendATCommand(char*);
void detectBO();
void readSMS();

const unsigned char *recepientNumber = "09258741785";

const unsigned char *smart = "09999521775";
const unsigned char *sun = "09258741785";
const unsigned char *globe = "09151618571";

const unsigned int SIZE = 255;
unsigned int BOSMSSent = 0;

void main() {
 initPorts();
 Delay_ms(500);
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
 char inStr[25];
 unsigned int i=0;

 if(UART1_Data_Ready()){
 while(UART1_Data_Ready()){
 inStr[i] = UART1_Read();
 i++;
 Delay_ms(1);
 }
 Delay_ms(200);
 if(strstr(inStr, "IN")){
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

 if(strstr(inStr, "OU")){
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
 }
 Delay_ms(100);

}

void initPorts(){
 ADCON1 = 0x08;
 TRISB = 0xF0;
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
 while(PORTB.F4 == 0);
 if(PORTB.F4 == 1)sendSMS("The power is back");
 }
 if(PORTB.F4 == 1) BOSMSSent = 0;
}
