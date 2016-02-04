
_main:

;DazoGSM.c,16 :: 		void main() {
;DazoGSM.c,17 :: 		initPorts();
	CALL       _initPorts+0
;DazoGSM.c,18 :: 		Delay_ms(500);
	MOVLW      3
	MOVWF      R11+0
	MOVLW      138
	MOVWF      R12+0
	MOVLW      85
	MOVWF      R13+0
L_main0:
	DECFSZ     R13+0, 1
	GOTO       L_main0
	DECFSZ     R12+0, 1
	GOTO       L_main0
	DECFSZ     R11+0, 1
	GOTO       L_main0
	NOP
	NOP
;DazoGSM.c,19 :: 		while(1){
L_main1:
;DazoGSM.c,20 :: 		detectBO();
	CALL       _detectBO+0
;DazoGSM.c,21 :: 		readSMS();
	CALL       _readSMS+0
;DazoGSM.c,22 :: 		}
	GOTO       L_main1
;DazoGSM.c,23 :: 		}
L_end_main:
	GOTO       $+0
; end of _main

_readSMS:

;DazoGSM.c,25 :: 		void readSMS(){
;DazoGSM.c,26 :: 		char *indoorError = "There might be a problem with your INDOOR Lights. please check";
	MOVLW      ?lstr5_DazoGSM+0
	MOVWF      readSMS_indoorError_L0+0
	MOVLW      ?lstr6_DazoGSM+0
	MOVWF      readSMS_indoorOn_L0+0
	MOVLW      ?lstr7_DazoGSM+0
	MOVWF      readSMS_indoorOff_L0+0
	MOVLW      ?lstr8_DazoGSM+0
	MOVWF      readSMS_outdoorError_L0+0
	MOVLW      ?lstr9_DazoGSM+0
	MOVWF      readSMS_outdoorOn_L0+0
	MOVLW      ?lstr10_DazoGSM+0
	MOVWF      readSMS_outdoorOff_L0+0
;DazoGSM.c,33 :: 		unsigned int i=0;
	CLRF       readSMS_i_L0+0
	CLRF       readSMS_i_L0+1
;DazoGSM.c,35 :: 		if(UART1_Data_Ready()){
	CALL       _UART1_Data_Ready+0
	MOVF       R0+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_readSMS3
;DazoGSM.c,36 :: 		while(UART1_Data_Ready()){
L_readSMS4:
	CALL       _UART1_Data_Ready+0
	MOVF       R0+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_readSMS5
;DazoGSM.c,37 :: 		inStr[i] = UART1_Read();
	MOVF       readSMS_i_L0+0, 0
	ADDLW      readSMS_inStr_L0+0
	MOVWF      FLOC__readSMS+0
	CALL       _UART1_Read+0
	MOVF       FLOC__readSMS+0, 0
	MOVWF      FSR
	MOVF       R0+0, 0
	MOVWF      INDF+0
;DazoGSM.c,38 :: 		i++;
	INCF       readSMS_i_L0+0, 1
	BTFSC      STATUS+0, 2
	INCF       readSMS_i_L0+1, 1
;DazoGSM.c,39 :: 		Delay_ms(1);
	MOVLW      2
	MOVWF      R12+0
	MOVLW      75
	MOVWF      R13+0
L_readSMS6:
	DECFSZ     R13+0, 1
	GOTO       L_readSMS6
	DECFSZ     R12+0, 1
	GOTO       L_readSMS6
;DazoGSM.c,40 :: 		}
	GOTO       L_readSMS4
L_readSMS5:
;DazoGSM.c,41 :: 		Delay_ms(200);
	MOVLW      2
	MOVWF      R11+0
	MOVLW      4
	MOVWF      R12+0
	MOVLW      186
	MOVWF      R13+0
L_readSMS7:
	DECFSZ     R13+0, 1
	GOTO       L_readSMS7
	DECFSZ     R12+0, 1
	GOTO       L_readSMS7
	DECFSZ     R11+0, 1
	GOTO       L_readSMS7
	NOP
;DazoGSM.c,42 :: 		if(strstr(inStr, "IN")){
	MOVLW      readSMS_inStr_L0+0
	MOVWF      FARG_strstr_s1+0
	MOVLW      ?lstr11_DazoGSM+0
	MOVWF      FARG_strstr_s2+0
	CALL       _strstr+0
	MOVF       R0+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_readSMS8
;DazoGSM.c,43 :: 		PORTB.F0 = ~PORTB.F0;
	MOVLW      1
	XORWF      PORTB+0, 1
;DazoGSM.c,44 :: 		if(PORTB.RB5 == 0 && PORTB.RB0 == 1){
	BTFSC      PORTB+0, 5
	GOTO       L_readSMS11
	BTFSS      PORTB+0, 0
	GOTO       L_readSMS11
L__readSMS42:
;DazoGSM.c,45 :: 		sendSMS(indoorError);
	MOVF       readSMS_indoorError_L0+0, 0
	MOVWF      FARG_sendSMS+0
	CALL       _sendSMS+0
;DazoGSM.c,46 :: 		}else{
	GOTO       L_readSMS12
L_readSMS11:
;DazoGSM.c,47 :: 		if(PORTB.RB5 == 1){
	BTFSS      PORTB+0, 5
	GOTO       L_readSMS13
;DazoGSM.c,48 :: 		sendSMS(indoorOn);
	MOVF       readSMS_indoorOn_L0+0, 0
	MOVWF      FARG_sendSMS+0
	CALL       _sendSMS+0
;DazoGSM.c,49 :: 		}else{
	GOTO       L_readSMS14
L_readSMS13:
;DazoGSM.c,50 :: 		sendSMS(indoorOff);
	MOVF       readSMS_indoorOff_L0+0, 0
	MOVWF      FARG_sendSMS+0
	CALL       _sendSMS+0
;DazoGSM.c,51 :: 		}
L_readSMS14:
;DazoGSM.c,52 :: 		}
L_readSMS12:
;DazoGSM.c,53 :: 		}
L_readSMS8:
;DazoGSM.c,55 :: 		if(strstr(inStr, "OU")){
	MOVLW      readSMS_inStr_L0+0
	MOVWF      FARG_strstr_s1+0
	MOVLW      ?lstr12_DazoGSM+0
	MOVWF      FARG_strstr_s2+0
	CALL       _strstr+0
	MOVF       R0+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_readSMS15
;DazoGSM.c,56 :: 		PORTB.F1 = ~PORTB.F1;
	MOVLW      2
	XORWF      PORTB+0, 1
;DazoGSM.c,57 :: 		if(PORTB.RB6 == 0 && PORTB.RB1 == 1){
	BTFSC      PORTB+0, 6
	GOTO       L_readSMS18
	BTFSS      PORTB+0, 1
	GOTO       L_readSMS18
L__readSMS41:
;DazoGSM.c,58 :: 		sendSMS(outdoorError);
	MOVF       readSMS_outdoorError_L0+0, 0
	MOVWF      FARG_sendSMS+0
	CALL       _sendSMS+0
;DazoGSM.c,59 :: 		}else{
	GOTO       L_readSMS19
L_readSMS18:
;DazoGSM.c,60 :: 		if(PORTB.RB6 == 1){
	BTFSS      PORTB+0, 6
	GOTO       L_readSMS20
;DazoGSM.c,61 :: 		sendSMS(outdoorOn);
	MOVF       readSMS_outdoorOn_L0+0, 0
	MOVWF      FARG_sendSMS+0
	CALL       _sendSMS+0
;DazoGSM.c,62 :: 		}else{
	GOTO       L_readSMS21
L_readSMS20:
;DazoGSM.c,63 :: 		sendSMS(outdoorOff);
	MOVF       readSMS_outdoorOff_L0+0, 0
	MOVWF      FARG_sendSMS+0
	CALL       _sendSMS+0
;DazoGSM.c,64 :: 		}
L_readSMS21:
;DazoGSM.c,65 :: 		}
L_readSMS19:
;DazoGSM.c,66 :: 		}
L_readSMS15:
;DazoGSM.c,67 :: 		}
L_readSMS3:
;DazoGSM.c,68 :: 		Delay_ms(100);
	MOVLW      130
	MOVWF      R12+0
	MOVLW      221
	MOVWF      R13+0
L_readSMS22:
	DECFSZ     R13+0, 1
	GOTO       L_readSMS22
	DECFSZ     R12+0, 1
	GOTO       L_readSMS22
	NOP
	NOP
;DazoGSM.c,70 :: 		}
L_end_readSMS:
	RETURN
; end of _readSMS

_initPorts:

;DazoGSM.c,72 :: 		void initPorts(){
;DazoGSM.c,73 :: 		ADCON1 = 0x08;
	MOVLW      8
	MOVWF      ADCON1+0
;DazoGSM.c,74 :: 		TRISB = 0xF0;
	MOVLW      240
	MOVWF      TRISB+0
;DazoGSM.c,75 :: 		PORTB = 0x00;
	CLRF       PORTB+0
;DazoGSM.c,76 :: 		UART1_Init(9600);
	MOVLW      25
	MOVWF      SPBRG+0
	BSF        TXSTA+0, 2
	CALL       _UART1_Init+0
;DazoGSM.c,77 :: 		sendATCommand("AT+CNMI=1,0,2,0,1\r\n");
	MOVLW      ?lstr13_DazoGSM+0
	MOVWF      FARG_sendATCommand+0
	CALL       _sendATCommand+0
;DazoGSM.c,78 :: 		sendATCommand("AT+CMGF=1\r\n");
	MOVLW      ?lstr14_DazoGSM+0
	MOVWF      FARG_sendATCommand+0
	CALL       _sendATCommand+0
;DazoGSM.c,79 :: 		sendSMS("Device On");
	MOVLW      ?lstr15_DazoGSM+0
	MOVWF      FARG_sendSMS+0
	CALL       _sendSMS+0
;DazoGSM.c,80 :: 		}
L_end_initPorts:
	RETURN
; end of _initPorts

_sendATCommand:

;DazoGSM.c,82 :: 		void sendATCommand(char *cmd){
;DazoGSM.c,85 :: 		UART1_Write_Text(cmd);
	MOVF       FARG_sendATCommand_cmd+0, 0
	MOVWF      FARG_UART1_Write_Text_uart_text+0
	CALL       _UART1_Write_Text+0
;DazoGSM.c,86 :: 		Delay_ms(500);
	MOVLW      3
	MOVWF      R11+0
	MOVLW      138
	MOVWF      R12+0
	MOVLW      85
	MOVWF      R13+0
L_sendATCommand23:
	DECFSZ     R13+0, 1
	GOTO       L_sendATCommand23
	DECFSZ     R12+0, 1
	GOTO       L_sendATCommand23
	DECFSZ     R11+0, 1
	GOTO       L_sendATCommand23
	NOP
	NOP
;DazoGSM.c,87 :: 		}
L_end_sendATCommand:
	RETURN
; end of _sendATCommand

_sendSMS:

;DazoGSM.c,90 :: 		void sendSMS(char *msg){
;DazoGSM.c,93 :: 		UART1_Write_Text("AT+CMGS=\"");
	MOVLW      ?lstr16_DazoGSM+0
	MOVWF      FARG_UART1_Write_Text_uart_text+0
	CALL       _UART1_Write_Text+0
;DazoGSM.c,94 :: 		for(i=0; i < 11; i++)
	CLRF       sendSMS_i_L0+0
	CLRF       sendSMS_i_L0+1
L_sendSMS24:
	MOVLW      128
	XORWF      sendSMS_i_L0+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__sendSMS49
	MOVLW      11
	SUBWF      sendSMS_i_L0+0, 0
L__sendSMS49:
	BTFSC      STATUS+0, 0
	GOTO       L_sendSMS25
;DazoGSM.c,95 :: 		UART1_Write(*(recepientNumber+i));
	MOVF       sendSMS_i_L0+0, 0
	ADDWF      _recepientNumber+0, 0
	MOVWF      R0+0
	MOVF       _recepientNumber+1, 0
	BTFSC      STATUS+0, 0
	ADDLW      1
	ADDWF      sendSMS_i_L0+1, 0
	MOVWF      R0+1
	MOVF       R0+0, 0
	MOVWF      ___DoICPAddr+0
	MOVF       R0+1, 0
	MOVWF      ___DoICPAddr+1
	CALL       _____DoICP+0
	MOVWF      FARG_UART1_Write_data_+0
	CALL       _UART1_Write+0
;DazoGSM.c,94 :: 		for(i=0; i < 11; i++)
	INCF       sendSMS_i_L0+0, 1
	BTFSC      STATUS+0, 2
	INCF       sendSMS_i_L0+1, 1
;DazoGSM.c,95 :: 		UART1_Write(*(recepientNumber+i));
	GOTO       L_sendSMS24
L_sendSMS25:
;DazoGSM.c,96 :: 		UART1_Write_Text("\"\r\n");
	MOVLW      ?lstr17_DazoGSM+0
	MOVWF      FARG_UART1_Write_Text_uart_text+0
	CALL       _UART1_Write_Text+0
;DazoGSM.c,97 :: 		Delay_ms(1000);
	MOVLW      6
	MOVWF      R11+0
	MOVLW      19
	MOVWF      R12+0
	MOVLW      173
	MOVWF      R13+0
L_sendSMS27:
	DECFSZ     R13+0, 1
	GOTO       L_sendSMS27
	DECFSZ     R12+0, 1
	GOTO       L_sendSMS27
	DECFSZ     R11+0, 1
	GOTO       L_sendSMS27
	NOP
	NOP
;DazoGSM.c,98 :: 		if(UART1_Data_Ready()){
	CALL       _UART1_Data_Ready+0
	MOVF       R0+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_sendSMS28
;DazoGSM.c,99 :: 		for(i=0; UART1_Data_Ready(); i++){
	CLRF       sendSMS_i_L0+0
	CLRF       sendSMS_i_L0+1
L_sendSMS29:
	CALL       _UART1_Data_Ready+0
	MOVF       R0+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_sendSMS30
;DazoGSM.c,100 :: 		in = UART1_Read();
	CALL       _UART1_Read+0
;DazoGSM.c,99 :: 		for(i=0; UART1_Data_Ready(); i++){
	INCF       sendSMS_i_L0+0, 1
	BTFSC      STATUS+0, 2
	INCF       sendSMS_i_L0+1, 1
;DazoGSM.c,101 :: 		}
	GOTO       L_sendSMS29
L_sendSMS30:
;DazoGSM.c,102 :: 		}
L_sendSMS28:
;DazoGSM.c,103 :: 		UART1_Write_Text(msg);
	MOVF       FARG_sendSMS_msg+0, 0
	MOVWF      FARG_UART1_Write_Text_uart_text+0
	CALL       _UART1_Write_Text+0
;DazoGSM.c,104 :: 		Delay_ms(1000);
	MOVLW      6
	MOVWF      R11+0
	MOVLW      19
	MOVWF      R12+0
	MOVLW      173
	MOVWF      R13+0
L_sendSMS32:
	DECFSZ     R13+0, 1
	GOTO       L_sendSMS32
	DECFSZ     R12+0, 1
	GOTO       L_sendSMS32
	DECFSZ     R11+0, 1
	GOTO       L_sendSMS32
	NOP
	NOP
;DazoGSM.c,105 :: 		UART1_Write(26);
	MOVLW      26
	MOVWF      FARG_UART1_Write_data_+0
	CALL       _UART1_Write+0
;DazoGSM.c,106 :: 		Delay_ms(500);
	MOVLW      3
	MOVWF      R11+0
	MOVLW      138
	MOVWF      R12+0
	MOVLW      85
	MOVWF      R13+0
L_sendSMS33:
	DECFSZ     R13+0, 1
	GOTO       L_sendSMS33
	DECFSZ     R12+0, 1
	GOTO       L_sendSMS33
	DECFSZ     R11+0, 1
	GOTO       L_sendSMS33
	NOP
	NOP
;DazoGSM.c,107 :: 		}
L_end_sendSMS:
	RETURN
; end of _sendSMS

_detectBO:

;DazoGSM.c,109 :: 		void detectBO(){
;DazoGSM.c,110 :: 		if(PORTB.F4 == 0 && BOSMSSent == 0){
	BTFSC      PORTB+0, 4
	GOTO       L_detectBO36
	MOVLW      0
	XORWF      _BOSMSSent+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__detectBO51
	MOVLW      0
	XORWF      _BOSMSSent+0, 0
L__detectBO51:
	BTFSS      STATUS+0, 2
	GOTO       L_detectBO36
L__detectBO43:
;DazoGSM.c,111 :: 		sendSMS("The power is off");
	MOVLW      ?lstr18_DazoGSM+0
	MOVWF      FARG_sendSMS_msg+0
	CALL       _sendSMS+0
;DazoGSM.c,112 :: 		BOSMSSent = 1;
	MOVLW      1
	MOVWF      _BOSMSSent+0
	MOVLW      0
	MOVWF      _BOSMSSent+1
;DazoGSM.c,113 :: 		while(PORTB.F4 == 0);
L_detectBO37:
	BTFSC      PORTB+0, 4
	GOTO       L_detectBO38
	GOTO       L_detectBO37
L_detectBO38:
;DazoGSM.c,114 :: 		if(PORTB.F4 == 1)sendSMS("The power is back");
	BTFSS      PORTB+0, 4
	GOTO       L_detectBO39
	MOVLW      ?lstr19_DazoGSM+0
	MOVWF      FARG_sendSMS_msg+0
	CALL       _sendSMS+0
L_detectBO39:
;DazoGSM.c,115 :: 		}
L_detectBO36:
;DazoGSM.c,116 :: 		if(PORTB.F4 == 1) BOSMSSent = 0;
	BTFSS      PORTB+0, 4
	GOTO       L_detectBO40
	CLRF       _BOSMSSent+0
	CLRF       _BOSMSSent+1
L_detectBO40:
;DazoGSM.c,117 :: 		}
L_end_detectBO:
	RETURN
; end of _detectBO
