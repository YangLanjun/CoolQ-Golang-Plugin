@echo off

:: SET DevDir=D:\CoolQ Pro\dev\me.cqp.tnze.demo

@REM echo Setting proxy
@REM SET GOPROXY=https://goproxy.cn

echo Checking go installation...
go version > nul
IF ERRORLEVEL 1 (
	echo Please install go first...
	goto RETURN
)

echo Checking gcc installation...
gcc --version > nul
IF ERRORLEVEL 1 (
	echo Please install gcc first...
	goto RETURN
)

@REM echo Checking cqcfg installation...
@REM cqcfg -v
@REM IF ERRORLEVEL 1 (
@REM 	echo Install cqcfg...
@REM 	go get github.com/Tnze/CoolQ-Golang-SDK/tools/cqcfg
@REM 	IF ERRORLEVEL 1 (
@REM 		echo Install cqcfg fail
@REM 		goto RETURN
@REM 	)
@REM )
@REM
@REM echo Generating app.json ...
@REM go generate
@REM IF ERRORLEVEL 1 (
@REM 	echo Generate app.json fail
@REM 	goto RETURN
@REM )
@REM echo.

echo Setting env vars..
SET CGO_LDFLAGS=-Wl,--kill-at
SET CGO_ENABLED=1
SET GOOS=windows
SET GOARCH=386

echo Building app.dll ...
go build -ldflags "-s -w" -buildmode=c-shared -o app.dll
IF ERRORLEVEL 1 (pause) ELSE (echo Build success!)

if defined DevDir (
    echo Copy app.dll and app.json ...
    for %%f in (app.dll,app.json) do move %%f "%DevDir%\%%f" > nul
    IF ERRORLEVEL 1 pause
)

exit /B

:RETURN
pause
exit /B
