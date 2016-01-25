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

uses crt;
var i : byte;
procedure main_menu;
begin

repeat begin//1
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
end;
end;//2 
until menu_key='0';

end;
BEGIN
	
	
END.

