@ECHO off
ECHO * ACCOUNTS *****************************************************************************************************************************************
ECHO.
WMIC useraccount list brief
NET users

ECHO.
ECHO * SERVICES *****************************************************************************************************************************************
ECHO.
WMIC service list brief

ECHO.
ECHO * PROCESSES ****************************************************************************************************************************************
ECHO.
WMIC process list brief
TASKLIST

ECHO.
ECHO * STARTUP ITEMS ***********************************************************************************************************************************
ECHO.
WMIC startup list brief

ECHO.
ECHO * NETWORK CONNECTIONS *****************************************************************************************************************************
ECHO.
NETSTAT -ano

ECHO.
ECHO * NETWORK ADAPTERS ********************************************************************************************************************************
ECHO.
wmic nic list brief

set /p trash="Press <ENTER> to exit."