REM   This will build (if not already) the DLL plugin and tell Delphi where to find
REM   it via an entry in the registry. Make sure to close all running Rad Studio
REM   instances before running this.

REM   This page:
REM   "http://www.davidghoyle.co.uk/WordPress/?page_id=1717"
REM   has a list of registry keys for the various Rad Studio versions.

if not exist "OpenInVim.dll" (
  call build.bat
)

for /f "tokens=1* usebackq" %%a in (`reg query "HKEY_CURRENT_USER\Software\Borland\Delphi"`) do @(
  reg add "%%a\Experts" /v "Open in Vim" /t REG_SZ /d "%~dp0\OpenInVim.dll"
)

for /f "tokens=1* usebackq" %%a in (`reg query "HKEY_CURRENT_USER\Software\Borland\BDS"`) do @(
  reg add "%%a\Experts" /v "Open in Vim" /t REG_SZ /d "%~dp0\OpenInVim.dll"
)

for /f "tokens=1* usebackq" %%a in (`reg query "HKEY_CURRENT_USER\Software\CodeGear\BDS"`) do @(
  reg add "%%a\Experts" /v "Open in Vim" /t REG_SZ /d "%~dp0\OpenInVim.dll"
)

for /f "tokens=1* usebackq" %%a in (`reg query "HKEY_CURRENT_USER\Software\Embarcadero\BDS"`) do @(
  reg add "%%a\Experts" /v "Open in Vim" /t REG_SZ /d "%~dp0\OpenInVim.dll"
)
