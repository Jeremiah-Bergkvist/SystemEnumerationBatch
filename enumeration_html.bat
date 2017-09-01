@echo off
setlocal enableDelayedExpansion

echo ^<html^> > survey.html
echo ^<head^> >> survey.html
echo ^<title^>System Enumeration Survey^</title^> >> survey.html
echo ^</head^> >> survey.html
echo ^<body^> >> survey.html
echo ^<a name="top"^>^</a^> >> survey.html
echo ^<H3^>^<a href="#netstat"^>netstat -ano Results^</a^>^</H3^> >> survey.html
echo ^<H3^>^<a href="#service"^>All Services^</a^>^</H3^> >> survey.html
echo ^<H3^>^<a href="#process"^>Current Running Processes^</a^>^</H3^> >> survey.html
echo ^<H3^>^<a href="#startup"^>Startup Application Results^</a^>^</H3^> >> survey.html
echo ^<H3^>^<a href="#nic"^>Network Interface Cards^</a^>^</H3^> >> survey.html
echo ^</body^> >> survey.html
echo ^</html^> >> survey.html

echo ^<a name="netstat"^>^</a^> >> survey.html
echo ^<p^>^<a href="#top"^>Return to top.^</a^>^</p^> >> survey.html

:: Format netstat output into html table
set light=TRUE

echo ^<html^> >> survey.html
echo ^<H3^>Results from netstat -ano^</H3^> >> survey.html
echo ^<table border="1"\^> >> survey.html
echo ^<tr style="background-color:#a0a0ff;font:10pt Tahoma;font-weight:bold;" align="left"\^> >> survey.html
echo ^<td^>Proto^</td^> >> survey.html
echo ^<td^>Local Address^</td^> >> survey.html
echo ^<td^>Foreign Address^</td^> >> survey.html
echo ^<td^>State^</td^> >> survey.html
echo ^<td^>PID^</td^> >> survey.html
echo ^</tr^> >> survey.html

for /F "tokens=*" %%a in ( 'netstat -ano' ) do (
	call :flipvar
	if NOT "%%a" == "Active Connections" ( 
		if NOT "%%a" == "Proto  Local Address          Foreign Address        State           PID" (
			for %%b in ( %%a ) do ( echo ^<td^>%%b^</td^> >> survey.html )
			echo ^</tr^> >> survey.html
		)
	)
)
echo ^</table^> >> survey.html
echo ^</html^> >> survey.html
goto END

:flipvar
if "%light%" == "TRUE" (
	echo ^<tr style="background-color:#e0f0f0;font:10pt Tahoma;"^> >> survey.html
	set light=FALSE
) else (
	echo ^<tr style="background-color:#f0f0f0;font:10pt Tahoma;"^> >> survey.html
	set light=TRUE
)
goto :EOF
:END

echo ^<a name="service"^>^</a^> >> survey.html
echo ^<p^>^<a href="#top"^>Return to top.^</a^>^</p^> >> survey.html
WMIC service list brief /format:htable | more >> survey.html

echo ^<a name="process"^>^</a^> >> survey.html
echo ^<p^>^<a href="#top"^>Return to top.^</a^>^</p^> >> survey.html
WMIC process list brief /format:htable | more  >> survey.html

echo ^<a name="startup"^>^</a^> >> survey.html
echo ^<p^>^<a href="#top"^>Return to top.^</a^>^</p^> >> survey.html
WMIC startup list brief /format:htable | more  >> survey.html

echo ^<a name="nic"^>^</a^> >> survey.html
echo ^<p^>^<a href="#top"^>Return to top.^</a^>^</p^> >> survey.html
WMIC nic list brief /format:htable | more  >> survey.html

survey.html
