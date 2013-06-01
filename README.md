vim
===

This vim solution is used accross multiple machines.    I'm not allowed to create links to any file in program files, so I currently
don't have a way to sync in github in my work computer, as I don't
have admin privileges to this directory consistently (company policy).
So I'm working around this issue by having a shortcut in the program
files vim directory to a git repository folder in my user path.  Here
is where I have the actual git folder. 

In my local computer the story is different.  I can do whatever I want
as an admin there, so it's easier to create links and mappings.

This is my attempt to sync vim configuration files accross computers.

Installing on Windows
=====================

Assuming vim is installed in 'c:/Program Files/Vim'

1. mkdir %USERPROFILE%\vim
2. mkdir %USERPROFILE%\vim\vimfiles
3. Move whatever is inside the vimfiles original directory (Program Files) to the vimfiles directory just created.
4. Move the _vimerc file from Program Files to %USERPROFILE%\vim
5. cd 'c:/Program Files/Vim'
6. mklink _vimrc %USERPROFILE%\vim\\_vimrc
7. open gvim and run :BundleInstall!
