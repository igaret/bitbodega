@echo off
:parser
	if [%1] == [] (	echo usage: && echo ^	%0 [args] && echo ^	available args: [linux^|windows] [reboot] && echo ^		reboot being optional && goto :eof )
	if [%1] == [linux] ( goto :linux ) else ( goto :windows	)
:linux
::	c:\walls\bin\cp.exe L:\\boot\\grub\\grub-linux.cfg  L:\\boot\\grub\\grub.cfg
	xcopy /f L:\boot\grub\grub-linux.cfg  L:\boot\grub\grub.cfg
	goto :reboot
:windows
::	c:\walls\bin\cp.exe L:\\boot\\grub\\grub-windows.cfg  L:\\boot\\grub\\grub.cfg
	xcopy /f L:\boot\grub\grub-windows.cfg  L:\boot\grub\grub.cfg
	goto :reboot
:reboot
	if [%2] == [reboot] ( shutdown -f -r -t 0 && goto :eof ) else ( goto :eof )
:eof
