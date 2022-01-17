REM   This expects Rad Studio (bds.exe) to be on the PATH.
REM   If this plugin is currently installed, the IDE will load it on
REM   build and thus block it from being overwritten. To avoid this we
REM   use a temporary registry key with the /r option. This will be a
REM   fresh temporary instance without the plugin installed.

bds -ns -b OpenInVim.dproj /r open_in_vim_builder