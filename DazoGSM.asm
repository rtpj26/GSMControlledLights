
_main:

;DazoGSM.c,12 :: 		void main() {
;DazoGSM.c,13 :: 		initPorts();
	CALL        _initPorts+0, 0
;DazoGSM.c,15 :: 		while(1){
L_main0:
;DazoGSM.c,16 :: 		detectBO();
	CALL        _detectBO+0, 0
;DazoGSM.c,17 :: 		readSMS();
	CALL        _readSMS+0, 0
;DazoGSM.c,18 :: 		}
	GOTO        L_main0
;DazoGSM.c,19 :: 		}
L_end_main:
	GOTO        $+0
; end of _main

_readSMS:

;DazoGSM.c,21 :: 		void readSMS(){
;DazoGSM.c,22 :: 		char *indoorError = "There might be a problem with your INDOOR Lights. please check";
	MOVLW       ?lstr2_DazoGSM+0
	MOVWF       readSMS_indoorError_L0+0 
	MOVLW       hi_addr(?lstr2_DazoGSM+0)
	MOVWF       readSMS_indoorError_L0+1 
	MOVLW       ?lstr3_DazoGSM+0
	MOVWF       readSMS_indoorOn_L0+0 
	MOVLW       hi_addr(?lstr3_DazoGSM+0)
	MOVWF       readSMS_indoorOn_L0+1 
	MOVLW       ?lstr4_DazoGSM+0
	MOVWF       readSMS_indoorOff_L0+0 
	MOVLW       hi_addr(?lstr4_DazoGSM+0)
	MOVWF       readSMS_indoorOff_L0+1 
	MOVLW       ?lstr5_DazoGSM+0
	MOVWF       readSMS_outdoorError_L0+0 
	MOVLW       hi_addr(?lstr5_DazoGSM+0)
	MOVWF       readSMS_outdoorError_L0+1 
	MOVLW       ?lstr6_DazoGSM+0
	MOVWF       readSMS_outdoorOn_L0+0 
	MOVLW       hi_addr(?lstr6_DazoGSM+0)
	MOVWF       readSMS_outdoorOn_L0+1 
	MOVLW       ?lstr7_DazoGSM+0
	MOVWF       readSMS_outdoorOff_L0+0 
	MOVLW       hi_addr(?lstr7_DazoGSM+0)
	MOVWF       readSMS_outdoorOff_L0+1 
	MOVLW       ?lstr8_DazoGSM+0
	MOVWF       readSMS_smart_L0+0 
	MOVLW       hi_addr(?lstr8_DazoGSM+0)
	MOVWF       readSMS_smart_L0+1 
	MOVLW       ?lstr9_DazoGSM+0
	MOVWF       readSMS_sun_L0+0 
	MOVLW       hi_addr(?lstr9_DazoGSM+0)
	MOVWF       readSMS_sun_L0+1 
	MOVLW       ?lstr10_DazoGSM+0
	MOVWF       readSMS_globe_L0+0 
	MOVLW       hi_addr(?lstr10_DazoGSM+0)
	MOVWF       readSMS_globe_L0+1 
;DazoGSM.c,36 :: 		if(UART1_Data_Ready()){
	CALL        _UART1_Data_Ready+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_readSMS2
;DazoGSM.c,37 :: 		UART_Read_Text(inStr, "--", 100);
	MOVLW       readSMS_inStr_L0+0
	MOVWF       FARG_UART_Read_Text_Output+0 
	MOVLW       hi_addr(readSMS_inStr_L0+0)
	MOVWF       FARG_UART_Read_Text_Output+1 
	MOVLW       ?lstr11_DazoGSM+0
	MOVWF       FARG_UART_Read_Text_Delimiter+0 
	MOVLW       hi_addr(?lstr11_DazoGSM+0)
	MOVWF       FARG_UART_Read_Text_Delimiter+1 
	MOVLW       100
	MOVWF       FARG_UART_Read_Text_Attempts+0 
	CALL        _UART_Read_Text+0, 0
;DazoGSM.c,38 :: 		Delay_ms(200);
	MOVLW       2
	MOVWF       R11, 0
	MOVLW       4
	MOVWF       R12, 0
	MOVLW       186
	MOVWF       R13, 0
L_readSMS3:
	DECFSZ      R13, 1, 1
	BRA         L_readSMS3
	DECFSZ      R12, 1, 1
	BRA         L_readSMS3
	DECFSZ      R11, 1, 1
	BRA         L_readSMS3
	NOP
;DazoGSM.c,39 :: 		if(strstr(inStr, "INDOOR") && ((strstr(inStr, smart) || strstr(inStr, globe) || strstr(inStr, sun)))){
	MOVLW       readSMS_inStr_L0+0
	MOVWF       FARG_strstr_s1+0 
	MOVLW       hi_addr(readSMS_inStr_L0+0)
	MOVWF       FARG_strstr_s1+1 
	MOVLW       ?lstr12_DazoGSM+0
	MOVWF       FARG_strstr_s2+0 
	MOVLW       hi_addr(?lstr12_DazoGSM+0)
	MOVWF       FARG_strstr_s2+1 
	CALL        _strstr+0, 0
	MOVF        R0, 0 
	IORWF       R1, 0 
	BTFSC       STATUS+0, 2 
	GOTO        L_readSMS8
	MOVLW       readSMS_inStr_L0+0
	MOVWF       FARG_strstr_s1+0 
	MOVLW       hi_addr(readSMS_inStr_L0+0)
	MOVWF       FARG_strstr_s1+1 
	MOVF        readSMS_smart_L0+0, 0 
	MOVWF       FARG_strstr_s2+0 
	MOVF        readSMS_smart_L0+1, 0 
	MOVWF       FARG_strstr_s2+1 
	CALL        _strstr+0, 0
	MOVF        R0, 0 
	IORWF       R1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__readSMS52
	MOVLW       readSMS_inStr_L0+0
	MOVWF       FARG_strstr_s1+0 
	MOVLW       hi_addr(readSMS_inStr_L0+0)
	MOVWF       FARG_strstr_s1+1 
	MOVF        readSMS_globe_L0+0, 0 
	MOVWF       FARG_strstr_s2+0 
	MOVF        readSMS_globe_L0+1, 0 
	MOVWF       FARG_strstr_s2+1 
	CALL        _strstr+0, 0
	MOVF        R0, 0 
	IORWF       R1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__readSMS52
	MOVLW       readSMS_inStr_L0+0
	MOVWF       FARG_strstr_s1+0 
	MOVLW       hi_addr(readSMS_inStr_L0+0)
	MOVWF       FARG_strstr_s1+1 
	MOVF        readSMS_sun_L0+0, 0 
	MOVWF       FARG_strstr_s2+0 
	MOVF        readSMS_sun_L0+1, 0 
	MOVWF       FARG_strstr_s2+1 
	CALL        _strstr+0, 0
	MOVF        R0, 0 
	IORWF       R1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__readSMS52
	GOTO        L_readSMS8
L__readSMS52:
L__readSMS51:
;DazoGSM.c,40 :: 		PORTB.F0 = ~PORTB.F0;
	BTG         PORTB+0, 0 
;DazoGSM.c,41 :: 		if(PORTB.RB5 == 0 && PORTB.RB0 == 1){
	BTFSC       PORTB+0, 5 
	GOTO        L_readSMS11
	BTFSS       PORTB+0, 0 
	GOTO        L_readSMS11
L__readSMS50:
;DazoGSM.c,42 :: 		sendSMS(indoorError);
	MOVF        readSMS_indoorError_L0+0, 0 
	MOVWF       FARG_sendSMS+0 
	MOVF        readSMS_indoorError_L0+1, 0 
	MOVWF       FARG_sendSMS+1 
	CALL        _sendSMS+0, 0
;DazoGSM.c,43 :: 		}else{
	GOTO        L_readSMS12
L_readSMS11:
;DazoGSM.c,44 :: 		if(PORTB.RB5 == 1){
	BTFSS       PORTB+0, 5 
	GOTO        L_readSMS13
;DazoGSM.c,45 :: 		sendSMS(indoorOn);
	MOVF        readSMS_indoorOn_L0+0, 0 
	MOVWF       FARG_sendSMS+0 
	MOVF        readSMS_indoorOn_L0+1, 0 
	MOVWF       FARG_sendSMS+1 
	CALL        _sendSMS+0, 0
;DazoGSM.c,46 :: 		}else{
	GOTO        L_readSMS14
L_readSMS13:
;DazoGSM.c,47 :: 		sendSMS(indoorOff);
	MOVF        readSMS_indoorOff_L0+0, 0 
	MOVWF       FARG_sendSMS+0 
	MOVF        readSMS_indoorOff_L0+1, 0 
	MOVWF       FARG_sendSMS+1 
	CALL        _sendSMS+0, 0
;DazoGSM.c,48 :: 		}
L_readSMS14:
;DazoGSM.c,49 :: 		}
L_readSMS12:
;DazoGSM.c,50 :: 		}
	GOTO        L_readSMS15
L_readSMS8:
;DazoGSM.c,52 :: 		else if(strstr(inStr, "OUTDOOR") && ((strstr(inStr, smart) || strstr(inStr, globe) || strstr(inStr, sun)))){
	MOVLW       readSMS_inStr_L0+0
	MOVWF       FARG_strstr_s1+0 
	MOVLW       hi_addr(readSMS_inStr_L0+0)
	MOVWF       FARG_strstr_s1+1 
	MOVLW       ?lstr13_DazoGSM+0
	MOVWF       FARG_strstr_s2+0 
	MOVLW       hi_addr(?lstr13_DazoGSM+0)
	MOVWF       FARG_strstr_s2+1 
	CALL        _strstr+0, 0
	MOVF        R0, 0 
	IORWF       R1, 0 
	BTFSC       STATUS+0, 2 
	GOTO        L_readSMS20
	MOVLW       readSMS_inStr_L0+0
	MOVWF       FARG_strstr_s1+0 
	MOVLW       hi_addr(readSMS_inStr_L0+0)
	MOVWF       FARG_strstr_s1+1 
	MOVF        readSMS_smart_L0+0, 0 
	MOVWF       FARG_strstr_s2+0 
	MOVF        readSMS_smart_L0+1, 0 
	MOVWF       FARG_strstr_s2+1 
	CALL        _strstr+0, 0
	MOVF        R0, 0 
	IORWF       R1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__readSMS49
	MOVLW       readSMS_inStr_L0+0
	MOVWF       FARG_strstr_s1+0 
	MOVLW       hi_addr(readSMS_inStr_L0+0)
	MOVWF       FARG_strstr_s1+1 
	MOVF        readSMS_globe_L0+0, 0 
	MOVWF       FARG_strstr_s2+0 
	MOVF        readSMS_globe_L0+1, 0 
	MOVWF       FARG_strstr_s2+1 
	CALL        _strstr+0, 0
	MOVF        R0, 0 
	IORWF       R1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__readSMS49
	MOVLW       readSMS_inStr_L0+0
	MOVWF       FARG_strstr_s1+0 
	MOVLW       hi_addr(readSMS_inStr_L0+0)
	MOVWF       FARG_strstr_s1+1 
	MOVF        readSMS_sun_L0+0, 0 
	MOVWF       FARG_strstr_s2+0 
	MOVF        readSMS_sun_L0+1, 0 
	MOVWF       FARG_strstr_s2+1 
	CALL        _strstr+0, 0
	MOVF        R0, 0 
	IORWF       R1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__readSMS49
	GOTO        L_readSMS20
L__readSMS49:
L__readSMS48:
;DazoGSM.c,53 :: 		PORTB.F1 = ~PORTB.F1;
	BTG         PORTB+0, 1 
;DazoGSM.c,54 :: 		if(PORTB.RB6 == 0 && PORTB.RB1 == 1){
	BTFSC       PORTB+0, 6 
	GOTO        L_readSMS23
	BTFSS       PORTB+0, 1 
	GOTO        L_readSMS23
L__readSMS47:
;DazoGSM.c,55 :: 		sendSMS(outdoorError);
	MOVF        readSMS_outdoorError_L0+0, 0 
	MOVWF       FARG_sendSMS+0 
	MOVF        readSMS_outdoorError_L0+1, 0 
	MOVWF       FARG_sendSMS+1 
	CALL        _sendSMS+0, 0
;DazoGSM.c,56 :: 		}else{
	GOTO        L_readSMS24
L_readSMS23:
;DazoGSM.c,57 :: 		if(PORTB.RB6 == 1){
	BTFSS       PORTB+0, 6 
	GOTO        L_readSMS25
;DazoGSM.c,58 :: 		sendSMS(outdoorOn);
	MOVF        readSMS_outdoorOn_L0+0, 0 
	MOVWF       FARG_sendSMS+0 
	MOVF        readSMS_outdoorOn_L0+1, 0 
	MOVWF       FARG_sendSMS+1 
	CALL        _sendSMS+0, 0
;DazoGSM.c,59 :: 		}else{
	GOTO        L_readSMS26
L_readSMS25:
;DazoGSM.c,60 :: 		sendSMS(outdoorOff);
	MOVF        readSMS_outdoorOff_L0+0, 0 
	MOVWF       FARG_sendSMS+0 
	MOVF        readSMS_outdoorOff_L0+1, 0 
	MOVWF       FARG_sendSMS+1 
	CALL        _sendSMS+0, 0
;DazoGSM.c,61 :: 		}
L_readSMS26:
;DazoGSM.c,62 :: 		}
L_readSMS24:
;DazoGSM.c,63 :: 		}
	GOTO        L_readSMS27
L_readSMS20:
;DazoGSM.c,65 :: 		}
L_readSMS27:
L_readSMS15:
;DazoGSM.c,66 :: 		EEPROM_Write(0x38, PORTB); //Kwa on ang previous status sng PIC
	MOVLW       56
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVF        PORTB+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;DazoGSM.c,67 :: 		sendATCommand("AT+CMGD=1,4\r\n");
	MOVLW       ?lstr14_DazoGSM+0
	MOVWF       FARG_sendATCommand+0 
	MOVLW       hi_addr(?lstr14_DazoGSM+0)
	MOVWF       FARG_sendATCommand+1 
	CALL        _sendATCommand+0, 0
;DazoGSM.c,68 :: 		}
L_readSMS2:
;DazoGSM.c,69 :: 		Delay_ms(100);
	MOVLW       130
	MOVWF       R12, 0
	MOVLW       221
	MOVWF       R13, 0
L_readSMS28:
	DECFSZ      R13, 1, 1
	BRA         L_readSMS28
	DECFSZ      R12, 1, 1
	BRA         L_readSMS28
	NOP
	NOP
;DazoGSM.c,71 :: 		}
L_end_readSMS:
	RETURN      0
; end of _readSMS

_initPorts:

;DazoGSM.c,73 :: 		void initPorts(){
;DazoGSM.c,74 :: 		ADCON1 = 0x07;
	MOVLW       7
	MOVWF       ADCON1+0 
;DazoGSM.c,75 :: 		TRISB = 0xF0;
	MOVLW       240
	MOVWF       TRISB+0 
;DazoGSM.c,76 :: 		TRISA= 0xFF;
	MOVLW       255
	MOVWF       TRISA+0 
;DazoGSM.c,77 :: 		PORTB = 0x00;
	CLRF        PORTB+0 
;DazoGSM.c,78 :: 		UART1_Init(9600);
	BSF         BAUDCON+0, 3, 0
	CLRF        SPBRGH+0 
	MOVLW       103
	MOVWF       SPBRG+0 
	BSF         TXSTA+0, 2, 0
	CALL        _UART1_Init+0, 0
;DazoGSM.c,79 :: 		sendATCommand("AT+CNMI=1,0,2,0,1\r\n");
	MOVLW       ?lstr15_DazoGSM+0
	MOVWF       FARG_sendATCommand+0 
	MOVLW       hi_addr(?lstr15_DazoGSM+0)
	MOVWF       FARG_sendATCommand+1 
	CALL        _sendATCommand+0, 0
;DazoGSM.c,80 :: 		sendATCommand("AT+CMGF=1\r\n");
	MOVLW       ?lstr16_DazoGSM+0
	MOVWF       FARG_sendATCommand+0 
	MOVLW       hi_addr(?lstr16_DazoGSM+0)
	MOVWF       FARG_sendATCommand+1 
	CALL        _sendATCommand+0, 0
;DazoGSM.c,81 :: 		sendSMS("Device On");
	MOVLW       ?lstr17_DazoGSM+0
	MOVWF       FARG_sendSMS+0 
	MOVLW       hi_addr(?lstr17_DazoGSM+0)
	MOVWF       FARG_sendSMS+1 
	CALL        _sendSMS+0, 0
;DazoGSM.c,82 :: 		}
L_end_initPorts:
	RETURN      0
; end of _initPorts

_sendATCommand:

;DazoGSM.c,84 :: 		void sendATCommand(char *cmd){
;DazoGSM.c,87 :: 		UART1_Write_Text(cmd);
	MOVF        FARG_sendATCommand_cmd+0, 0 
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVF        FARG_sendATCommand_cmd+1, 0 
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;DazoGSM.c,88 :: 		Delay_ms(500);
	MOVLW       3
	MOVWF       R11, 0
	MOVLW       138
	MOVWF       R12, 0
	MOVLW       85
	MOVWF       R13, 0
L_sendATCommand29:
	DECFSZ      R13, 1, 1
	BRA         L_sendATCommand29
	DECFSZ      R12, 1, 1
	BRA         L_sendATCommand29
	DECFSZ      R11, 1, 1
	BRA         L_sendATCommand29
	NOP
	NOP
;DazoGSM.c,89 :: 		}
L_end_sendATCommand:
	RETURN      0
; end of _sendATCommand

_sendSMS:

;DazoGSM.c,92 :: 		void sendSMS(char *msg){
;DazoGSM.c,95 :: 		Delay_ms(2000);
	MOVLW       11
	MOVWF       R11, 0
	MOVLW       38
	MOVWF       R12, 0
	MOVLW       93
	MOVWF       R13, 0
L_sendSMS30:
	DECFSZ      R13, 1, 1
	BRA         L_sendSMS30
	DECFSZ      R12, 1, 1
	BRA         L_sendSMS30
	DECFSZ      R11, 1, 1
	BRA         L_sendSMS30
	NOP
	NOP
;DazoGSM.c,96 :: 		UART1_Write_Text("AT+CMGS=\"");
	MOVLW       ?lstr18_DazoGSM+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(?lstr18_DazoGSM+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;DazoGSM.c,97 :: 		for(i=0; i < 11; i++)
	CLRF        sendSMS_i_L0+0 
	CLRF        sendSMS_i_L0+1 
L_sendSMS31:
	MOVLW       128
	XORWF       sendSMS_i_L0+1, 0 
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__sendSMS59
	MOVLW       11
	SUBWF       sendSMS_i_L0+0, 0 
L__sendSMS59:
	BTFSC       STATUS+0, 0 
	GOTO        L_sendSMS32
;DazoGSM.c,98 :: 		UART1_Write(*(recepientNumber+i));
	MOVF        sendSMS_i_L0+0, 0 
	ADDWF       _recepientNumber+0, 0 
	MOVWF       TBLPTRL 
	MOVF        sendSMS_i_L0+1, 0 
	ADDWFC      _recepientNumber+1, 0 
	MOVWF       TBLPTRH 
	MOVLW       0
	BTFSC       sendSMS_i_L0+1, 7 
	MOVLW       255
	ADDWFC      _recepientNumber+2, 0 
	MOVWF       TBLPTRU 
	TBLRD*+
	MOVFF       TABLAT+0, FARG_UART1_Write_data_+0
	CALL        _UART1_Write+0, 0
;DazoGSM.c,97 :: 		for(i=0; i < 11; i++)
	INFSNZ      sendSMS_i_L0+0, 1 
	INCF        sendSMS_i_L0+1, 1 
;DazoGSM.c,98 :: 		UART1_Write(*(recepientNumber+i));
	GOTO        L_sendSMS31
L_sendSMS32:
;DazoGSM.c,99 :: 		UART1_Write_Text("\"\r\n");
	MOVLW       ?lstr19_DazoGSM+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(?lstr19_DazoGSM+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;DazoGSM.c,100 :: 		Delay_ms(1000);
	MOVLW       6
	MOVWF       R11, 0
	MOVLW       19
	MOVWF       R12, 0
	MOVLW       173
	MOVWF       R13, 0
L_sendSMS34:
	DECFSZ      R13, 1, 1
	BRA         L_sendSMS34
	DECFSZ      R12, 1, 1
	BRA         L_sendSMS34
	DECFSZ      R11, 1, 1
	BRA         L_sendSMS34
	NOP
	NOP
;DazoGSM.c,101 :: 		if(UART1_Data_Ready()){
	CALL        _UART1_Data_Ready+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_sendSMS35
;DazoGSM.c,102 :: 		for(i=0; UART1_Data_Ready(); i++){
	CLRF        sendSMS_i_L0+0 
	CLRF        sendSMS_i_L0+1 
L_sendSMS36:
	CALL        _UART1_Data_Ready+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_sendSMS37
;DazoGSM.c,103 :: 		in = UART1_Read();
	CALL        _UART1_Read+0, 0
;DazoGSM.c,102 :: 		for(i=0; UART1_Data_Ready(); i++){
	INFSNZ      sendSMS_i_L0+0, 1 
	INCF        sendSMS_i_L0+1, 1 
;DazoGSM.c,104 :: 		}
	GOTO        L_sendSMS36
L_sendSMS37:
;DazoGSM.c,105 :: 		}
L_sendSMS35:
;DazoGSM.c,106 :: 		UART1_Write_Text(msg);
	MOVF        FARG_sendSMS_msg+0, 0 
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVF        FARG_sendSMS_msg+1, 0 
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;DazoGSM.c,107 :: 		Delay_ms(1000);
	MOVLW       6
	MOVWF       R11, 0
	MOVLW       19
	MOVWF       R12, 0
	MOVLW       173
	MOVWF       R13, 0
L_sendSMS39:
	DECFSZ      R13, 1, 1
	BRA         L_sendSMS39
	DECFSZ      R12, 1, 1
	BRA         L_sendSMS39
	DECFSZ      R11, 1, 1
	BRA         L_sendSMS39
	NOP
	NOP
;DazoGSM.c,108 :: 		UART1_Write(26);
	MOVLW       26
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;DazoGSM.c,109 :: 		Delay_ms(500);
	MOVLW       3
	MOVWF       R11, 0
	MOVLW       138
	MOVWF       R12, 0
	MOVLW       85
	MOVWF       R13, 0
L_sendSMS40:
	DECFSZ      R13, 1, 1
	BRA         L_sendSMS40
	DECFSZ      R12, 1, 1
	BRA         L_sendSMS40
	DECFSZ      R11, 1, 1
	BRA         L_sendSMS40
	NOP
	NOP
;DazoGSM.c,110 :: 		}
L_end_sendSMS:
	RETURN      0
; end of _sendSMS

_detectBO:

;DazoGSM.c,112 :: 		void detectBO(){
;DazoGSM.c,113 :: 		if(PORTB.F4 == 0 && BOSMSSent == 0){
	BTFSC       PORTB+0, 4 
	GOTO        L_detectBO43
	MOVLW       0
	XORWF       _BOSMSSent+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__detectBO61
	MOVLW       0
	XORWF       _BOSMSSent+0, 0 
L__detectBO61:
	BTFSS       STATUS+0, 2 
	GOTO        L_detectBO43
L__detectBO53:
;DazoGSM.c,114 :: 		sendSMS("The power is off");
	MOVLW       ?lstr20_DazoGSM+0
	MOVWF       FARG_sendSMS_msg+0 
	MOVLW       hi_addr(?lstr20_DazoGSM+0)
	MOVWF       FARG_sendSMS_msg+1 
	CALL        _sendSMS+0, 0
;DazoGSM.c,115 :: 		BOSMSSent = 1;
	MOVLW       1
	MOVWF       _BOSMSSent+0 
	MOVLW       0
	MOVWF       _BOSMSSent+1 
;DazoGSM.c,116 :: 		while(BOSMSSent == 1){
L_detectBO44:
	MOVLW       0
	XORWF       _BOSMSSent+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__detectBO62
	MOVLW       1
	XORWF       _BOSMSSent+0, 0 
L__detectBO62:
	BTFSS       STATUS+0, 2 
	GOTO        L_detectBO45
;DazoGSM.c,117 :: 		if(PORTB.F4 == 1) BOSMSSent = 0;
	BTFSS       PORTB+0, 4 
	GOTO        L_detectBO46
	CLRF        _BOSMSSent+0 
	CLRF        _BOSMSSent+1 
L_detectBO46:
;DazoGSM.c,118 :: 		}
	GOTO        L_detectBO44
L_detectBO45:
;DazoGSM.c,119 :: 		sendSMS("The power is back");
	MOVLW       ?lstr21_DazoGSM+0
	MOVWF       FARG_sendSMS_msg+0 
	MOVLW       hi_addr(?lstr21_DazoGSM+0)
	MOVWF       FARG_sendSMS_msg+1 
	CALL        _sendSMS+0, 0
;DazoGSM.c,120 :: 		PORTB = EEPROM_Read(0x38); //if magbalik ang suga, kwaun ang status kag ebalik sa portB
	MOVLW       56
	MOVWF       FARG_EEPROM_Read_address+0 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       PORTB+0 
;DazoGSM.c,121 :: 		}
L_detectBO43:
;DazoGSM.c,122 :: 		BOSMSSent = 0;
	CLRF        _BOSMSSent+0 
	CLRF        _BOSMSSent+1 
;DazoGSM.c,123 :: 		}
L_end_detectBO:
	RETURN      0
; end of _detectBO
