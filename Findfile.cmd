@echo off
setlocal enabledelayedexpansion
if exist __items.list (del /f /q __items.list)
set SOURCE_DIR=%1
::echo SOURCE_DIR : %SOURCE_DIR%
if [%1]==[-h] goto help
if [%1]==[--help] goto help
if [%1]==[/?] goto help
if [%1] == [] goto help
if [%2] == [] echo "ERROR--Missing file specification"
if [%2] == [] goto help
set FILENAMES_TO_COPY=%2
set COPYFLAG=%3
set COPYLOC=%4
if (%4)==(.) set COPYLOC=%cd%
set PREPEND_FLAG=%5
set PREPEND_VAL=%6

set SearchPathString=%SOURCE_DIR%\%FILENAMES_TO_COPY%
::echo SearchPathString: %SearchPathString%

for /f "delims=" %%F IN ('dir /s /b %SearchPathString%') do (
	echo %%F
	echo "%%F" >> __items.list
)

set CTRUE="2"
if "%3"=="-copy" set CTRUE="1"
if "%3"=="-c" set CTRUE="1"
if %CTRUE%=="1" goto copytasks
goto end


:copytasks
if [%COPYLOC%] == [] echo "ERROR Please provide a location to copy the files"
if [%COPYLOC%] == [] goto help
if "%PREPEND_FLAG%"=="-p" goto prepend
if "%PREPEND_FLAG%"=="-prepend" goto prepend 
echo.
echo ----------------------------------------
echo Copying items
echo ----------------------------------------
for /F "tokens=*" %%i in (__items.list) do (
    xcopy /c /f /y %%i %COPYLOC%\
	)
echo.
echo ----------------------------------------
echo Finished copying items
echo ----------------------------------------
goto end

:prepend
if [%6] == [] echo "ERROR Please provide a prepend value"
if [%6] == [] goto help
echo.
echo ----------------------------------------
echo Prepending and Copying items
echo ----------------------------------------
for /F "tokens=*" %%i in (__items.list) do (
    xcopy /c /f /y %%i %COPYLOC%\PREPENDED_%PREPEND_VAL%\
	)

	for /f %%f in ('dir /b "%COPYLOC%\PREPENDED_%PREPEND_VAL%"') do (
	copy /a %COPYLOC%\PREPENDED_%PREPEND_VAL%\%%f /y %COPYLOC%\%PREPEND_VAL%_%%f
	)
	
	rmdir /s /q %COPYLOC%\PREPENDED_%PREPEND_VAL%

echo.
echo ----------------------------------------
echo Finished copying items
echo ----------------------------------------
goto end

:help
echo.
echo ####USAGE##########################################################
echo.
echo Findfile.cmd SOURCE_DIR FILENAMES [[-h ^| --help ^| /? ]]  
echo ^| [[-c ^| -copy] [CopyLocation]] [[-p ^| -prepend] PrependString] 
echo.
echo THIS WILL DISPLAY .TXT FILES FROM C:\FOLDER IN THE CONSOLE
echo.
echo       findfile C:\Folder *.txt
echo.
echo                    -or-
echo.
echo       findfile C:\Folder filename.txt
echo.
echo THIS WILL COPY RECURSIVELY .TXT FILES FROM C:\FOLDER TO 
echo SPECIFIED LOCATION BASED ON FILE EXTENSION
echo.
echo       findfile C:\Folder *.txt -c C:\CopiedTextFiles
echo.
echo					-or-
echo.
echo       findfile C:\Folder *.txt -c .\CopiedTextFiles
echo.
echo THIS WILL PREPEND .TXT FILES FROM C:\FOLDER WITH "PRE_"
echo.
echo       findfile C:\Folder *.txt -c C:\CopiedTextFiles -p pre_
echo.
echo					-or-
echo.
echo       findfile . *.txt -c .\CopiedTextFiles -p pre_
echo.
echo.           SAMPLE OUTPUT: pre_thisfile.txt
echo.
echo ###################################################################

goto veryend

:end
:: Clean up
if exist __items.list (del /f /q __items.list)

:veryend
endlocal
