@echo off
setlocal enableDelayedExpansion

:: Format netstat output into html table
set light=TRUE

echo ^<html^>
echo ^<H3^>Results from netstat -ano^</H3^>
echo ^<table border="1"\^>
echo ^<tr style="background-color:#a0a0ff;font:10pt Tahoma;font-weight:bold;" align="left"\^>
echo ^<td^>Proto^</td^>
echo ^<td^>Local Address^</td^>
echo ^<td^>Foreign Address^</td^>
echo ^<td^>State^</td^>
echo ^<td^>PID^</td^>
echo ^</tr^>

for /F "tokens=*" %%a in ( 'netstat -ano' ) do (
	call :flipvar
	if NOT "%%a" == "Active Connections" ( 
		if NOT "%%a" == "Proto  Local Address          Foreign Address        State           PID" (
			for %%b in ( %%a ) do ( echo ^<td^>%%b^</td^> )
			echo ^</tr^>
		)
	)
)
echo ^</table^>
echo ^</html^>
goto END

:flipvar
if "%light%" == "TRUE" (
	echo ^<tr style="background-color:#e0f0f0;font:10pt Tahoma;"^>
	set light=FALSE
) else (
	echo ^<tr style="background-color:#f0f0f0;font:10pt Tahoma;"^>
	set light=TRUE
)
goto :EOF
:END