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

# Modify

To change the keyboard shortcut or the way vim (or any editor of your choice)
is opened, edit the file

	OpenInVim.dpr

At the top of this file you find the code that you need to edit.

If you want to remove the Vim part altogether, you should find and replace
all instances of "OpenInVim" and "Open in Vim" throughout all the files.

