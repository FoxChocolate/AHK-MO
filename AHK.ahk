#IfWinActive GTA:SA:MP
#IfWinActive ahk_group Game
#ErrorStdOut
#SingleInstance Force
GroupAdd, Game, GTA:SA:MP
GroupAdd, Game, MTA: San Andreas
GroupAdd, Game, Multi Theft Auto
GroupAdd, Game, GTA: San Andreas
#ErrorStdOut
#include SAMP.ahk



Utf8ToAnsi(ByRef Utf8String, CodePage = 1251)
{
    If (NumGet(Utf8String) & 0xFFFFFF) = 0xBFBBEF
        BOM = 3
    Else
        BOM = 0

    UniSize := DllCall("MultiByteToWideChar", "UInt", 65001, "UInt", 0
                    , "UInt", &Utf8String + BOM, "Int", -1
                    , "Int", 0, "Int", 0)
    VarSetCapacity(UniBuf, UniSize * 2)
    DllCall("MultiByteToWideChar", "UInt", 65001, "UInt", 0
                    , "UInt", &Utf8String + BOM, "Int", -1
                    , "UInt", &UniBuf, "Int", UniSize)

    AnsiSize := DllCall("WideCharToMultiByte", "UInt", CodePage, "UInt", 0
                    , "UInt", &UniBuf, "Int", -1
                    , "Int", 0, "Int", 0
                    , "Int", 0, "Int", 0)
    VarSetCapacity(AnsiString, AnsiSize)
    DllCall("WideCharToMultiByte", "UInt", CodePage, "UInt", 0
                    , "UInt", &UniBuf, "Int", -1
                    , "Str", AnsiString, "Int", AnsiSize
                    , "Int", 0, "Int", 0)
    Return AnsiString
}
WM_HELP(){
    IniRead, vupd, %a_temp%/verahk.ini, UPD, v
    IniRead, desupd, %a_temp%/verahk.ini, UPD, des
    desupd := Utf8ToAnsi(desupd)
    IniRead, updupd, %a_temp%/verahk.ini, UPD, upd
    updupd := Utf8ToAnsi(updupd)
    msgbox, , ������ ��������� ������ %vupd%, %updupd%
    return
}

OnMessage(0x53, "WM_HELP")
Gui +OwnDialogs

SplashTextOn, , 60,��������������, ������ �������. ��������..`n��������� ������� ����������.
URLDownloadToFile, %downllen%, %a_temp%/verahk.ini
IniRead, buildupd, %a_temp%/verahk.ini, UPD, build
if buildupd =
{
    SplashTextOn, , 60,��������������, ������ �������. ��������..`n������. ��� ����� � ��������.
    sleep, 2000
}
if buildupd > % buildscr
{
    IniRead, vupd, %a_temp%/verahk.ini, UPD, v
    SplashTextOn, , 60,��������������, ������ �������. ��������..`n���������� ���������� �� ������ %vupd%!
    sleep, 2000
    IniRead, desupd, %a_temp%/verahk.ini, UPD, des
    desupd := Utf8ToAnsi(desupd)
    IniRead, updupd, %a_temp%/verahk.ini, UPD, upd
    updupd := Utf8ToAnsi(updupd)
    SplashTextoff
    msgbox, 16384, ���������� ������� �� ������ %vupd%, %desupd%
    IfMsgBox OK
    {
        msgbox, 1, ���������� ������� �� ������ %vupd%, ������ �� �� ����������?
        IfMsgBox OK
        {
            put2 := % A_ScriptFullPath
            RegWrite, REG_SZ, HKEY_CURRENT_USER, Software\SAMP ,put2 , % put2
            SplashTextOn, , 60,��������������, ����������. ��������..`n��������� ������ �� ������ %vupd%!
            URLDownloadToFile, %downlurl%, %a_temp%/updt.exe
            sleep, 1000
            run, %a_temp%/updt.exe
            exitapp
        }
    }
}
SplashTextoff




DIR = OptionAHK
FileCreateDir, %DIR%

IfNotExist, %DIR%\*.ini
{
    SplashTextOn, , 60,AHK by FOX,���������� ��������`n��� ��������� ������ ������...
    UrlDownloadToFile, https://www.dropbox.com/s/ue8derksy8hhefq/info.ini?dl=1, %DIR%\info.ini 
    UrlDownloadToFile, https://www.dropbox.com/s/xz6gounw8gmzyi8/blacklist.txt?dl=1, %DIR%\blacklist.txt
    SplashTextoff
}

;ini
IniRead, rang, OptionAHK/info.ini,INFO,rang
IniRead, grav, OptionAHK/info.ini,INFO,grav
IniRead, tag1, OptionAHK/info.ini,INFO,tag1
IniRead, tag2, OptionAHK/info.ini,INFO,tag2
IniRead, sex, OptionAHK/info.ini,INFO,sex
IniRead, army, OptionAHK/info.ini,INFO,army
IniRead, number, OptionAHK/info.ini,INFO,number
IniRead, drang, OptionAHK/info.ini,INFO,drang
IniRead, musurl, OptionAHK/info.ini,INFO,musurl

SetTimer, Chat, 100
EngineState := false
SetTimer, RPEngine, 500
SetTimer, RadioAD, 600000

RadioAD:
Random, randt, 1, 6
if (randt = 1) {
addChatMessageEx("48D1CC", "��� - AHK: {FFFFFF}��� ��������� AHK ����������� �������: {FF0000}F12")
}
if (randt = 2) {
addChatMessageEx("48D1CC", "��� - AHK: {FFFFFF}����������� �������� ����������, ��������� �������!")
}
if (randt = 3) {
addChatMessageEx("48D1CC", "��� - AHK: {FFFFFF}195.000 ������ - ��������� ����� ����� ���, ���� �������")
}
if (randt = 4) {
addChatMessageEx("48D1CC", "��� - AHK: {FFFFFF}����������� �������� ����������, ��������� �������!")
}
return

RPEngine:
if (isPlayerDriver()) {
    if (getVehicleEngineState() == 1 and EngineState = false) {
	if sex = M
	{
        	SendChat("/me ������� ���� � ����� ��������� � ����� " getVehicleModelName())
        }
	if sex = F
	{
		SendChat("/me �������� ���� � ����� ��������� � ������ " getVehicleModelName())
	}
	EngineState := true
    }else if (getVehicleEngineState() == 0 and EngineState = true) {
	if sex = M
	{
        	SendChat("/me �������� " getVehicleModelName() ", ����� ������� ����� �� ����� ���������")
        }
	if sex = F
	{
		SendChat("/me ��������� " getVehicleModelName() ", ����� �������� ����� �� ����� ���������")
	}
	EngineState := false
    }
}
Return


chat:
chat=%A_MyDocuments%/GTA San Andreas User Files/SAMP/chatlog.txt 
FileRead, chatlog, % chat 

if (RegExMatch(chatlog, "\]\s+����� �� ������� � ����� �����������"))
{
	save(chatlog)
	addChatMessageEx("48D1CC", "{48D1CC}��� - AHK: {FFFFFF}����� �� ������� � ����� �����������")
	reload
}
if (RegExMatch(chatlog, "\]\s+��� �������� �������"))
{
	save(chatlog)
	addChatMessageEx("48D1CC", "{48D1CC}��� - AHK: {FFFFFF}��� �������� �������")
	reload
}
if (RegExMatch(chatlog, "\]\s+������ ������ ���"))
{
	save(chatlog)
	addChatMessageEx("48D1CC", "{48D1CC}��� - AHK: {FFFFFF}������ ������ ���")
	reload
} 
if (RegExMatch(chatlog, "\]\s+�� �� ��������� ������������ ������������ ��� ���������� �������"))
{
	save(chatlog)
	addChatMessageEx("48D1CC", "{48D1CC}��� - AHK: {FFFFFF}�� �� ��������� ������������ ������������ ��� ���������� �������")
	reload
}
if (RegExMatch(chatlog, "\]\s+��� ���������� ������ �������"))
{
	save(chatlog)
	addChatMessageEx("48D1CC", "{48D1CC}��� - AHK: {FFFFFF}��� ���������� ������ �������")
	reload
}
if (RegExMatch(chatlog, "\]\s+�� ������������ �������. �������� ��������� �� 60 ������"))
{
	save(chatlog)
	if sex = M
	{
		RPName:=RegExReplace(getUsername(), "_", " ")
		SendChat("/do ������� � ������ ������� � ����� � " RPName ".")
		SendChat("/me ������ ������� �� ������� ������� ����, ����� ����������� �")
	}
	if sex = F
	{
		RPName:=RegExReplace(getUsername(), "_", " ")
		SendChat("/do ������� � ������ ������� � ����� � " RPName ".")
		SendChat("/me ������� ������� �� ������� ������� ����, ����� ������������ �")
	}
	reload
}
if (RegExMatch(chatlog, "\]\s+�� ������ �����. ����� � �����, ������� {FFCD00}/end"))
{
	save(chatlog)
	if sex = M
	{
		RPName:=RegExReplace(getUsername(), "_", " ")
		SendChat("/do ����� � ����� ������� � ����� � " RPName ".")
		SendChat("/me ������ ����� �� ������ ������� ����, ����� ����� �� ���� �����")
		SendChat("/do ����� �� ���� � " RPname ".")
	}
	if sex = F
	{
		RPName:=RegExReplace(getUsername(), "_", " ")
		SendChat("/do ����� � ����� ������� � ����� � " RPName ".")
		SendChat("/me ������� ����� �� ������ ������� ����, ����� ������ �� ���� �����")
		SendChat("/do ����� �� ���� � " RPname ".")
	}
	reload
}
if (RegExMatch(chatlog, "\]\s+������� ��������"))
{
	save(chatlog)
	if sex = M
	{
		RPName:=RegExReplace(getUsername(), "_", " ")
		SendChat("/do ������� � ����� ������� ���� � " RPName ".")
		SendChat("/me ������ ������� �� ������ ������� ����, ����� �������� ��� � ����� �����")
	}
	if sex = F
	{
		RPName:=RegExReplace(getUsername(), "_", " ")
		SendChat("/do ������� � ����� ������� ���� � " RPName ".")
		SendChat("/me ������� ������� �� ������ ������� ����, ����� ��������� ��� � ������ �����")
	}
	reload
}
if (RegExMatch(chatlog, "\]\s+�� �������� ������� ������"))
{
	save(chatlog)
	if sex = M
	{
		RPname:=RegExReplace(getUsername(), "_", " ")
		SendChat("/do ������ �� ����� � " RPname ".")
		SendChat("/me ���� ������ � ��������� ���, ������ ����� ������")
		SendChat("/me ������� ����� ����� ������")
	}
	if sex = F
	{
		RPname:=RegExReplace(getUsername(), "_", " ")
		SendChat("/do ������ �� ����� � " RPname ".")
		SendChat("/me ����� ������ � ���������� ���, ������� ����� ������")
		SendChat("/me �������� ����� ����� ������")
	}
	reload
}
if (RegExMatch(chatlog, "\]\s+������� �������"))
{
	save(chatlog)
	if sex = M
	{
		RPname:=RegExReplace(getUsername(), "_", " ")
		SendChat("/do ������� � ����� ������� ���� � " RPName ".")
		SendChat("/me ������ ������� �� ������ ������� ����, ����� ������� ��� � ����� �����")
	}
	if sex = F
	{
		RPname:=RegExReplace(getUsername(), "_", " ")
		SendChat("/do ������� � ����� ������� ���� � " RPName ".")
		SendChat("/me ������� ������� �� ������ ������� ����, ����� �������� ��� � ������ �����")
	}
	reload
}
return

:?:/hp0::
setHP(0)
return

;=============================================
; ��������� ���������� ��� ������� ESC � F6
;=============================================
~ESC::
~F6::
menu:=0
return

;=============================================
; ������ ������ ��������
;=============================================
F12::
sleep 1000
menu := 1
ShowDialog(4, "{48D1CC}��������� {FFFFFF}| {FA8072}AHK", "{48D1CC}1 | {FFFFFF}�������� ������ �����`n{48D1CC}2 | {FFFFFF}�������� ����� �����������`n{48D1CC}3 | {FFFFFF}��������� � ����� �����������`n{48D1CC}4 | {FFFFFF}����� ������ ������������� (/r) [���]`n{48D1CC}5 | {FFFFFF}����� ���� ������������� (/f) [���]`n{48D1CC}6 | {FFFFFF}��� ������� ���`n{48D1CC}7 | {FFFFFF}��� ������� ����� ��������`n{48D1CC}8 | {FFFFFF}���������� ����� �����`n{006400}[ ��������� ��������� AHK ]", "�������")
return

~LButton::
Time := A_TickCount
while(isDialogOpen())
{
    if (A_TickCount - Time > 500)
    {
  Return
    }
}
if (menu == 1)
{	
    sleep 1000
    menu := 0
    line_num  := getDialogLineNumber()
    line_text  := getDialogLine(line_num)
    	if (line_num == 9)
	{
		sleep 1000
		RPname:=RegExReplace(getUsername(), "_", " ")
		pid:= getPlayerIdByName(getUsername())
		dout:=""
		dout .= "{FFFFFF}��� ������� ���: {48D1CC}" RPName " {FFFFFF}(ID: {48D1CC}" pid "{FFFFFF})`n"
		dout .= "{FFFFFF}����: {48D1CC}" rang "`n"
		dout .= "{FFFFFF}��������� �������� ��: {48D1CC}" sex "`n"
		dout .= "{FFFFFF}��� - /r: {48D1CC}" tag1 "`n"
		dout .= "{FFFFFF}��� - /f: {48D1CC}" tag2 "`n"
		dout .= "{FFFFFF}��������� ��� /time: {48D1CC}" grav "`n"
		dout .= "{FFFFFF}����� - /uds: {48D1CC}" number "`n"
		dout .= "{FFFFFF}��������� - /uds: {48D1CC}" drang "`n"
		dout .= "{FFFFFF}����������� - /uds: {48D1CC}" army "`n"
		showDialog(0, "{48D1CC}��������� AHK {FFFFFF}| {FA8072}AHK ", dout "", "{FFF300}��")
	}
	if (line_num == 1)
	{
		sleep 1000
		showDialog("1", "{48D1CC}��� - AHK: {FFFFFF}�������� �����", "{FFFFFF}������� ���� ���� �������� �����`n������ ���������: {48D1CC}" rang "{FFFFFF} (���� �����, �� ���������)`n����� ������� �����, ������� �������: ENTER", "�������")
		input, rang, V, {enter}
		if Rang =
		{
		goto ERRORCODE
		}
		IniWrite, %rang%, info.ini, INFO, rang
		addChatMessageEx("48D1CC","{48D1CC}��� - AHK: {FFFFFF}�������� �����: {48D1CC}" rang " {FFFFFF}| ���������: {FF8989}[������]")
	}
	if (line_num == 2)
	{
		sleep 1000
		showDialog("1", "{48D1CC}��� - AHK: {FFFFFF}�������� ����� �����������", "{FFFFFF}������� ���� ����� �������� �����������`n������ ���������: {48D1CC}" army "{FFFFFF} (���� �����, �� ���������)`n����� ������� �����, ������� �������: ENTER", "�������")
		input, army, V, {enter}
		if army =
		{
		goto ERRORCODE
		}
		IniWrite, %army%, info.ini, INFO, army
		addChatMessageEx("48D1CC","��� - AHK: {FFFFFF}�������� ����� �����������: {48D1CC}" army " {FFFFFF}| ���������: {FF8989}[������]")
	}
	if (line_num == 3)
	{
		sleep 1000
		showDialog("1", "{48D1CC}��� - AHK: {FFFFFF}��������� � ����� �����������", "{FFFFFF}������� ���� ���� ��������� � �����������`n������ ���������: {48D1CC}" drang "{FFFFFF} (���� �����, �� ���������)`n����� ������� �����, ������� �������: ENTER", "�������")
		input, drang, V, {enter}
		if drang =
		{
		goto ERRORCODE
		}
		IniWrite, %drang%, info.ini, INFO, drang
		addChatMessageEx("48D1CC","��� - AHK: {FFFFFF}��������� � ����� �����������: {48D1CC}" drang " {FFFFFF}| ���������: {FF8989}[������]")
	}
	if (line_num == 4)
	{
		sleep 1000
		showDialog("1", "{48D1CC}��� - AHK: {FFFFFF}����� ������ ������������� (/r)", "{FFFFFF}������� ���� ��� � ����� /r`n������ ���������: {48D1CC}" tag1 "{FFFFFF} (���� �����, �� ���������)`n����� ������� �����, ������� �������: ENTER`n������ ������: [S.E.A.L/�����]", "�������")
		input, tag1, V, {enter}
		if tag1 =
		{
		goto ERRORCODE
		}
		IniWrite, %tag1%, info.ini, INFO, tag1
		addChatMessageEx("48D1CC","��� - AHK: {FFFFFF}����� ������ ������������� (/r): {48D1CC}" tag1 " {FFFFFF}| ���������: {FF8989}[������]")
	}
	if (line_num == 5)
	{
		sleep 1000
		showDialog("1", "{48D1CC}��� - AHK: {FFFFFF}����� ������ ������������� (/f)", "{FFFFFF}������� ���� ��� � ����� /f`n������ ���������: {48D1CC}" tag2 "{FFFFFF} (���� �����, �� ���������)`n����� ������� �����, ������� �������: ENTER`n������ ������: [��� | S.E.A.L/�����]", "�������")
		input, tag2, V, {enter}
		if tag2 =
		{
		goto ERRORCODE
		}
		IniWrite, %tag2%, info.ini, INFO, tag2
		addChatMessageEx("48D1CC","��� - AHK: {FFFFFF}����� ������ ������������� (/f): {48D1CC}" tag2 " {FFFFFF}| ���������: {FF8989}[������]")
	}
	if (line_num == 6)
	{
		sleep 1000
		showDialog("1", "{48D1CC}��� - AHK: {FFFFFF}��� ������� ���", "{FFFFFF}�������� ��� ������� ���: F - ������� , M - �������`n������ ���������: {48D1CC}" sex "{FFFFFF} (���� �����, �� ���������)`n����� ������� �����, ������� �������: ENTER", "�������")
		input, sex, V, {enter}
		if sex =
		{
		goto ERRORCODE
		}
		IniWrite, %sex%, info.ini, INFO, sex
		addChatMessageEx("48D1CC","��� - AHK: {FFFFFF}��� ������� ���: {48D1CC}" sex " {FFFFFF}| ���������: {FF8989}[������]")
	}
	if (line_num == 7)
	{
		sleep 1000
		showDialog("1", "{48D1CC}��� - AHK: {FFFFFF}��� ������� ����� ��������", "{FFFFFF}������� ���� ��� ������� ����� ��������`n������ ���������: {48D1CC}" number "{FFFFFF} (���� �����, �� ���������)`n����� ������� �����, ������� �������: ENTER", "�������")
		input, number, V, {enter}
		if number =
		{
		goto ERRORCODE
		}
		IniWrite, %number%, info.ini, INFO, number
		addChatMessageEx("48D1CC","��� - AHK: {FFFFFF}��� ������� ����� ��������: {48D1CC}" number " {FFFFFF}| ���������: {FF8989}[������]")
	}
	if (line_num == 8)
	{
		sleep 1000
		showDialog("1", "{48D1CC}��� - AHK: {FFFFFF}���������� ����� �����", "{FFFFFF}������� ���� ���������� ����� �����`n������ ���������: {48D1CC}" grav "{FFFFFF} (���� �����, �� ���������)`n����� ������� �����, ������� �������: ENTER", "�������")
		input, grav, V, {enter}
		if grav =
		{
		goto ERRORCODE
		}
		IniWrite, %grav%, info.ini, INFO, grav
		addChatMessageEx("48D1CC","��� - AHK: {FFFFFF}���������� ����� �����: {48D1CC}" grav " {FFFFFF}| ���������: {FF8989}[������]")
	}
    return
}
return


ERRORCODE:
sleep 1000
addChatMessageEx("48D1CC","��� - AHK: {FFFFFF}�� ������ �� �����! ������ #1 {FFFFFF}| ���������: {800000}[�� ������] ")
reload


RButton & 1::
id := getIdByPed(getTargetPed())
RPN := RegExReplace(GetPlayerNameByid(id), "_", " ")
if sex = M
{
	SendChat("������� �����, ������� " RPN)
	SendChat("/me �������� �������� ����������")
	SendChat("/anim 58")
	sleep 1000
	SendChat(")")
}
if sex = F
{
	SendChat("������� �����, ������� " RPN)
	SendChat("/me ��������� �������� ����������")
	SendChat("/anim 58")
	sleep 1000
	SendChat(")")
}
return
    RButton & 2::
    {
        suid:= getIdByPed(getTargetPed())
        if(suid!=-1)
        {
            if(getDist(GetCoordinates(),getPedCoordinates(getPedById(suid)))<23)
            {
                Wordesss := getPlayerNameById(suid)
                FileRead, Str, blacklist.txt
                StringReplace, Str, Str, `r`n, `n, 1
                StringReplace, Str, Str, `r, `n, 1
                SendChat("�������, ������ � ������� ��� �� �� ��.")
                sleep 1000
		if sex = M
		{
                	SendChat("/me ������ ���-" army " �� ������� � ������� ���")
                	sleep 1000
                	SendChat("/me ����� �� ������ ����� - Chocolate State")
                	sleep 1000
                	SendChat("/me ������� ������ [׸���� ������ ������������ �������]")
		}
		if sex = F
		{
                	SendChat("/me ������� ���-" army " �� ������� � �������� ���")
                	sleep 1000
                	SendChat("/me ����� �� ������ ����� - Chocolate State")
                	sleep 1000
                	SendChat("/me ������� ������ [׸���� ������ ������������ �������]")
		}
                if Str not contains `n%Wordesss%`n
                {
                    SendChat("/history " Wordesss)
                AddchatmessageEx("48D1CC","��� - AHK: {FFD700}[BlackList] {48D1CC}�� ��������� esc. ���� �� ������ ����������.")
                    sleep 3000
                    Wordesdwa =
                    Wordesdwa := getdialogtext()
                Wordesdwa := RegexReplace(Wordesdwa, "^{FFFFFF}")
                    FileDelete, blacklistcode.txt
                    FileAppend,%Wordesdwa%`n,blacklistcode.txt
                    FileRead, Stroka, blacklistcode.txt
                    FileDelete, blacklistcode.txt
                    StringReplace, Wordesdwa, Wordesdwa, `n, `n, UseErrorLevel
                    loop, %ErrorLevel%
                    {
                        RegExMatch(Stroka, "^(.*)`r`n", hister)
                        if Str contains `n%hister1%`n
                        {
                        AddchatmessageEx("48D1CC","��� - AHK: {FFD700}[BlackList] {48D1CC}" Wordesss " ������� � ������ ������. ��� �����: " hister1)
				hister11 := RegExReplace(hister1, "_", " ")
                            SendChat("/do ������� " hister11 " ���� � ׸���� ������ ������������ �������.")
                            sleep 1000
                            SendChat("��������, �� ��� �� ���������, �� � ׸���� ������ ������������ �������.")
                            sleep 1000
			    if sex = M
			    {
                            	SendChat("/me �������� ���-" army " � ����� ��� � ������.")
                            }
			    if sex = F
			    {
                            	SendChat("/me ��������� ���-" army " � ������ ��� � ������.")
                            }
                            return
                        }
                        Stroka := RegexReplace(Stroka, "^.*`r`n")
                    }
                AddchatmessageEx("48D1CC","��� - AHK: {FFD700}[BlackList] {48D1CC}" Wordesss " �� ������� � ������ ������.") 
			hister4 := RegExReplace(Wordesss, "_", " ")
                    SendChat("/do �������� " hister4 " ��� � ׸���� ������ ������������ �������.")
                    sleep 1000
		    if sex = M
		    {
                    	SendChat("/me �������� ���-" army " � ����� ��� � ������.")
		    }
		    if sex = F
		    {
                    	SendChat("/me ��������� ���-" army " � ������ ��� � ������.")		
		    }
                    sleep 1000
                    SendChat("�������, ��� ��� � ������ ������ ������������ �������.")
                }
                else
                {
                AddchatmessageEx("48D1CC","��� - AHK: {FFD700}[BlackList] {48D1CC}" Wordesss " ������� � ������ ������.")
                    sleep 1000
			hister5 := RegExReplace(Wordesss, "_", " ")
                    SendChat("/do ������� " hister5 " ���� � ������ ������ ������������ �������.")
                    sleep 1000
                    SendChat("��������, �� ��� �� ���������, �� � ׸���� ������ ������������ �������.")
                    sleep 1000
		    if sex = M
		    {
                    	SendChat("/me �������� ���-" army " � ����� ��� � ������.")
		    }
		    if sex = F
		    {
                    	SendChat("/me ��������� ���-" army " � ������ ��� � ������.")		
		    }
                }
            }
            else
            {
            addChatMessageEx("48D1CC","��� - AHK: {FFD700}[BlackList] {48D1CC}�� �� ������ ��� ������, ��������� �����!")
            }
        }
        else
        {
        AddchatmessageEx("48D1CC","��� - AHK: {FFD700}[BlackList] {48D1CC}�� ������ id ������!")
        }
    }
    return

F4::
KeyWait, Enter
SendChat("/p")
sleep 1000
RPname:=RegExReplace(getUsername(), "_", " ")
SendChat("�� ��������� - " RPName ", �� � ������ ������ � �� ���� �������� ���.")
SendChat("����������� ���������� ��� �����, ������� �� ��������.")
SendChat("/h")
return

F3::
KeyWait, Enter
m = 60
m -= %A_Min%
hour:=getServerHour()
sleep 300
if sex = M
{
	SendChat("/me ��������� �� ���� � ����������� " grav)
	SendChat("/do (�����: " hour ":" A_Min ":" A_Sec ") | �� �������� �������� ����� (" m " ���)")
	sleep 699
	SendChat("/c 060")
}
if sex = F
{
	SendChat("/me ���������� �� ���� � ����������� " grav)
	SendChat("/do (�����: " hour ":" A_Min ":" A_Sec ") | �� �������� �������� ����� (" m " ���)")
	sleep 699
	SendChat("/c 060")
}
return

$~Enter:: 
sleep, 30 
if (isInChat() = 0) or (isDialogOpen() = 1) 
return 
sleep 150 
dwAddress := dwSAMP + 0x12D8F8 
chatInput := readString(hGTA, dwAddress, 256)
if (RegExMatch(chatInput, "^/myhelp"))
{
sleep 1000
RPname:=RegExReplace(getUsername(), "_", " ")
dout:=""
dout .= "{48D1CC}/rr {A9A9A9}[���������]{FFFFFF} - IC ����� ��� ����� ����� /r`n"
dout .= "{48D1CC}/ff {A9A9A9}[���������]{FFFFFF} - IC ����� ��� ����� ����� /f`n"
dout .= "{48D1CC}/rb {A9A9A9}[���������]{FFFFFF} - ��� ����� ��� ����� ����� /r`n"
dout .= "{48D1CC}/fb {A9A9A9}[���������]{FFFFFF} - ��� ����� ��� ����� ����� /f`n"
dout .= "{48D1CC}/hist {A9A9A9}[ID]{FFFFFF} - ������ ������� ����� ������`n"
dout .= "{48D1CC}/met {A9A9A9}[���-��]{FFFFFF} - ����� ������`n"
dout .= "{48D1CC}/������� {A9A9A9}[���]{FFFFFF} - ������/�������� ��������`n"
dout .= "{48D1CC}/relahk{FFFFFF} - ������������� ������`n"
dout .= "{48D1CC}(F3){FFFFFF} - �� ����`n"
dout .= "{48D1CC}/uds{FFFFFF} - �� �������������`n"
dout .= "{48D1CC}/dk {A9A9A9}[���� ���(A)] [���������]{FFFFFF} - ��������� �� ����`n"
dout .= "{48D1CC}/bd {A9A9A9}[�����] [���������]{FFFFFF} - ������ ��� � ���������� ��`n"
dout .= "{48D1CC}/nabor{FFFFFF} - ������ ������� �������`n"
dout .= "{48D1CC}/blist{FFFFFF} - ������ ������� ������� /bd`n"
dout .= "{48D1CC}/���{FFFFFF} - ������� ��� ���������`n"
dout .= "{4BD1CC}��� + 1{FFFFFF} - ������� �����`n"
dout .= "{4BD1CC}��� + 2{FFFFFF} - ��������� ������ �� �� ��`n"
dout .= "{48D1CC}/fvig {A9A9A9}[ID] [�������]{FFFFFF} - ������ ����� �����"
showDialog(0, "{48D1CC}������� AutoHotKey by Fox {FFFFFF}| {FA8072}AHK ", dout, "�������")
}
if (RegExMatch(chatInput, "^/nabor"))
{
RPname:=RegExReplace(getUsername(), "_", " ")
sleep 1000
dout2:=""
dout2 .= "{48D1CC}/pz1 {FFFFFF}- �������������, ��������� ���������`n"
dout2 .= "{48D1CC}/pz2 {FFFFFF}- �� �� ����� ��������� � ��������� ��`n"
dout2 .= "{48D1CC}/pz3 {FFFFFF}- ��������� �������`n"
dout2 .= "{48D1CC}/pz4 {FFFFFF}- �������� �� ��������`n"
showDialog(0, "{48D1CC}������� ������� {FFFFFF}| {FA8072}AHK ", dout2, "�������")
}
if (RegExMatch(chatInput, "^/���"))
{
RPname:=RegExReplace(getUsername(), "_", " ")
sleep 1000
dout2:=""
dout2 .= "{48D1CC}/dv1 {FFFFFF}| ������ ��������� � ����`n"
dout2 .= "{48D1CC}/dv2 {FFFFFF}| ��������� ��������� � ����`n"
dout2 .= "{48D1CC}/dv3 {FFFFFF}| ��������� ��������� � ����`n"
dout2 .= "{48D1CC}/pilot {FFFFFF}| ���������� ����/�������`n"
dout2 .= "{48D1CC}/lec {FFFFFF}| [1 - ������] [2 - ������]`n"
showDialog(0, "{48D1CC}��� ������� {FFFFFF}| {FA8072}AHK ", dout2, "�������")
}
if (RegExMatch(chatInput, "^/blist"))
{
RPname:=RegExReplace(getUsername(), "_", " ")
sleep 1000
dout3:=""
dout3 .= "{A9A9A9}1 {FFFFFF}- ������`n"
dout3 .= "{A9A9A9}2 {FFFFFF}- ���`n"
dout3 .= "{A9A9A9}3 {FFFFFF}- ���� ���`n"
dout3 .= "{A9A9A9}4 {FFFFFF}- ��`n"
dout3 .= "{A9A9A9}5 {FFFFFF}- 24/7 � ��`n"
dout3 .= "{A9A9A9}6 {FFFFFF}- ���`n"
dout3 .= "{A9A9A9}7 {FFFFFF}- ���`n"
dout3 .= "{A9A9A9}8 {FFFFFF}- ���������"
showDialog(0, "{48D1CC}������ ������� {FFFFFF}| {FA8072}AHK ", dout3, "�������")
}
if (RegExMatch(chatInput, "^/rr"))
{
	if (RegExMatch(chatInput, "/rr (.*)", out))
	{
		if sex = M
		{
			RPname:=RegExReplace(getUsername(), "_", " ")
			SendChat("/do ����� �� ����� � " RPname ".")
			sleep 1000
			SendChat("/me ���� ����� � �����, ����� ����� [R] � ������ ���-�� � ��:")
			SendChat("/r " tag1 " " out1)
			sleep 1000
			SendChat("/me ����� [R] � ������� ����� �� ����")
		}
		if sex = F
		{
			RPname:=RegExReplace(getUsername(), "_", " ")
			SendChat("/do ����� �� ����� � " RPname ".")
			sleep 1000
			SendChat("/me ����� ����� � �����, ����� ������ [R] � ������� ���-�� � ��:")
			SendChat("/r " tag1 " " out1)
			sleep 1000
			SendChat("/me ������ [R] � �������� ����� �� ����")
		}
	}
	else
	{
		AddChatMessageEx("48D1CC", "��� - AHK: {FFFFFF}�������: {48D1CC}/rr [���������]{FFFFFF} - IC ����� ��� ����� ����� /r")
                return
	}
}
if (RegExMatch(chatInput, "^/ff"))
{
	if (RegExMatch(chatInput, "/ff (.*)", out))
	{
		if sex = M
		{
			RPname:=RegExReplace(getUsername(), "_", " ")
			SendChat("/do ����� �� ����� � " RPname ".")
			sleep 1000
			SendChat("/me ���� ����� � �����, ����� ����� [F] � ������ ���-�� � ��:")
			SendChat("/f " tag2 " " out1)
			sleep 1000
			SendChat("/me ����� [F] � ������� ����� �� ����")
		}
		if sex = F
		{
			RPname:=RegExReplace(getUsername(), "_", " ")
			SendChat("/do ����� �� ����� � " RPname ".")
			sleep 1000
			SendChat("/me ����� ����� � �����, ����� ������ [F] � ������� ���-�� � ��:")
			SendChat("/f " tag2 " " out1)
			sleep 1000
			SendChat("/me ������ [F] � �������� ����� �� ����")
		}
	} 
	else
	{
		AddChatMessageEx("48D1CC", "��� - AHK: {FFFFFF}�������: {48D1CC}/ff [���������]{FFFFFF} - IC ����� ��� ����� ����� /f")
                return
	}
}
if (RegExMatch(chatInput, "^/met"))
{ 
	if (RegExMatch(chatInput, "/met (.*)", out))
	{
		RPname:=RegExReplace(getUsername(), "_", " ")
		if sex = M
		{
			SendChat("/do ������ �� ����� � " RPName ".")
			SendChat("/me ���� ������ � ��������� ���, ������� " out1 " �� �������")
			SendChat("/takem " out1)
			sleep 1000
			SendChat("/me ��������� ������, ����� ������� �� �����")
		}
		if sex = F
		{
			SendChat("/do ������ �� ����� � " RPName ".")
			SendChat("/me ���� ������ � ��������� ���, �������� " out1 " �� �������")
			SendChat("/takem " out1)
			sleep 1000
			SendChat("/me ���������� ������, ����� �������� �� �����")
		}
	}
	else
	{
		AddChatMessageEx("48D1CC", "��� - AHK: {FFFFFF}�������: {48D1CC}/met [���-��]{FFFFFF} - ����� ������")
                return
	}
}
if (RegExMatch(chatInput, "^/sc"))
{ 
	AddChatMessageEx("48D1CC", "��� - AHK: {A9A9A9}��������� - ���������� �� ��������� {FF6666}ESC {A9A9A9}��� {FF6666}F6")
	sleep 1000
	SendChat("/c 060")
	AddChatMessageEx("48D1CC", "��� - AHK: {A9A9A9}��������� - {FF3333}������!")
	sleep 1000
	Send {F8}
}
if (RegExMatch(chatInput, "^/rahk"))
{
	save(chatlog)
	addChatMessageEx("48D1CC", "��� - AHK: {FFFFFF}������������ �������..")
	addChatMessageEx("48D1CC", "��� - AHK: {FFFFFF}�������� 5 ������!")
	sleep 5000
	addChatMessageEx("48D1CC", "��� - AHK: {FFFFFF}������������ ������!")
	reload
}
if (RegExMatch(chatInput, "^/dk"))
{
	if (RegExMatch(chatInput, "/dk (.*) (.*)", out))
	{
		RPname:=RegExReplace(getUsername(), "_", " ")
		pid:= getPlayerIdByName(getUsername())
		SendChat("/f " tag2 " �������: ������ ��������� | ����: " out1 " | ���������: " out2)
		SendChat("/pass " pid)
	}
	else 
	{
		AddChatMessageEx("48D1CC", "��� - AHK: {FFFFFF}�������: {48D1CC}/dk [���� ���(A)] [���������]{FFFFFF} - ��������� �� ����")
		return
	}
}
if (RegExMatch(chatInput, "^/�������"))
{
	if (RegExMatch(chatInput, "/������� (.*)", out))
	{
		if (out1 == 1)
		{
			if sex = M
			{
				RPN:=RegExReplace(getUsername(), "_", " ")
				SendChat("/me ������� �������")
				sleep 1000
				SendChat("/me ����� ����� �������������� �� ������ ��������")
				sleep 1000
				SendChat("/me ������� ������")
				sleep 1000
				SendChat("/me ������� ������ ��������� �������")
				sleep 1000
				SendChat("/me ������� ���������� ��������")
				sleep 1000
				SendChat("/me ������� ��������� ���� � ��������")
				sleep 1000
				SendChat("/me ������� ������ �� ��������� ����")
				sleep 1000
				SendChat("/me ������� ������� ������ �� ��������� ���������")
				SendChat(rang " " RPN " �������� �������� ��������!")
				sleep 1000
				SendChat(")")
			}
			if sex = F
			{
				RPN:=RegExReplace(getUsername(), "_", " ")
				SendChat("/me �������� �������")
				sleep 1000
				SendChat("/me ������ ����� �������������� �� ������ ��������")
				sleep 1000
				SendChat("/me �������� ������")
				sleep 1000
				SendChat("/me �������� ������ ��������� �������")
				sleep 1000
				SendChat("/me �������� ���������� ��������")
				sleep 1000
				SendChat("/me �������� ��������� ���� � ��������")
				sleep 2500
				SendChat("/me �������� ������ �� ��������� ����")
				sleep 1000
				SendChat("/me �������� ������� ������ �� ��������� ���������")
				SendChat(rang " " RPN " ��������� �������� ��������!")
				sleep 1000
				SendChat(")")
			}
		}
		if (out1 == 2)
		{
			if sex = M
			{
				RPN:=RegExReplace(getUsername(), "_", " ")
				SendChat("/me ���� ����� ��������, ��������� � ������ ��������")
				sleep 1000
				SendChat("/me ����������� ������� ������ �� ��������� ���������")
				sleep 1000
				SendChat("/me ����������� ������ � ��������� ���")
				sleep 1000
				SendChat("/me ����������� ��������� ���� � �������� � ��������� �������")
				sleep 1000
				SendChat("/me ����������� ���������� ��������")
				sleep 1000
				SendChat("/me ����������� ������ ��������� �������")
				sleep 1000
				SendChat("/me ������� ����� � ������� ������ � �������� �� ��������������")
				sleep 1000
				SendChat("/me ����������� ������")
				sleep 1000
				SendChat("/me ������ ����� � ������ ��������")
				sleep 1000
				SendChat("/me �������� ������ ��������")
				SendChat(rang " " RPN " �������� ������ ��������!")
				sleep 1000
				SendChat(")")
			}
			if sex = F
			{
				RPN:=RegExReplace(getUsername(), "_", " ")
				SendChat("/me ����� ����� ��������, ���������� � ������ ��������")
				sleep 1000
				SendChat("/me ������������ ������� ������ �� ��������� ���������")
				sleep 1000
				SendChat("/me ������������ ������ � ��������� ���")
				sleep 1000
				SendChat("/me ������������ ��������� ���� � �������� � ��������� �������")
				sleep 1000
				SendChat("/me ������������ ���������� ��������")
				sleep 1000
				SendChat("/me ������������ ������ ��������� �������")
				sleep 1000
				SendChat("/me �������� ����� � ������� ������ � ��������� �� ��������������")
				sleep 1000
				SendChat("/me ������������ ������")
				sleep 1000
				SendChat("/me ������� ����� � ������ ��������")
				sleep 1000
				SendChat("/me ��������� ������ ��������")
				SendChat(rang " " RPN " ��������� ������ ��������!")
				sleep 1000
				SendChat(")")
			}
		}
	}
	else 
	{
		AddChatMessageEx("48D1CC", "��� - AHK: {FFFFFF}�������: {48D1CC}/������� [���]")
		AddChatMessageEx("48D1CC", "��� - AHK: {A9A9A9}1 {FFFFFF} - ��������� | {A9A9A9}2 {FFFFFF}- �������")
		return
	}
}
if (RegExMatch(chatInput, "^/bd"))
{
	if (RegExMatch(chatInput, "/bd ([0-9]{0,3}) (.*)", out))
	{
		if (out1 == 1)
		{
			pid:= getPlayerIdByName(getUsername())
			SendChat("/f " tag2 " ������: ��������� ������� | ������: " out2 " | ���������: ������ �������.")
			SendChat("/pass " pid)
		}
		if (out1 == 2)
		{
			pid:= getPlayerIdByName(getUsername())
			SendChat("/f " tag2 " ������: ��������� ������� | ����: ������-��������� ���� | ���������: " out2)
			SendChat("/pass " pid)
		}
		if (out1 == 3)
		{
			pid:= getPlayerIdByName(getUsername())
			SendChat("/f " tag2 " ������: ��������� ������� | ����: ���� � ������-��������� ��� | ���������: " out2)
			SendChat("/pass " pid)
		}
		if (out1 == 4)
		{
			pid:= getPlayerIdByName(getUsername())
			SendChat("/f " tag2 " ������: ��������� ������� | ����: ���������� ������ | ���������: " out2)
			SendChat("/pass " pid)
		}
		if (out1 == 5)
		{
			pid:= getPlayerIdByName(getUsername())
			SendChat("/f " tag2 " ������: ��������� ������� | ����: 24/7 � ���������� ����� | ���������: " out2)
			SendChat("/pass " pid)
		}
		if (out1 == 6)
		{
			pid:= getPlayerIdByName(getUsername())
			SendChat("/f " tag2 " ������: ��������� ������� | ����: ������-������� ���� | ���������: " out2)
			SendChat("/pass " pid)
		}
		if (out1 == 7)
		{
			pid:= getPlayerIdByName(getUsername())
			SendChat("/f " tag2 " ������: ��������� ������� | ����: ��� | ���������: " out2)
			SendChat("/pass " pid)
		}
		if (out1 == 8)
		{
			pid:= getPlayerIdByName(getUsername())
			SendChat("/f " tag2 " ������: ��������� ������� | ������: " out2 " | ���������: ��������� �������.")
			SendChat("/pass " pid)
		}
	}
	else 
	{
		AddChatMessageEx("48D1CC", "��� - AHK: {FFFFFF}�������: {48D1CC}/bd [���] [���������]")
		AddChatMessageEx("48D1CC", "��� - AHK: {FFFFFF}�������: {48D1CC}/bd 1 [���-��] {A9A9A9}| {48D1CC}8 [���-��]")
		AddChatMessageEx("48D1CC", "��� - AHK: {FFFFFF}������ ���� ������� �������: {48D1CC}/plist")
		return
	}
}
if (RegExMatch(chatInput, "^/hist"))
{
	if (RegExMatch(chatInput, "/hist ([0-9]{0,3})", out))
	{
		Nick:=GetPlayerNameByid(out1)
		SendChat("/history " Nick)
	}
	else
	{
		AddChatMessageEx("48D1CC", "��� - AHK: {FFFFFF}�������: {48D1CC}/hist [ID]{FFFFFF} - ������ ������� ����� ������")
                return
	}
}
if (RegExMatch(chatInput, "^/rb"))
{
	if (RegExMatch(chatInput, "/rb (.*)", out))
	{
		SendChat("/r (( " out1 " ))")
	}
	else
	{
		AddChatMessageEx("48D1CC", "��� - AHK: {FFFFFF}�������: {48D1CC}/rb [���������]{FFFFFF} - ��� ����� ��� ����� ����� /r")
                return
	}
}
if (RegExMatch(chatInput, "^/fb"))
{
	if (RegExMatch(chatInput, "/fb (.*)", out))
	{
		SendChat("/f (( " out1 " ))")
	}
	else
	{
		AddChatMessageEx("48D1CC", "��� - AHK: {FFFFFF}�������: {48D1CC}/fb [���������]{FFFFFF} - ��� ����� ��� ����� ����� /f")
                return
	}
}
if (RegExMatch(chatInput, "^/find"))
{
	SendChat("/find")
	Loop
	{
		if(isDialogOpen()==1)
		break
	} 
	text:=getDialogText()
	RegExMatch(text, "�� ��� ������:\s+([0-9]+)", online)
	if sex = M
	{
		SendChat("/me ������ �� ������� ���-" army)
		SendChat("/do ����������� " army " � ����� ������ > [" online1 "]")
	}
	if sex = F
	{
		SendChat("/me ������a �� ������� ���-" army)
		SendChat("/do ����������� " army " � ����� ������ > [" online1 "]")
	}
}
if (RegExMatch(chatInput, "^/sos"))
{
	zona:=getPlayerZone()
	city:=getPlayerCity()
	if(city == "����������")
	{
		addChatMessageEx("48D1CC","{48D1CC}��� - AHK: {FFFFFF}�� � ������: {48D1CC}Unknow {FFFFFF}| � ������: {48D1CC}" zona)
		SendChat("/r " tag1 " ��������� ���������, ��� ��������������� " zona)
	}
	if(zona == "����������")
	{
		addChatMessageEx("48D1CC","{48D1CC}��� - AHK: {FFFFFF}�� � ������: {48D1CC}" city " {FFFFFF}| � ������: {48D1CC}Unknow")
		SendChat("/r " tag1 " ��������� ���������, ��� ��������������� " city)
	}
	if(zona == "����������" && city == "����������")
	{
		addChatMessageEx("48D1CC","{48D1CC}��� - AHK: {FFFFFF}�� � ������: {48D1CC}Unknow {FFFFFF}| � ������: {48D1CC}Unknow")
	}
	else
	{
		addChatMessageEx("48D1CC","{48D1CC}��� - AHK: {FFFFFF}�� � ������: {48D1CC}" city " {FFFFFF}| � ������: {48D1CC}" zona)
		SendChat("/r " tag1 " ��������� ���������, ��� ��������������� " city " " zona)
	}
}
if (RegExMatch(chatInput, "^/pz1"))
{
	pid:= getPlayerIdByName(getUsername())
	RPN:=RegExReplace(getUsername(), "_", " ")
	SendChat("������� �����. � ������ " army)
	SendChat("�, " rang " " RPN ".")
	sleep 1000
	SendChat("���������� ����������, ��� �������, ����� �������� � ��������")
	SendChat("/n /pass " pid " | /lic " pid " | /me �������(�) ��������")
	}
if (RegExMatch(chatInput, "^/pz2"))
{
	if sex = M
	{
	SendChat("/me ���� �������� �� ��� �������� �� ������")
	SendChat("/anim 21")
	sleep 1000
	SendChat("/me ������� ��������, ����� ������� �� ����")
	sleep 1000
	SendChat("/me ���� �� ��� ���������� ������� � ������� ���")
	Sleep 1000
	SendChat("�� ������, ������ ��������� ��������.")
	}
	if sex = F
	{
	SendChat("/me ����� �������� �� ��� �������� �� ������")
	SendChat("/anim 21")
	sleep 1000
	SendChat("/me ������� ��������, ����� �������� �� ����")
	sleep 1000
	SendChat("/me ����� �� ��� ���������� ������� � ������� ���")
	Sleep 1000
	SendChat("�� ������, ������ ��������� ��������.")
	}
}
if (RegExMatch(chatInput, "^/pz3"))
{
	Random, randt, 1, 9
	if (randt = 1) 
	{
		SendChat("��� ����� �� ������ ��?")
	}
	if (randt = 2) 
	{
		SendChat("��� ����� �� ������ ��?")
	}
	if (randt = 3) 
	{
		SendChat("��� ����� �� ������ ��?")
	}
	if (randt = 4) 
	{
		SendChat("��� ����� �� ������ ��?")
	}
	if (randt = 5) 
	{
		SendChat("��� � ���� � ����?")
	}
	if (randt = 6) 
	{
		SendChat("��� � ���� ��� �������?")
	}
	if (randt = 7) 
	{
		SendChat("��� ���� �����?")
	}
	if (randt = 8) 
	{
		SendChat("������� �� ��� �������?")
	}
	if (randt = 9) 
	{
		SendChat("������� �� ��� � �����?")
	}
}
if (RegExMatch(chatInput, "^/pz4"))
{
	Random, randt, 1, 3
	if (randt = 1) 
	{
		SendChat("/n /sms " number " DM MG")
	}
	if (randt = 2) 
	{
		SendChat("/n /sms " number " DB RP")
	}
	if (randt = 3) 
	{
		SendChat("/n /sms " number " PG TK")
	}
}
if (RegExMatch(chatInput, "^/uds"))
{
	RPname:=RegExReplace(getUsername(), "_", " ")
	pid:= getPlayerIdByName(getUsername())
	if sex = M
	{
	SendChat("/me ������ �� ����������� ������� ����� ������������ �" pid)
	Sleep 1000
	SendChat("/do � ��� � �������: " RPname " | ����� ��������: " number)
	SendChat("/do � ���������: " army " | ������ ����������: " rang)
	SendChat("/do � ��������� ���������� " army ": " drang)
	Sleep 1000
	SendChat("/me ����� ������������ �� ���������� ������ �����")
	}
	if sex = F
	{
	SendChat("/me ������� �� ����������� ������� ����� ������������ �" pid)
	Sleep 1000
	SendChat("/do � ��� � �������: " RPname " | ����� ��������: " number)
	SendChat("/do � ����������: " army " | ������ ����������: " rang)
	SendChat("/do � ��������� ���������� " army ": " drang)
	Sleep 1000
	SendChat("/me ������ ������������ �� ���������� ������ �����")
	}
}
if (RegExMatch(chatInput, "^/dv1"))
{
	RPname:=RegExReplace(getUsername(), "_", " ")
	pid:= getPlayerIdByName(getUsername())
	if sex = M
	{
	SendChat("/anim 57")
	sleep 1000
	SendChat("/do ���������� ����� �� ����� ���������.")
	sleep 1000
	SendChat("/do �� ���������� �������� �������.")
	sleep 1000
	SendChat("/me ����� �� ������ ��������� �����������")
	sleep 1000
	SendChat("/do ���������� �������.")
	sleep 1000
	SendChat("/do �� ����������� ����� ��������� ��������.")
	sleep 1000
	SendChat("/me ����� �������� �� ������")
	SendChat("/r " tag1 " " rang " " RPname " �������� �� ��������� � ����.")
	}
	if sex = F
	{
	SendChat("/anim 57")
	sleep 1000
	SendChat("/do ���������� ����� �� ����� ���������.")
	sleep 1000
	SendChat("/do �� ���������� �������� �������.")
	sleep 1000
	SendChat("/me ������ �� ������ ��������� �����������")
	sleep 1000
	SendChat("/do ���������� �������.")
	sleep 1000
	SendChat("/do �� ����������� ����� ��������� ��������.")
	sleep 1000
	SendChat("/me ������ �������� �� ������")
	SendChat("/r " tag1 " " rang " " RPname " ��������� �� ��������� � ����.")
	}
}
if (RegExMatch(chatInput, "^/dv2"))
{
	RPname:=RegExReplace(getUsername(), "_", " ")
	pid:= getPlayerIdByName(getUsername())
	if sex = M
	{
	SendChat("/do ���������� �������.")
	sleep 1000
	SendChat("/me ���� �������� � ������ � ������� �� ����� �����")
	sleep 1000
	SendChat("/me ����� �� ������ ���������� �����������")
	sleep 1000
	SendChat("/do ���������� ����������.")
	sleep 1000
	SendChat("/r " tag1 " " rang " " RPname " ��������� � ���� �������.")
	}
	if sex = F
	{
	SendChat("/do ���������� �������.")
	sleep 1000
	SendChat("/me ����� �������� � ������ � �������� �� ����� �����")
	sleep 1000
	SendChat("/me ������ �� ������ ���������� �����������")
	sleep 1000
	SendChat("/do ���������� ����������.")
	sleep 1000
	SendChat("/r " tag1 " " rang " " RPname " ��������� � ���� ��������.")
	}
}
if (RegExMatch(chatInput, "^/pilot"))
{
	if (RegExMatch(chatInput, "/pilot ([0-9]{0,3})", out))
	{
		RPname:=RegExReplace(getUsername(), "_", " ")
		pid:= getPlayerIdByName(getUsername())
		if (out1 == 1)
		{
			if sex = M
			{
				SendChat("/me ����� �� ������ [�����]")
				sleep 1000
				SendChat("����� ��������")
				sleep 1000
				SendChat("/me ����� ����� � ������ [�����]")
			}
			if sex = F
			{
				SendChat("/me ������ �� ������ [�����]")
				sleep 1000
				SendChat("����� ��������")
				sleep 1000
				SendChat("/me ������ ����� � ������ [�����]")
			}
		}
		if (out1 == 2)
		{
			if sex = M
			{
				SendChat("/me ����� �� ������ [�����]")
				sleep 1000
				SendChat("������� ��������")
				sleep 1000
				SendChat("/me ����� ����� � ������ [�����]")
			}
			if sex = F
			{
				SendChat("/me ������ �� ������ [�����]")
				sleep 1000
				SendChat("������� ��������")
				sleep 1000
				SendChat("/me ������ ����� � ������ [�����]")
			}
		}
	}
	else
	{
		AddChatMessageEx("48D1CC", "��� - AHK: {FFFFFF}�������: {48D1CC}/pilot [1 - ��������� ����] [2 - ��������� �������]")
                return
	}
}
if (RegExMatch(chatInput, "^/dv3"))
{
	RPname:=RegExReplace(getUsername(), "_", " ")
	pid:= getPlayerIdByName(getUsername())
	SendChat("/r " tag1 " " rang " " RPname " ��������� ����� ��������� � ����.")
}
if (RegExMatch(chatInput, "^/gt"))
{
	if sex = M
	{	
		SendChat("/me ����� ���� � ������, ����� ����� �� ������ (Close/Open)")
		SendChat("/gate")
	}
	if sex = F
	{
		SendChat("/me ������ ���� � ������, ����� ������ �� ������ (Close/Open)")
		SendChat("/gate")
	}
}
if (RegExMatch(chatInput, "^/lec"))
{
	if (RegExMatch(chatInput, "/lec ([0-9]{0,3})", out))
	{
		RPname:=RegExReplace(getUsername(), "_", " ")
		pid:= getPlayerIdByName(getUsername())
		if (out1 == 1)
		{
			SendChat("/r " tag1 " ������, ������� �����������!")
			sleep 3000
			SendChat("/r " tag1 " ������ ��� ��������, ���� ������������, �� ������� ��������� ����������.")
			sleep 3000
			SendChat("/r " tag1 " �����: ���������� ���������� �� �����/�������. ����: ���. ��: �����.")
			sleep 3000
			SendChat("/r (( ���������� ����������� � ������� ���, ���� �� ����� ������ �� ��������� ))")
			sleep 3000
			SendChat("/r " tag1 " ��� ����� �������� ��� ������� - ��������������, ����� ����������.")
			sleep 1000
			addChatMessageEx("48D1CC", "��� - AHK: {FFFFFF}�����: {FF0000}/sc")
		}
		if (out1 == 2)
		{
			SendChat("/r " tag1 " ������, ������� �����������!")
			sleep 3000
			SendChat("/r " tag1 " ��� ������� �� ��� �� ����� ����������� ��������.")
			sleep 3000
			SendChat("/r " tag1 " ��������� ������������ ������ ��� �������.")
			sleep 3000
			SendChat("/r " tag1 " ����� �����, ���������� ��� ������� ����� �������� �����.")
			sleep 1000
			addChatMessageEx("48D1CC", "��� - AHK: {FFFFFF}�����: {FF0000}/sc")
		}
	}
	else
	{
		AddChatMessageEx("48D1CC", "��� - AHK: {FFFFFF}�������: {48D1CC}/lec [1 - ������] [2 - ������]")
                return
	}
}
if (RegExMatch(chatInput, "^/fvig"))
{
	if (RegExMatch(chatInput, "/fvig ([0-9]{0,3}) (.*)", out))
	{
		RPN := RegExReplace(GetPlayerNameByid(out1), "_", " ")
		{
			SendChat("/r " tag1 " " RPN ", �������� �����. �������: " out2)
		}
	}
	else
	{
		AddChatMessageEx("48D1CC", "��� - AHK: {FFFFFF}�������: {48D1CC}/fvig [ID] [�������]")
                return
	}
}
return