
_main:

;MyProjectt.c,33 :: 		void main(){
;MyProjectt.c,35 :: 		TRISB=0x04;
	MOVLW      4
	MOVWF      TRISB+0
;MyProjectt.c,36 :: 		PORTB=0x00;
	CLRF       PORTB+0
;MyProjectt.c,37 :: 		ADCON1 = 0xC0;// All channels Analog, right justified, Fosc/16
	MOVLW      192
	MOVWF      ADCON1+0
;MyProjectt.c,38 :: 		TRISA= 0x03;      //portA is input
	MOVLW      3
	MOVWF      TRISA+0
;MyProjectt.c,40 :: 		Lcd_Init();
	CALL       _Lcd_Init+0
;MyProjectt.c,41 :: 		Lcd_Cmd(_LCD_CLEAR);          // Clear display
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;MyProjectt.c,42 :: 		Lcd_Cmd(_LCD_CURSOR_OFF);     // Cursor off
	MOVLW      12
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;MyProjectt.c,43 :: 		Lcd_Out(1,1,"HELLO");
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr1_MyProjectt+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;MyProjectt.c,44 :: 		msDelay(1000);
	MOVLW      232
	MOVWF      FARG_msDelay_mscnt+0
	MOVLW      3
	MOVWF      FARG_msDelay_mscnt+1
	CALL       _msDelay+0
;MyProjectt.c,45 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;MyProjectt.c,46 :: 		Lcd_Cmd(_LCD_CURSOR_OFF);
	MOVLW      12
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;MyProjectt.c,47 :: 		msDelay(1000);
	MOVLW      232
	MOVWF      FARG_msDelay_mscnt+0
	MOVLW      3
	MOVWF      FARG_msDelay_mscnt+1
	CALL       _msDelay+0
;MyProjectt.c,49 :: 		while(1){
L_main0:
;MyProjectt.c,51 :: 		temp=Distance=moisture=0;
	CLRF       _moisture+0
	CLRF       _moisture+1
	CLRF       _Distance+0
	CLRF       _Distance+1
	CLRF       _temp+0
	CLRF       _temp+1
	CLRF       _temp+2
	CLRF       _temp+3
;MyProjectt.c,52 :: 		for (i =0 ; i<2; i++)
	CLRF       _i+0
	CLRF       _i+1
L_main2:
	MOVLW      128
	XORWF      _i+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main29
	MOVLW      2
	SUBWF      _i+0, 0
L__main29:
	BTFSC      STATUS+0, 0
	GOTO       L_main3
;MyProjectt.c,54 :: 		if (i == 0)
	MOVLW      0
	XORWF      _i+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main30
	MOVLW      0
	XORWF      _i+0, 0
L__main30:
	BTFSS      STATUS+0, 2
	GOTO       L_main5
;MyProjectt.c,56 :: 		read_temp();
	CALL       _read_temp+0
;MyProjectt.c,57 :: 		}
L_main5:
;MyProjectt.c,58 :: 		if(i == 1)
	MOVLW      0
	XORWF      _i+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main31
	MOVLW      1
	XORWF      _i+0, 0
L__main31:
	BTFSS      STATUS+0, 2
	GOTO       L_main6
;MyProjectt.c,60 :: 		check_moisture();
	CALL       _check_moisture+0
;MyProjectt.c,61 :: 		}
L_main6:
;MyProjectt.c,52 :: 		for (i =0 ; i<2; i++)
	INCF       _i+0, 1
	BTFSC      STATUS+0, 2
	INCF       _i+1, 1
;MyProjectt.c,62 :: 		}
	GOTO       L_main2
L_main3:
;MyProjectt.c,66 :: 		measure_distance();
	CALL       _measure_distance+0
;MyProjectt.c,69 :: 		if(20 - Distance > 7)   //check the water tank level
	MOVF       _Distance+0, 0
	SUBLW      20
	MOVWF      R1+0
	MOVF       _Distance+1, 0
	BTFSS      STATUS+0, 0
	ADDLW      1
	CLRF       R1+1
	SUBWF      R1+1, 1
	MOVLW      128
	MOVWF      R0+0
	MOVLW      128
	XORWF      R1+1, 0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main32
	MOVF       R1+0, 0
	SUBLW      7
L__main32:
	BTFSC      STATUS+0, 0
	GOTO       L_main7
;MyProjectt.c,71 :: 		if (temp < 25)      //check the temperature
	MOVLW      0
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVLW      72
	MOVWF      R4+2
	MOVLW      131
	MOVWF      R4+3
	MOVF       _temp+0, 0
	MOVWF      R0+0
	MOVF       _temp+1, 0
	MOVWF      R0+1
	MOVF       _temp+2, 0
	MOVWF      R0+2
	MOVF       _temp+3, 0
	MOVWF      R0+3
	CALL       _Compare_Double+0
	MOVLW      1
	BTFSC      STATUS+0, 0
	MOVLW      0
	MOVWF      R0+0
	MOVF       R0+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_main8
;MyProjectt.c,73 :: 		if (moisture > 150)     //check the moisture value
	MOVF       _moisture+1, 0
	SUBLW      0
	BTFSS      STATUS+0, 2
	GOTO       L__main33
	MOVF       _moisture+0, 0
	SUBLW      150
L__main33:
	BTFSC      STATUS+0, 0
	GOTO       L_main9
;MyProjectt.c,76 :: 		FloatToStr(temp,tempr);
	MOVF       _temp+0, 0
	MOVWF      FARG_FloatToStr_fnum+0
	MOVF       _temp+1, 0
	MOVWF      FARG_FloatToStr_fnum+1
	MOVF       _temp+2, 0
	MOVWF      FARG_FloatToStr_fnum+2
	MOVF       _temp+3, 0
	MOVWF      FARG_FloatToStr_fnum+3
	MOVLW      _tempr+0
	MOVWF      FARG_FloatToStr_str+0
	CALL       _FloatToStr+0
;MyProjectt.c,77 :: 		ltrim(tempr);
	MOVLW      _tempr+0
	MOVWF      FARG_Ltrim_string+0
	CALL       _Ltrim+0
;MyProjectt.c,78 :: 		Lcd_Out(1,1,"Temp");
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr2_MyProjectt+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;MyProjectt.c,79 :: 		Lcd_Out(2,1,tempr);
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      _tempr+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;MyProjectt.c,80 :: 		msDelay(5000);
	MOVLW      136
	MOVWF      FARG_msDelay_mscnt+0
	MOVLW      19
	MOVWF      FARG_msDelay_mscnt+1
	CALL       _msDelay+0
;MyProjectt.c,81 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;MyProjectt.c,82 :: 		Lcd_Cmd(_LCD_CURSOR_OFF);
	MOVLW      12
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;MyProjectt.c,85 :: 		IntToStr(moisture,txt);
	MOVF       _moisture+0, 0
	MOVWF      FARG_IntToStr_input+0
	MOVF       _moisture+1, 0
	MOVWF      FARG_IntToStr_input+1
	MOVLW      _txt+0
	MOVWF      FARG_IntToStr_output+0
	CALL       _IntToStr+0
;MyProjectt.c,86 :: 		ltrim(txt);
	MOVLW      _txt+0
	MOVWF      FARG_Ltrim_string+0
	CALL       _Ltrim+0
;MyProjectt.c,87 :: 		Lcd_Out(1,1,"Moisture: ");
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr3_MyProjectt+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;MyProjectt.c,88 :: 		Lcd_Out(2,1,txt);
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      _txt+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;MyProjectt.c,89 :: 		msDelay(5000);
	MOVLW      136
	MOVWF      FARG_msDelay_mscnt+0
	MOVLW      19
	MOVWF      FARG_msDelay_mscnt+1
	CALL       _msDelay+0
;MyProjectt.c,90 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;MyProjectt.c,91 :: 		Lcd_Cmd(_LCD_CURSOR_OFF);
	MOVLW      12
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;MyProjectt.c,93 :: 		IntToStr(Distance,txt_dist);
	MOVF       _Distance+0, 0
	MOVWF      FARG_IntToStr_input+0
	MOVF       _Distance+1, 0
	MOVWF      FARG_IntToStr_input+1
	MOVLW      _txt_dist+0
	MOVWF      FARG_IntToStr_output+0
	CALL       _IntToStr+0
;MyProjectt.c,94 :: 		ltrim(txt_dist);
	MOVLW      _txt_dist+0
	MOVWF      FARG_Ltrim_string+0
	CALL       _Ltrim+0
;MyProjectt.c,95 :: 		Lcd_Out(1,1,"DISTANCE=");
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr4_MyProjectt+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;MyProjectt.c,96 :: 		Lcd_Out(2,1,txt_dist);
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      _txt_dist+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;MyProjectt.c,97 :: 		msDelay(5000);
	MOVLW      136
	MOVWF      FARG_msDelay_mscnt+0
	MOVLW      19
	MOVWF      FARG_msDelay_mscnt+1
	CALL       _msDelay+0
;MyProjectt.c,98 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;MyProjectt.c,99 :: 		Lcd_Cmd(_LCD_CURSOR_OFF);
	MOVLW      12
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;MyProjectt.c,101 :: 		PORTB = PORTB | 0x08; //turn on the water pump on RB3
	BSF        PORTB+0, 3
;MyProjectt.c,102 :: 		msDelay(7000);
	MOVLW      88
	MOVWF      FARG_msDelay_mscnt+0
	MOVLW      27
	MOVWF      FARG_msDelay_mscnt+1
	CALL       _msDelay+0
;MyProjectt.c,104 :: 		PORTB = PORTB & 0xF7; //turn off the water pump
	MOVLW      247
	ANDWF      PORTB+0, 1
;MyProjectt.c,105 :: 		continue;
	GOTO       L_main0
;MyProjectt.c,106 :: 		}
L_main9:
;MyProjectt.c,107 :: 		}
L_main8:
;MyProjectt.c,108 :: 		}
	GOTO       L_main10
L_main7:
;MyProjectt.c,113 :: 		IntToStr(temp,tempr);
	MOVF       _temp+0, 0
	MOVWF      R0+0
	MOVF       _temp+1, 0
	MOVWF      R0+1
	MOVF       _temp+2, 0
	MOVWF      R0+2
	MOVF       _temp+3, 0
	MOVWF      R0+3
	CALL       _double2int+0
	MOVF       R0+0, 0
	MOVWF      FARG_IntToStr_input+0
	MOVF       R0+1, 0
	MOVWF      FARG_IntToStr_input+1
	MOVLW      _tempr+0
	MOVWF      FARG_IntToStr_output+0
	CALL       _IntToStr+0
;MyProjectt.c,114 :: 		ltrim(tempr);
	MOVLW      _tempr+0
	MOVWF      FARG_Ltrim_string+0
	CALL       _Ltrim+0
;MyProjectt.c,115 :: 		Lcd_Out(1,1,"Temp");
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr5_MyProjectt+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;MyProjectt.c,116 :: 		Lcd_Out(2,1,tempr);
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      _tempr+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;MyProjectt.c,117 :: 		msDelay(5000);
	MOVLW      136
	MOVWF      FARG_msDelay_mscnt+0
	MOVLW      19
	MOVWF      FARG_msDelay_mscnt+1
	CALL       _msDelay+0
;MyProjectt.c,118 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;MyProjectt.c,119 :: 		Lcd_Cmd(_LCD_CURSOR_OFF);
	MOVLW      12
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;MyProjectt.c,121 :: 		IntToStr(moisture,txt);
	MOVF       _moisture+0, 0
	MOVWF      FARG_IntToStr_input+0
	MOVF       _moisture+1, 0
	MOVWF      FARG_IntToStr_input+1
	MOVLW      _txt+0
	MOVWF      FARG_IntToStr_output+0
	CALL       _IntToStr+0
;MyProjectt.c,122 :: 		ltrim(txt);
	MOVLW      _txt+0
	MOVWF      FARG_Ltrim_string+0
	CALL       _Ltrim+0
;MyProjectt.c,123 :: 		Lcd_Out(1,1,"Moisture: ");
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr6_MyProjectt+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;MyProjectt.c,124 :: 		Lcd_Out(2,1,txt);
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      _txt+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;MyProjectt.c,125 :: 		msDelay(5000);
	MOVLW      136
	MOVWF      FARG_msDelay_mscnt+0
	MOVLW      19
	MOVWF      FARG_msDelay_mscnt+1
	CALL       _msDelay+0
;MyProjectt.c,126 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;MyProjectt.c,127 :: 		Lcd_Cmd(_LCD_CURSOR_OFF);
	MOVLW      12
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;MyProjectt.c,129 :: 		IntToStr(Distance,txt_dist);
	MOVF       _Distance+0, 0
	MOVWF      FARG_IntToStr_input+0
	MOVF       _Distance+1, 0
	MOVWF      FARG_IntToStr_input+1
	MOVLW      _txt_dist+0
	MOVWF      FARG_IntToStr_output+0
	CALL       _IntToStr+0
;MyProjectt.c,130 :: 		ltrim(txt_dist);
	MOVLW      _txt_dist+0
	MOVWF      FARG_Ltrim_string+0
	CALL       _Ltrim+0
;MyProjectt.c,131 :: 		Lcd_Out(1,1,"DISTANCE=");
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr7_MyProjectt+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;MyProjectt.c,132 :: 		Lcd_Out(2,1,txt_dist);
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      _txt_dist+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;MyProjectt.c,133 :: 		msDelay(5000);
	MOVLW      136
	MOVWF      FARG_msDelay_mscnt+0
	MOVLW      19
	MOVWF      FARG_msDelay_mscnt+1
	CALL       _msDelay+0
;MyProjectt.c,134 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;MyProjectt.c,135 :: 		Lcd_Cmd(_LCD_CURSOR_OFF);
	MOVLW      12
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;MyProjectt.c,137 :: 		PORTB = PORTB & 0xF7; //turn the water pump off
	MOVLW      247
	ANDWF      PORTB+0, 1
;MyProjectt.c,138 :: 		PORTB = PORTB | 0x80; //turn the buzzer on (RB7)
	BSF        PORTB+0, 7
;MyProjectt.c,139 :: 		msDelay(2000);
	MOVLW      208
	MOVWF      FARG_msDelay_mscnt+0
	MOVLW      7
	MOVWF      FARG_msDelay_mscnt+1
	CALL       _msDelay+0
;MyProjectt.c,140 :: 		continue;
	GOTO       L_main0
;MyProjectt.c,141 :: 		}
L_main10:
;MyProjectt.c,142 :: 		}
	GOTO       L_main0
;MyProjectt.c,144 :: 		}
L_end_main:
	GOTO       $+0
; end of _main

_ADC_read1:

;MyProjectt.c,152 :: 		unsigned int ADC_read1(){
;MyProjectt.c,155 :: 		msDelay(50);
	MOVLW      50
	MOVWF      FARG_msDelay_mscnt+0
	MOVLW      0
	MOVWF      FARG_msDelay_mscnt+1
	CALL       _msDelay+0
;MyProjectt.c,156 :: 		ADCON0 = ADCON0 & 0xC7;
	MOVLW      199
	ANDWF      ADCON0+0, 1
;MyProjectt.c,157 :: 		msDelay(50);
	MOVLW      50
	MOVWF      FARG_msDelay_mscnt+0
	MOVLW      0
	MOVWF      FARG_msDelay_mscnt+1
	CALL       _msDelay+0
;MyProjectt.c,158 :: 		ADCON0 = 0x49;// Power up, don't GO, channel AN1, Fosc/16 (500KHz)
	MOVLW      73
	MOVWF      ADCON0+0
;MyProjectt.c,159 :: 		ADCON0 = ADCON0 | 0x04; // GO ;
	BSF        ADCON0+0, 2
;MyProjectt.c,160 :: 		while(ADCON0 & 0x04);      // until finish reading
L_ADC_read111:
	BTFSS      ADCON0+0, 2
	GOTO       L_ADC_read112
	GOTO       L_ADC_read111
L_ADC_read112:
;MyProjectt.c,162 :: 		return((ADRESH<<8)|ADRESL);  //
	MOVF       ADRESH+0, 0
	MOVWF      R0+1
	CLRF       R0+0
	MOVF       ADRESL+0, 0
	IORWF      R0+0, 1
	MOVLW      0
	IORWF      R0+1, 1
;MyProjectt.c,164 :: 		}
L_end_ADC_read1:
	RETURN
; end of _ADC_read1

_ADC_read2:

;MyProjectt.c,166 :: 		unsigned int ADC_read2(){
;MyProjectt.c,169 :: 		msDelay(50);
	MOVLW      50
	MOVWF      FARG_msDelay_mscnt+0
	MOVLW      0
	MOVWF      FARG_msDelay_mscnt+1
	CALL       _msDelay+0
;MyProjectt.c,170 :: 		ADCON0 = ADCON0 & 0xC7;
	MOVLW      199
	ANDWF      ADCON0+0, 1
;MyProjectt.c,171 :: 		msDelay(50);
	MOVLW      50
	MOVWF      FARG_msDelay_mscnt+0
	MOVLW      0
	MOVWF      FARG_msDelay_mscnt+1
	CALL       _msDelay+0
;MyProjectt.c,172 :: 		ADCON0 = 0x41;// Power up, don't GO, channel AN0, Fosc/16 (500KHz)
	MOVLW      65
	MOVWF      ADCON0+0
;MyProjectt.c,173 :: 		ADCON0 = ADCON0 | 0x04; // GO ;
	BSF        ADCON0+0, 2
;MyProjectt.c,174 :: 		while(ADCON0 & 0x04);      // until finish reading
L_ADC_read213:
	BTFSS      ADCON0+0, 2
	GOTO       L_ADC_read214
	GOTO       L_ADC_read213
L_ADC_read214:
;MyProjectt.c,176 :: 		return((ADRESH<<8)|ADRESL);  //
	MOVF       ADRESH+0, 0
	MOVWF      R0+1
	CLRF       R0+0
	MOVF       ADRESL+0, 0
	IORWF      R0+0, 1
	MOVLW      0
	IORWF      R0+1, 1
;MyProjectt.c,178 :: 		}
L_end_ADC_read2:
	RETURN
; end of _ADC_read2

_check_moisture:

;MyProjectt.c,181 :: 		void check_moisture(){
;MyProjectt.c,182 :: 		moisture=ADC_read1();
	CALL       _ADC_read1+0
	MOVF       R0+0, 0
	MOVWF      _moisture+0
	MOVF       R0+1, 0
	MOVWF      _moisture+1
;MyProjectt.c,183 :: 		}
L_end_check_moisture:
	RETURN
; end of _check_moisture

_measure_distance:

;MyProjectt.c,184 :: 		void measure_distance(){
;MyProjectt.c,185 :: 		TMR1H=0;
	CLRF       TMR1H+0
;MyProjectt.c,186 :: 		TMR1L=0;
	CLRF       TMR1L+0
;MyProjectt.c,188 :: 		PORTB =0x02; // Trigger is High
	MOVLW      2
	MOVWF      PORTB+0
;MyProjectt.c,189 :: 		usDelay(10);
	MOVLW      10
	MOVWF      FARG_usDelay_mscnt+0
	MOVLW      0
	MOVWF      FARG_usDelay_mscnt+1
	CALL       _usDelay+0
;MyProjectt.c,190 :: 		PORTB =0x00; // Trigger is Low
	CLRF       PORTB+0
;MyProjectt.c,192 :: 		while (!(PORTB&0x04));
L_measure_distance15:
	BTFSC      PORTB+0, 2
	GOTO       L_measure_distance16
	GOTO       L_measure_distance15
L_measure_distance16:
;MyProjectt.c,194 :: 		T1CON= T1CON | 0x01;
	BSF        T1CON+0, 0
;MyProjectt.c,196 :: 		while ((PORTB.RB2));
L_measure_distance17:
	BTFSS      PORTB+0, 2
	GOTO       L_measure_distance18
	GOTO       L_measure_distance17
L_measure_distance18:
;MyProjectt.c,197 :: 		T1CON = T1CON & 0xFE;
	MOVLW      254
	ANDWF      T1CON+0, 1
;MyProjectt.c,200 :: 		Distance = (TMR1L | (TMR1H << 8));
	MOVF       TMR1H+0, 0
	MOVWF      R0+1
	CLRF       R0+0
	MOVF       TMR1L+0, 0
	IORWF      R0+0, 1
	MOVLW      0
	IORWF      R0+1, 1
	MOVF       R0+0, 0
	MOVWF      _Distance+0
	MOVF       R0+1, 0
	MOVWF      _Distance+1
;MyProjectt.c,202 :: 		Distance = (Distance / 58.82)/2;
	CALL       _int2double+0
	MOVLW      174
	MOVWF      R4+0
	MOVLW      71
	MOVWF      R4+1
	MOVLW      107
	MOVWF      R4+2
	MOVLW      132
	MOVWF      R4+3
	CALL       _Div_32x32_FP+0
	MOVLW      0
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVLW      0
	MOVWF      R4+2
	MOVLW      128
	MOVWF      R4+3
	CALL       _Div_32x32_FP+0
	CALL       _double2int+0
	MOVF       R0+0, 0
	MOVWF      _Distance+0
	MOVF       R0+1, 0
	MOVWF      _Distance+1
;MyProjectt.c,204 :: 		}
L_end_measure_distance:
	RETURN
; end of _measure_distance

_read_temp:

;MyProjectt.c,205 :: 		void read_temp(){
;MyProjectt.c,206 :: 		temp=ADC_read2();
	CALL       _ADC_read2+0
	CALL       _word2double+0
	MOVF       R0+0, 0
	MOVWF      _temp+0
	MOVF       R0+1, 0
	MOVWF      _temp+1
	MOVF       R0+2, 0
	MOVWF      _temp+2
	MOVF       R0+3, 0
	MOVWF      _temp+3
;MyProjectt.c,207 :: 		temp=((temp*4.88)/10)+1;
	MOVLW      246
	MOVWF      R4+0
	MOVLW      40
	MOVWF      R4+1
	MOVLW      28
	MOVWF      R4+2
	MOVLW      129
	MOVWF      R4+3
	CALL       _Mul_32x32_FP+0
	MOVLW      0
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVLW      32
	MOVWF      R4+2
	MOVLW      130
	MOVWF      R4+3
	CALL       _Div_32x32_FP+0
	MOVLW      0
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVLW      0
	MOVWF      R4+2
	MOVLW      127
	MOVWF      R4+3
	CALL       _Add_32x32_FP+0
	MOVF       R0+0, 0
	MOVWF      _temp+0
	MOVF       R0+1, 0
	MOVWF      _temp+1
	MOVF       R0+2, 0
	MOVWF      _temp+2
	MOVF       R0+3, 0
	MOVWF      _temp+3
;MyProjectt.c,209 :: 		}
L_end_read_temp:
	RETURN
; end of _read_temp

_msDelay:

;MyProjectt.c,210 :: 		void msDelay(unsigned int mscnt) {
;MyProjectt.c,213 :: 		for (ms = 0; ms < mscnt; ms++) {
	CLRF       R1+0
	CLRF       R1+1
L_msDelay19:
	MOVF       FARG_msDelay_mscnt+1, 0
	SUBWF      R1+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__msDelay40
	MOVF       FARG_msDelay_mscnt+0, 0
	SUBWF      R1+0, 0
L__msDelay40:
	BTFSC      STATUS+0, 0
	GOTO       L_msDelay20
;MyProjectt.c,214 :: 		for (cnt = 0; cnt < 155; cnt++);//1ms
	CLRF       R3+0
	CLRF       R3+1
L_msDelay22:
	MOVLW      0
	SUBWF      R3+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__msDelay41
	MOVLW      155
	SUBWF      R3+0, 0
L__msDelay41:
	BTFSC      STATUS+0, 0
	GOTO       L_msDelay23
	INCF       R3+0, 1
	BTFSC      STATUS+0, 2
	INCF       R3+1, 1
	GOTO       L_msDelay22
L_msDelay23:
;MyProjectt.c,213 :: 		for (ms = 0; ms < mscnt; ms++) {
	INCF       R1+0, 1
	BTFSC      STATUS+0, 2
	INCF       R1+1, 1
;MyProjectt.c,215 :: 		}
	GOTO       L_msDelay19
L_msDelay20:
;MyProjectt.c,216 :: 		}
L_end_msDelay:
	RETURN
; end of _msDelay

_usDelay:

;MyProjectt.c,220 :: 		void usDelay(unsigned int uscnt) {
;MyProjectt.c,222 :: 		for (us = 0; us < uscnt; us++) {
	CLRF       R1+0
	CLRF       R1+1
L_usDelay25:
	MOVF       FARG_usDelay_uscnt+1, 0
	SUBWF      R1+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__usDelay43
	MOVF       FARG_usDelay_uscnt+0, 0
	SUBWF      R1+0, 0
L__usDelay43:
	BTFSC      STATUS+0, 0
	GOTO       L_usDelay26
;MyProjectt.c,223 :: 		asm NOP; // Takes 0.5us
	NOP
;MyProjectt.c,224 :: 		asm NOP; // Takes 0.5us
	NOP
;MyProjectt.c,222 :: 		for (us = 0; us < uscnt; us++) {
	INCF       R1+0, 1
	BTFSC      STATUS+0, 2
	INCF       R1+1, 1
;MyProjectt.c,225 :: 		}
	GOTO       L_usDelay25
L_usDelay26:
;MyProjectt.c,226 :: 		}
L_end_usDelay:
	RETURN
; end of _usDelay
