
_main:

;DazoGSM.c,17 :: 		void main() {
;DazoGSM.c,18 :: 		initPorts();
	CALL        _initPorts+0, 0
;DazoGSM.c,19 :: 		Delay_ms(500);
	MOVLW       3
	MOVWF       R11, 0
	MOVLW       138
	MOVWF       R12, 0
	MOVLW       85
	MOVWF       R13, 0
L_main0:
	DECFSZ      R13, 1, 1
	BRA         L_main0
	DECFSZ      R12, 1, 1
	BRA         L_main0
	DECFSZ      R11, 1, 1
	BRA         L_main0
	NOP
	NOP
;DazoGSM.c,20 :: 		while(1){
L_main1:
;DazoGSM.c,21 :: 		detectBO();
	CALL        _detectBO+0, 0
;DazoGSM.c,22 :: 		readSMS();
	CALL        _readSMS+0, 0
;DazoGSM.c,23 :: 		}
	GOTO        L_main1
;DazoGSM.c,24 :: 		}
L_end_main:
	GOTO        $+0
; end of _main

_readSMS:

;DazoGSM.c,26 :: 		void readSMS(){
;DazoGSM.c,27 :: 		char *indoorError = "There might be a problem with your INDOOR Lights. please check";
	MOVLW       ?lstr5_DazoGSM+0
	MOVWF       readSMS_indoorError_L0+0 
	MOVLW       hi_addr(?lstr5_DazoGSM+0)
	MOVWF       readSMS_indoorError_L0+1 
	MOVLW       ?lstr6_DazoGSM+0
	MOVWF       readSMS_indoorOn_L0+0 
	MOVLW       hi_addr(?lstr6_DazoGSM+0)
	MOVWF       readSMS_indoorOn_L0+1 
	MOVLW       ?lstr7_DazoGSM+0
	MOVWF       readSMS_indoorOff_L0+0 
	MOVLW       hi_addr(?lstr7_DazoGSM+0)
	MOVWF       readSMS_indoorOff_L0+1 
	MOVLW       ?lstr8_DazoGSM+0
	MOVWF       readSMS_outdoorError_L0+0 
	MOVLW       hi_addr(?lstr8_DazoGSM+0)
	MOVWF       readSMS_outdoorError_L0+1 
	MOVLW       ?lstr9_DazoGSM+0
	MOVWF       readSMS_outdoorOn_L0+0 
	MOVLW       hi_addr(?lstr9_DazoGSM+0)
	MOVWF       readSMS_outdoorOn_L0+1 
	MOVLW       ?lstr10_DazoGSM+0
	MOVWF       readSMS_outdoorOff_L0+0 
	MOVLW       hi_addr(?lstr10_DazoGSM+0)
	MOVWF       readSMS_outdoorOff_L0+1 
;DazoGSM.c,36 :: 		if(UART1_Data_Ready()){
	CALL        _UART1_Data_Ready+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_readSMS3
;DazoGSM.c,41 :: 		UART_Read_Text(inStr, "\n", 255);
	MOVLW       readSMS_inStr_L0+0
	MOVWF       FARG_UART_Read_Text_Output+0 
	MOVLW       hi_addr(readSMS_inStr_L0+0)
	MOVWF       FARG_UART_Read_Text_Output+1 
	MOVLW       ?lstr11_DazoGSM+0
	MOVWF       FARG_UART_Read_Text_Delimiter+0 
	MOVLW       hi_addr(?lstr11_DazoGSM+0)
	MOVWF       FARG_UART_Read_Text_Delimiter+1 
	MOVLW       255
	MOVWF       FARG_UART_Read_Text_Attempts+0 
	CALL        _UART_Read_Text+0, 0
;DazoGSM.c,43 :: 		Delay_ms(200);
	MOVLW       2
	MOVWF       R11, 0
	MOVLW       4
	MOVWF       R12, 0
	MOVLW       186
	MOVWF       R13, 0
L_readSMS4:
	DECFSZ      R13, 1, 1
	BRA         L_readSMS4
	DECFSZ      R12, 1, 1
	BRA         L_readSMS4
	DECFSZ      R11, 1, 1
	BRA         L_readSMS4
	NOP
;DazoGSM.c,44 :: 		UART1_Write_Text(inStr);
	MOVLW       readSMS_inStr_L0+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(readSMS_inStr_L0+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;DazoGSM.c,46 :: 		if(strstr(inStr, "INDOOR")){
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
	GOTO        L_readSMS5
;DazoGSM.c,47 :: 		PORTB.F0 = ~PORTB.F0;
	BTG         PORTB+0, 0 
;DazoGSM.c,48 :: 		if(PORTB.RB5 == 0 && PORTB.RB0 == 1){
	BTFSC       PORTB+0, 5 
	GOTO        L_readSMS8
	BTFSS       PORTB+0, 0 
	GOTO        L_readSMS8
L__readSMS39:
;DazoGSM.c,49 :: 		sendSMS(indoorError);
	MOVF        readSMS_indoorError_L0+0, 0 
	MOVWF       FARG_sendSMS+0 
	MOVF        readSMS_indoorError_L0+1, 0 
	MOVWF       FARG_sendSMS+1 
	CALL        _sendSMS+0, 0
;DazoGSM.c,50 :: 		}else{
	GOTO        L_readSMS9
L_readSMS8:
;DazoGSM.c,51 :: 		if(PORTB.RB5 == 1){
	BTFSS       PORTB+0, 5 
	GOTO        L_readSMS10
;DazoGSM.c,52 :: 		sendSMS(indoorOn);
	MOVF        readSMS_indoorOn_L0+0, 0 
	MOVWF       FARG_sendSMS+0 
	MOVF        readSMS_indoorOn_L0+1, 0 
	MOVWF       FARG_sendSMS+1 
	CALL        _sendSMS+0, 0
;DazoGSM.c,53 :: 		}else{
	GOTO        L_readSMS11
L_readSMS10:
;DazoGSM.c,54 :: 		sendSMS(indoorOff);
	MOVF        readSMS_indoorOff_L0+0, 0 
	MOVWF       FARG_sendSMS+0 
	MOVF        readSMS_indoorOff_L0+1, 0 
	MOVWF       FARG_sendSMS+1 
	CALL        _sendSMS+0, 0
;DazoGSM.c,55 :: 		}
L_readSMS11:
;DazoGSM.c,56 :: 		}
L_readSMS9:
;DazoGSM.c,57 :: 		}
L_readSMS5:
;DazoGSM.c,59 :: 		if(strstr(inStr, "OUTDOOR")){
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
	GOTO        L_readSMS12
;DazoGSM.c,60 :: 		PORTB.F1 = ~PORTB.F1;
	BTG         PORTB+0, 1 
;DazoGSM.c,61 :: 		if(PORTB.RB6 == 0 && PORTB.RB1 == 1){
	BTFSC       PORTB+0, 6 
	GOTO        L_readSMS15
	BTFSS       PORTB+0, 1 
	GOTO        L_readSMS15
L__readSMS38:
;DazoGSM.c,62 :: 		sendSMS(outdoorError);
	MOVF        readSMS_outdoorError_L0+0, 0 
	MOVWF       FARG_sendSMS+0 
	MOVF        readSMS_outdoorError_L0+1, 0 
	MOVWF       FARG_sendSMS+1 
	CALL        _sendSMS+0, 0
;DazoGSM.c,63 :: 		}else{
	GOTO        L_readSMS16
L_readSMS15:
;DazoGSM.c,64 :: 		if(PORTB.RB6 == 1){
	BTFSS       PORTB+0, 6 
	GOTO        L_readSMS17
;DazoGSM.c,65 :: 		sendSMS(outdoorOn);
	MOVF        readSMS_outdoorOn_L0+0, 0 
	MOVWF       FARG_sendSMS+0 
	MOVF        readSMS_outdoorOn_L0+1, 0 
	MOVWF       FARG_sendSMS+1 
	CALL        _sendSMS+0, 0
;DazoGSM.c,66 :: 		}else{
	GOTO        L_readSMS18
L_readSMS17:
;DazoGSM.c,67 :: 		sendSMS(outdoorOff);
	MOVF        readSMS_outdoorOff_L0+0, 0 
	MOVWF       FARG_sendSMS+0 
	MOVF        readSMS_outdoorOff_L0+1, 0 
	MOVWF       FARG_sendSMS+1 
	CALL        _sendSMS+0, 0
;DazoGSM.c,68 :: 		}
L_readSMS18:
;DazoGSM.c,69 :: 		}
L_readSMS16:
;DazoGSM.c,70 :: 		}
L_readSMS12:
;DazoGSM.c,71 :: 		}
L_readSMS3:
;DazoGSM.c,72 :: 		Delay_ms(100);
	MOVLW       130
	MOVWF       R12, 0
	MOVLW       221
	MOVWF       R13, 0
L_readSMS19:
	DECFSZ      R13, 1, 1
	BRA         L_readSMS19
	DECFSZ      R12, 1, 1
	BRA         L_readSMS19
	NOP
	NOP
;DazoGSM.c,74 :: 		}
L_end_readSMS:
	RETURN      0
; end of _readSMS

_initPorts:

;DazoGSM.c,76 :: 		void initPorts(){
;DazoGSM.c,77 :: 		ADCON1 = 0x07;
	MOVLW       7
	MOVWF       ADCON1+0 
;DazoGSM.c,78 :: 		TRISB = 0xF0;
	MOVLW       240
	MOVWF       TRISB+0 
;DazoGSM.c,79 :: 		PORTB = 0x00;
	CLRF        PORTB+0 
;DazoGSM.c,80 :: 		UART1_Init(9600);
	BSF         BAUDCON+0, 3, 0
	CLRF        SPBRGH+0 
	MOVLW       103
	MOVWF       SPBRG+0 
	BSF         TXSTA+0, 2, 0
	CALL        _UART1_Init+0, 0
;DazoGSM.c,81 :: 		sendATCommand("AT+CNMI=1,0,2,0,1\r\n");
	MOVLW       ?lstr14_DazoGSM+0
	MOVWF       FARG_sendATCommand+0 
	MOVLW       hi_addr(?lstr14_DazoGSM+0)
	MOVWF       FARG_sendATCommand+1 
	CALL        _sendATCommand+0, 0
;DazoGSM.c,82 :: 		sendATCommand("AT+CMGF=1\r\n");
	MOVLW       ?lstr15_DazoGSM+0
	MOVWF       FARG_sendATCommand+0 
	MOVLW       hi_addr(?lstr15_DazoGSM+0)
	MOVWF       FARG_sendATCommand+1 
	CALL        _sendATCommand+0, 0
;DazoGSM.c,83 :: 		sendSMS("Device On");
	MOVLW       ?lstr16_DazoGSM+0
	MOVWF       FARG_sendSMS+0 
	MOVLW       hi_addr(?lstr16_DazoGSM+0)
	MOVWF       FARG_sendSMS+1 
	CALL        _sendSMS+0, 0
;DazoGSM.c,84 :: 		}
L_end_initPorts:
	RETURN      0
; end of _initPorts

_sendATCommand:

;DazoGSM.c,86 :: 		void sendATCommand(char *cmd){
;DazoGSM.c,89 :: 		UART1_Write_Text(cmd);
	MOVF        FARG_sendATCommand_cmd+0, 0 
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVF        FARG_sendATCommand_cmd+1, 0 
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;DazoGSM.c,90 :: 		Delay_ms(500);
	MOVLW       3
	MOVWF       R11, 0
	MOVLW       138
	MOVWF       R12, 0
	MOVLW       85
	MOVWF       R13, 0
L_sendATCommand20:
	DECFSZ      R13, 1, 1
	BRA         L_sendATCommand20
	DECFSZ      R12, 1, 1
	BRA         L_sendATCommand20
	DECFSZ      R11, 1, 1
	BRA         L_sendATCommand20
	NOP
	NOP
;DazoGSM.c,91 :: 		}
L_end_sendATCommand:
	RETURN      0
; end of _sendATCommand

_sendSMS:

;DazoGSM.c,94 :: 		void sendSMS(char *msg){
;DazoGSM.c,97 :: 		UART1_Write_Text("AT+CMGS=\"");
	MOVLW       ?lstr17_DazoGSM+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(?lstr17_DazoGSM+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;DazoGSM.c,98 :: 		for(i=0; i < 11; i++)
	CLRF        sendSMS_i_L0+0 
	CLRF        sendSMS_i_L0+1 
L_sendSMS21:
	MOVLW       128
	XORWF       sendSMS_i_L0+1, 0 
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__sendSMS46
	MOVLW       11
	SUBWF       sendSMS_i_L0+0, 0 
L__sendSMS46:
	BTFSC       STATUS+0, 0 
	GOTO        L_sendSMS22
;DazoGSM.c,99 :: 		UART1_Write(*(recepientNumber+i));
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
;DazoGSM.c,98 :: 		for(i=0; i < 11; i++)
	INFSNZ      sendSMS_i_L0+0, 1 
	INCF        sendSMS_i_L0+1, 1 
;DazoGSM.c,99 :: 		UART1_Write(*(recepientNumber+i));
	GOTO        L_sendSMS21
L_sendSMS22:
;DazoGSM.c,100 :: 		UART1_Write_Text("\"\r\n");
	MOVLW       ?lstr18_DazoGSM+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(?lstr18_DazoGSM+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;DazoGSM.c,101 :: 		Delay_ms(1000);
	MOVLW       6
	MOVWF       R11, 0
	MOVLW       19
	MOVWF       R12, 0
	MOVLW       173
	MOVWF       R13, 0
L_sendSMS24:
	DECFSZ      R13, 1, 1
	BRA         L_sendSMS24
	DECFSZ      R12, 1, 1
	BRA         L_sendSMS24
	DECFSZ      R11, 1, 1
	BRA         L_sendSMS24
	NOP
	NOP
;DazoGSM.c,102 :: 		if(UART1_Data_Ready()){
	CALL        _UART1_Data_Ready+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_sendSMS25
;DazoGSM.c,103 :: 		for(i=0; UART1_Data_Ready(); i++){
	CLRF        sendSMS_i_L0+0 
	CLRF        sendSMS_i_L0+1 
L_sendSMS26:
	CALL        _UART1_Data_Ready+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_sendSMS27
;DazoGSM.c,104 :: 		in = UART1_Read();
	CALL        _UART1_Read+0, 0
;DazoGSM.c,103 :: 		for(i=0; UART1_Data_Ready(); i++){
	INFSNZ      sendSMS_i_L0+0, 1 
	INCF        sendSMS_i_L0+1, 1 
;DazoGSM.c,105 :: 		}
	GOTO        L_sendSMS26
L_sendSMS27:
;DazoGSM.c,106 :: 		}
L_sendSMS25:
;DazoGSM.c,107 :: 		UART1_Write_Text(msg);
	MOVF        FARG_sendSMS_msg+0, 0 
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVF        FARG_sendSMS_msg+1, 0 
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;DazoGSM.c,108 :: 		Delay_ms(1000);
	MOVLW       6
	MOVWF       R11, 0
	MOVLW       19
	MOVWF       R12, 0
	MOVLW       173
	MOVWF       R13, 0
L_sendSMS29:
	DECFSZ      R13, 1, 1
	BRA         L_sendSMS29
	DECFSZ      R12, 1, 1
	BRA         L_sendSMS29
	DECFSZ      R11, 1, 1
	BRA         L_sendSMS29
	NOP
	NOP
;DazoGSM.c,109 :: 		UART1_Write(26);
	MOVLW       26
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;DazoGSM.c,110 :: 		Delay_ms(500);
	MOVLW       3
	MOVWF       R11, 0
	MOVLW       138
	MOVWF       R12, 0
	MOVLW       85
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
;DazoGSM.c,111 :: 		}
L_end_sendSMS:
	RETURN      0
; end of _sendSMS

_detectBO:

;DazoGSM.c,113 :: 		void detectBO(){
;DazoGSM.c,114 :: 		if(PORTB.F4 == 0 && BOSMSSent == 0){
	BTFSC       PORTB+0, 4 
	GOTO        L_detectBO33
	MOVLW       0
	XORWF       _BOSMSSent+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__detectBO48
	MOVLW       0
	XORWF       _BOSMSSent+0, 0 
L__detectBO48:
	BTFSS       STATUS+0, 2 
	GOTO        L_detectBO33
L__detectBO40:
;DazoGSM.c,115 :: 		sendSMS("The power is off");
	MOVLW       ?lstr19_DazoGSM+0
	MOVWF       FARG_sendSMS_msg+0 
	MOVLW       hi_addr(?lstr19_DazoGSM+0)
	MOVWF       FARG_sendSMS_msg+1 
	CALL        _sendSMS+0, 0
;DazoGSM.c,116 :: 		BOSMSSent = 1;
	MOVLW       1
	MOVWF       _BOSMSSent+0 
	MOVLW       0
	MOVWF       _BOSMSSent+1 
;DazoGSM.c,117 :: 		while(PORTB.F4 == 0);
L_detectBO34:
	BTFSC       PORTB+0, 4 
	GOTO        L_detectBO35
	GOTO        L_detectBO34
L_detectBO35:
;DazoGSM.c,118 :: 		if(PORTB.F4 == 1)sendSMS("The power is back");
	BTFSS       PORTB+0, 4 
	GOTO        L_detectBO36
	MOVLW       ?lstr20_DazoGSM+0
	MOVWF       FARG_sendSMS_msg+0 
	MOVLW       hi_addr(?lstr20_DazoGSM+0)
	MOVWF       FARG_sendSMS_msg+1 
	CALL        _sendSMS+0, 0
L_detectBO36:
;DazoGSM.c,119 :: 		}
L_detectBO33:
;DazoGSM.c,120 :: 		if(PORTB.F4 == 1) BOSMSSent = 0;
	BTFSS       PORTB+0, 4 
	GOTO        L_detectBO37
	CLRF        _BOSMSSent+0 
	CLRF        _BOSMSSent+1 
L_detectBO37:
;DazoGSM.c,121 :: 		}
L_end_detectBO:
	RETURN      0
; end of _detectBO

_deleteMsgs:

;DazoGSM.c,123 :: 		void deleteMsgs(){
;DazoGSM.c,124 :: 		sendATCommand("AT+CMGD=1,4\r\n");
	MOVLW       ?lstr21_DazoGSM+0
	MOVWF       FARG_sendATCommand_cmd+0 
	MOVLW       hi_addr(?lstr21_DazoGSM+0)
	MOVWF       FARG_sendATCommand_cmd+1 
	CALL        _sendATCommand+0, 0
;DazoGSM.c,125 :: 		}
L_end_deleteMsgs:
	RETURN      0
; end of _deleteMsgs
