@echo off


:: ask the user for the ISO path
set /p ISOPath=Where is the ISO located? 
:: figure this out me. thanks
::if not exist %ISOPath% (
::    echo failed to continue (error 1; ISO file does not exist)
::    timeout 8
::    exit
::)



powershell Mount-DiskImage -ImagePath %ISOPath%
:part2
md C:\temp

set /p DriveLetter=Please enter the drive letter for the Windows 11 image: 


if exist "%DriveLetter%\sources\install.esd" (
    DISM /Export-Image /SourceImageFile:%DriveLetter%:\sources\install.esd /SourceIndex:6 /DestinationImageFile:%DriveLetter%\sources\install.wim /Compress:Max /CheckIntegrity
)
if not exist "%DriveLetter%\sources\install.wim" (
    echo failed to continue (error 2; no Windows WIM file)
    timeout 8
	exit
)
xcopy.exe /E /I /H /R /Y /J %DriveLetter% c:\temp >nul