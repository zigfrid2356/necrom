{
   necrom_main.pas
   
   Copyright 2016 Alexandr <Zigfridone@gmail.com>
   
   This program is free software; you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation; either version 2 of the License, or
   (at your option) any later version.
   
   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.
   
   You should have received a copy of the GNU General Public License
   along with this program; if not, write to the Free Software
   Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
   MA 02110-1301, USA.
   
   
}


program necrom_main;

uses sysutils{,linux},crt,windows,dateutils,Zipper;
type
//*****//
necr=record
tower, dungeon, body, warior, work, necropolis:word;
gold, mana:integer;
end;

necr_date=record
n_y:word;
n_m:byte;
n_m_n:string[30];
end;
//*****//
var 
i : word;
menu_key:char;
lang,lang_f: text;
text:array[0..200] of string[100];
lang_s:string[5];
log:string[10];

nc:necr;
nd:necr_date;
function necr_create(command:string):necr;
var
koeff:byte;
begin
if command='easy' then koeff:=1;
if command='normal' then koeff:=2;
if command='yard' then koeff:=3;
necr_create.tower:=1; 
necr_create.dungeon:=1;  
necr_create.body:=0; 
necr_create.warior:=0; 
necr_create.work:=2; 
necr_create.necropolis:=10-koeff; 
necr_create.gold:=10-koeff;  
necr_create.mana:=4-koeff; 
end;

function necr_date_create(command:byte; in_nd:necr_date):necr_date;
//1-create, 2-month+1
begin
if command =1 then begin//1
necr_date_create.n_y:=1300;
necr_date_create.n_m:=1;
necr_date_create.n_m_n:=text[10];
end;//1
if command =2 then begin//2
if in_nd.n_m<10 then in_nd.n_m:=in_nd.n_m+1;
if in_nd.n_m=10 then begin in_nd.n_m:=1; in_nd.n_y:=in_nd.n_y+1; end;
in_nd.n_m_n:=text[in_nd.n_m+9];
necr_date_create:=in_nd;
end;//2
end;

function necr_bild(in_bild:necr;command:byte):necr;
var sc:char;
begin
//1-tower, 2-dungeon, 3-warior, 4-work
ClrScr;
writeln	('1- ',text[38],'2- ',text[39],'3- ',text[41],'4- ',text[40]);
readln(sc);
command:=strtoint(sc);
if command = 1 then begin//1.1
if in_bild.gold>=10 then begin in_bild.tower:=in_bild.tower+1;in_bild.gold:=in_bild.gold-10; end else writeln	(text[7]);

end;//1.1
if command = 2 then begin//2.1
if in_bild.gold>=10 then begin in_bild.dungeon:=in_bild.dungeon+1;in_bild.gold:=in_bild.gold-10; end else writeln	(text[7]);
end;//2.1
if command = 3 then begin//3.1
if (in_bild.body>=1)and(in_bild.gold>=5)and(in_bild.mana>=5)  then begin//3.2
 in_bild.warior:=in_bild.warior+1;
 in_bild.body:=in_bild.body-1; 
 in_bild.gold:= in_bild.gold-5;
 in_bild.mana:= in_bild.mana-5;
 end;//3.2
if in_bild.body<1 then writeln	(text[8]);
if in_bild.gold<5 then writeln	(text[7]);
if in_bild.mana<5 then writeln	(text[9]);
end;//3.1
if command = 4 then begin//4.1
if (in_bild.body>=1)and(in_bild.gold>=3)and(in_bild.mana>=3) then begin//4.2
 in_bild.work:=in_bild.work+1;
 in_bild.body:=in_bild.body-1;
  in_bild.gold:= in_bild.gold-3;
 in_bild.mana:= in_bild.mana-3; 
 end;//4.2
 if in_bild.body<1 then writeln	(text[8]);
if in_bild.gold<3 then writeln	(text[7]);
if in_bild.mana<3 then writeln	(text[9]);
end;//4.1
necr_bild:=in_bild;
readln
end;

function necr_command(in_command:necr; command:byte):necr;
begin
//1-safe, 2-war

necr_command:=in_command;
end;

procedure necr_sound(so:byte);
var
nsi,nsj:word;
fl:boolean;
samplerate:real; // частота сэмпла
wavefrequency:real; // частота волны
wavevolume:real; // громкость волны
period,pi:real;
n,a:real;
begin

nsi:=200;
fl:=true;
if so=1 then begin//0
for nsj:=1 to 100 do begin//0.1
//writeln(nsi);
if (nsi<=350)and(fl=true) then begin//1
sound(nsi);
delay(1);
nosound;
nsi:=nsi+1;
end;//1

if (nsi>=200)and(fl=false) then begin//2
sound(nsi);
delay(1);
nosound;
nsi:=nsi-1;
end;//2
if nsi=350 then fl:=false;
if nsi=200 then fl:=true;

end;//0.1
end;//0

if so=2 then begin//3
for nsj:=1 to 100 do begin//3.1
randomize;
sound(random(350));
delay(100);
nosound;
end;//3.1
end;//3


if so=3 then begin//4
samplerate:=180; // частота сэмпла
wavefrequency:=200; // частота волны
wavevolume:=300; // громкость волны
a:=0;
period:=samplerate / wavefrequency /2; //вычисляем период волны
pi:=3.14; //число pi
n:=0; 

for nsi:=0 to 20 do begin 
a:=a+1;

n:=wavevolume*sin(a*pi / period); //вычисление sine-волны
sound(abs(round(n)));
//writeln(abs(round(n)));
delay(abs(round(n))+100);
nosound;
end;
end;//4
nosound;
end;

procedure main_menu;
begin//0
writeln	(text[1]);
//necr_sound(3);
writeln	(text[6]);
readln();
repeat //begin//1
ClrScr;
writeln	('1- ',text[2]);
writeln	('2- ',text[3]);
writeln	('3- ',text[4]);
writeln	(text[5]);
menu_key:=readkey;
case menu_key of
'1': begin //1.1
nc:=necr_create('normal');
nd:=necr_date_create(1,nd);
menu_key:='0';
	end;//1.1
'2':	begin//1.2
	end;//1.2

'3': begin//1.4
end;//1.4

end;//1

until menu_key='0';

end;//0

procedure necr_info;
begin
ClrScr;
writeln	(text[26],nc.tower,text[34]);
writeln	(text[27],nc.dungeon,text[35]);
writeln	(text[28],nc.gold);
writeln	(text[29],nc.mana);
writeln	(text[30],nc.body,text[36]);
writeln	(text[31],nc.work,text[36]);
writeln	(text[32],nc.warior,text[36]);
writeln	(text[33],nc.necropolis,text[37]);
writeln	(text[6]);
readln;
end;


BEGIN
i:=0;
assign(lang_f,'lang_f');
reset(lang_f);
readln(lang_f,lang_s);
readln(lang_f,log);
close(lang_f);
//if log='full' then log_generate('log_old_generate','lang = '+lang_s);
//if (lang_s<>'w_rus')or (lang_s<>'u_rus')or (lang_s<>'w_eng')or (lang_s<>'u_eng') then begin writeln	('error file lang_f'); exit; end;
//if log='full' then log_generate('log_old_generate','close lang_f');
//if log='full' then log_generate('log_old_generate','start lang'+' '+lang_s);
if lang_s='w_rus' then assign(lang,'res\lang\rus\text_win.lang');
if lang_s='w_eng' then assign(lang,'res\lang\eng\text_win.lang');
if lang_s='u_eng' then assign(lang,'res/lang/eng/text_unix.lang');
if lang_s='u_rus' then assign(lang,'res/lang/rus/text_unix.lang');
//if log='full' then log_generate('log_old_generate','off lang'+' '+lang_s);
reset(lang);
while not eof(lang) do begin
readln(lang,text[i]);
delete(text[i],1,3);
i:=i+1;
end;
close(lang);
main_menu;
//*********************************************************************
repeat //begin//1
ClrScr;
writeln	(text[20],nd.n_m_n,'; ',text[21],inttostr(nd.n_y));
writeln	('1- ',text[4]);
writeln	('2- ',text[22]);
writeln	('3- ',text[23]);
writeln	('4- ',text[24]);
writeln	('5- ',text[25]);
writeln	(text[5]);
menu_key:=readkey;
case menu_key of
'1': begin //1.1
necr_info
	end;//1.1
'2':	begin//1.2
necr_bild(nc,1);
	end;//1.2

'3': begin//1.4
end;//1.4

'4': begin//1.5
end;//1.5

'5': begin//1.6
nd:=necr_date_create(2,nd);
end;//1.6
end;//1	
until menu_key='0';	
	
	
END.

