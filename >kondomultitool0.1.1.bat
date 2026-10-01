@echo off
setlocal EnableExtensions
title Kondo MultiTool 0.1.1
color 0B

:menu
cls
echo ============================================================
echo                  Kondo MultiTool 0.1.1
echo ============================================================
echo.
echo   [1] Nmap - Authorized Network Scanner
echo   [2] Wireshark - Packet Analyzer
echo   [3] HTTP Diagnostic
echo   [4] Network Information
echo   [5] DNS Lookup
echo   [6] Ping Test
echo   [7] Traceroute
echo   [8] Show Listening Connections
echo   [9] Exit
echo.
echo ============================================================
set /p choice=Select tool: 

if "%choice%"=="1" goto nmap
if "%choice%"=="2" goto wireshark
if "%choice%"=="3" goto httpdiag
if "%choice%"=="4" goto netinfo
if "%choice%"=="5" goto dns
if "%choice%"=="6" goto pingtest
if "%choice%"=="7" goto trace
if "%choice%"=="8" goto connections
if "%choice%"=="9" goto exit

goto menu

:nmap
cls
where nmap >nul 2>&1
if errorlevel 1 (
    echo Nmap was not found in PATH.
    echo Install Nmap and restart this tool.
    pause
    goto menu
)

echo ============================================================
echo NMAP - AUTHORIZED TARGETS ONLY
echo ============================================================
echo.
set /p target=Target hostname/IP: 

if "%target%"=="" goto menu

echo.
echo Running service discovery...
echo.
nmap -sT -sV "%target%"
echo.
pause
goto menu

:wireshark
cls
echo Starting Wireshark...

where wireshark >nul 2>&1
if not errorlevel 1 (
    start "" wireshark
    goto menu
)

if exist "%ProgramFiles%\Wireshark\Wireshark.exe" (
    start "" "%ProgramFiles%\Wireshark\Wireshark.exe"
    goto menu
)

if exist "%ProgramFiles(x86)%\Wireshark\Wireshark.exe" (
    start "" "%ProgramFiles(x86)%\Wireshark\Wireshark.exe"
    goto menu
)

echo.
echo Wireshark was not found.
pause
goto menu

:httpdiag
cls
echo ============================================================
echo HTTP DIAGNOSTIC
echo ============================================================
echo.
set /p url=URL: 

if "%url%"=="" goto menu

where curl >nul 2>&1
if errorlevel 1 (
    echo curl was not found.
    pause
    goto menu
)

echo.
echo Retrieving response headers...
echo.
curl --connect-timeout 10 --max-time 20 -I "%url%"
echo.
pause
goto menu

:netinfo
cls
echo ============================================================
echo NETWORK INFORMATION
echo ============================================================
echo.
ipconfig /all
echo.
pause
goto menu

:dns
cls
echo ============================================================
echo DNS LOOKUP
echo ============================================================
echo.
set /p hostname=Hostname: 

if "%hostname%"=="" goto menu

echo.
nslookup "%hostname%"
echo.
pause
goto menu

:pingtest
cls
echo ============================================================
echo PING TEST
echo ============================================================
echo.
set /p host=Hostname/IP: 

if "%host%"=="" goto menu

echo.
ping -n 4 "%host%"
echo.
pause
goto menu

:trace
cls
echo ============================================================
echo TRACEROUTE
echo ============================================================
echo.
set /p tracehost=Hostname/IP: 

if "%tracehost%"=="" goto menu

echo.
tracert "%tracehost%"
echo.
pause
goto menu

:connections
cls
echo ============================================================
echo LISTENING CONNECTIONS
echo ============================================================
echo.
netstat -ano
echo.
pause
goto menu

:exit
cls
echo Kondo MultiTool closed.
timeout /t 1 /nobreak >nul
endlocal
exit /b
