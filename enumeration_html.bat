@echo off

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
call netstat_html.bat >> survey.html

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