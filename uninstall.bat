REM   This will uninstall the plugin from all installed Delphi versions.

for /f "tokens=1* usebackq" %%a in (`reg query "HKEY_CURRENT_USER\Software\Borland\Delphi"`) do (
  reg delete "%%a\Experts" /v "Open in Vim"
)

for /f "tokens=1* usebackq" %%a in (`reg query "HKEY_CURRENT_USER\Software\Borland\BDS"`) do (
  reg delete "%%a\Experts" /v "Open in Vim"
)

for /f "tokens=1* usebackq" %%a in (`reg query "HKEY_CURRENT_USER\Software\CodeGear\BDS"`) do (
  reg delete "%%a\Experts" /v "Open in Vim"
)

for /f "tokens=1* usebackq" %%a in (`reg query "HKEY_CURRENT_USER\Software\Embarcadero\BDS"`) do (
  reg delete "%%a\Experts" /v "Open in Vim"
)
