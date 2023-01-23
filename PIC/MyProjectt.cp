#line 1 "C:/Users/20190408/Documents/MyProjectt.c"

sbit LCD_RS at RD0_bit;
sbit LCD_EN at RD1_bit;
sbit LCD_D7 at RD7_bit;
sbit LCD_D6 at RD6_bit;
sbit LCD_D5 at RD5_bit;
sbit LCD_D4 at RD4_bit;


sbit LCD_RS_Direction at TRISD0_bit;
sbit LCD_EN_Direction at TRISD1_bit;
sbit LCD_D7_Direction at TRISD7_bit;
sbit LCD_D6_Direction at TRISD6_bit;
sbit LCD_D5_Direction at TRISD5_bit;
sbit LCD_D4_Direction at TRISD4_bit;

void check_moisture();

unsigned int ADC_read1(void);
unsigned int ADC_read2(void);
void read_temp(void);
void measure_distance();
void msDelay (unsigned int mscnt);
void usDelay(unsigned int mscnt);

float temp;
int Distance;
char txt_dist[7];
char tempr[4];
unsigned int moisture;
char txt[7];
int i;
void main(){

 TRISB=0x04;
 PORTB=0x00;
 ADCON1 = 0xC0;
 TRISA= 0x03;

 Lcd_Init();
 Lcd_Cmd(_LCD_CLEAR);
 Lcd_Cmd(_LCD_CURSOR_OFF);
 Lcd_Out(1,1,"HELLO");
 msDelay(1000);
 Lcd_Cmd(_LCD_CLEAR);
 Lcd_Cmd(_LCD_CURSOR_OFF);
 msDelay(1000);

while(1){

 temp=Distance=moisture=0;
 for (i =0 ; i<2; i++)
 {
 if (i == 0)
 {
 read_temp();
 }
 if(i == 1)
 {
 check_moisture();
 }
 }



 measure_distance();


 if(20 - Distance > 7)
 {
 if (temp < 25)
 {
 if (moisture > 150)
 {

 FloatToStr(temp,tempr);
 ltrim(tempr);
 Lcd_Out(1,1,"Temp");
 Lcd_Out(2,1,tempr);
 msDelay(5000);
 Lcd_Cmd(_LCD_CLEAR);
 Lcd_Cmd(_LCD_CURSOR_OFF);


 IntToStr(moisture,txt);
 ltrim(txt);
 Lcd_Out(1,1,"Moisture: ");
 Lcd_Out(2,1,txt);
 msDelay(5000);
 Lcd_Cmd(_LCD_CLEAR);
 Lcd_Cmd(_LCD_CURSOR_OFF);

 IntToStr(Distance,txt_dist);
 ltrim(txt_dist);
 Lcd_Out(1,1,"DISTANCE=");
 Lcd_Out(2,1,txt_dist);
 msDelay(5000);
 Lcd_Cmd(_LCD_CLEAR);
 Lcd_Cmd(_LCD_CURSOR_OFF);

 PORTB = PORTB | 0x08;
 msDelay(7000);

 PORTB = PORTB & 0xF7;
 continue;
 }
 }
 }

 else
 {

 IntToStr(temp,tempr);
 ltrim(tempr);
 Lcd_Out(1,1,"Temp");
 Lcd_Out(2,1,tempr);
 msDelay(5000);
 Lcd_Cmd(_LCD_CLEAR);
 Lcd_Cmd(_LCD_CURSOR_OFF);

 IntToStr(moisture,txt);
 ltrim(txt);
 Lcd_Out(1,1,"Moisture: ");
 Lcd_Out(2,1,txt);
 msDelay(5000);
 Lcd_Cmd(_LCD_CLEAR);
 Lcd_Cmd(_LCD_CURSOR_OFF);

 IntToStr(Distance,txt_dist);
 ltrim(txt_dist);
 Lcd_Out(1,1,"DISTANCE=");
 Lcd_Out(2,1,txt_dist);
 msDelay(5000);
 Lcd_Cmd(_LCD_CLEAR);
 Lcd_Cmd(_LCD_CURSOR_OFF);

 PORTB = PORTB & 0xF7;
 PORTB = PORTB | 0x80;
 msDelay(2000);
 continue;
 }
}

}







unsigned int ADC_read1(){
#line 155 "C:/Users/20190408/Documents/MyProjectt.c"
 msDelay(50);
 ADCON0 = ADCON0 & 0xC7;
 msDelay(50);
 ADCON0 = 0x49;
 ADCON0 = ADCON0 | 0x04;
 while(ADCON0 & 0x04);

 return((ADRESH<<8)|ADRESL);

}

unsigned int ADC_read2(){
#line 169 "C:/Users/20190408/Documents/MyProjectt.c"
msDelay(50);
 ADCON0 = ADCON0 & 0xC7;
 msDelay(50);
ADCON0 = 0x41;
 ADCON0 = ADCON0 | 0x04;
 while(ADCON0 & 0x04);

 return((ADRESH<<8)|ADRESL);

}


void check_moisture(){
moisture=ADC_read1();
}
void measure_distance(){
 TMR1H=0;
TMR1L=0;

PORTB =0x02;
usDelay(10);
PORTB =0x00;

while (!(PORTB&0x04));

 T1CON= T1CON | 0x01;

while ((PORTB.RB2));
 T1CON = T1CON & 0xFE;


Distance = (TMR1L | (TMR1H << 8));

Distance = (Distance / 58.82)/2;

}
void read_temp(){
 temp=ADC_read2();
 temp=((temp*4.88)/10)+1;

}
void msDelay(unsigned int mscnt) {
 unsigned int ms;
 unsigned int cnt;
 for (ms = 0; ms < mscnt; ms++) {
 for (cnt = 0; cnt < 155; cnt++);
 }
}



void usDelay(unsigned int uscnt) {
 unsigned int us;
 for (us = 0; us < uscnt; us++) {
 asm NOP;
 asm NOP;
 }
}
