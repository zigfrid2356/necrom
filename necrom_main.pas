{
   necrom_main.pas
   
   Copyright 2016 Alexandr <Alexandr@UNIT-07>
   
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
var 
i : word;
menu_key:char;
lang,lang_f: text;
text:array[0..200] of string[100];
lang_s:string[5];
log:string[10];
procedure main_menu;
begin//0

repeat //begin//1
ClrScr;
writeln	('1- ',text[10]);
writeln	('2- ',text[9]);
writeln	('3- ',text[17]);
menu_key:=readkey;
case menu_key of
'1': begin //1.1
	end;//1.1
'2':	begin//1.2
	end;//1.2

'3': begin//1.4
end;//1.4

end;//1

until menu_key='0';

end;//0
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
	
END.

