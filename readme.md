# Open in Vim

This is a Delphi Rad Studio plugin that adds the keyboard shortcut

	Ctrl+Shift+V

to the IDE to open the current file at the current location in vim.
It expects `vim.exe` to be on the path.

# Install

Close all running Rad Studios and run `install.bat`. This will call `build.bat`
automatically, thus building the plugin DLL, and install it by writing the
Windows registry.

To remove the plugin, call `uninstall.bat`.

