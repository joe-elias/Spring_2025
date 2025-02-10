# Unix Basics and Problem Set

Note: Much of this weeks materials are borrowed from [Programing for Biology](http://programmingforbiology.org/) Course in Cold Spring Harbor Laboratory. The link will take you to the course schedule 
which can lead you to various bioinformatics lectures and problemsets. Also a great way to learn Python! 

Useful commands
=========================

| command         | description                              |
| --------------- | ---------------------------------------- |
| `man <command>` | manual page for the command e.g. `man ls` to get the man page for `ls` |
| `cd`            | change directory                         |
| `cp`            | copy files                               |
| `curl`          | transfer a URL |
| `cut`           | cut out selected portions of each line of a file |
| `date`          | returns the current date and time        |
| `grep`          | filnds the lines that contain a pattern  |
| `head`          | prints the top few lines to the terminal window |
| `ls`            | list directory contents                  |
| `mkdir`         | make a directory                         |
| `mv`            | move files                               |
| `pwd`           | return working directory name            |
| `rm`            | remove, or delete files and directories. Use caution, it is easy to delete more that you want. |
| `scp`           | remote secure copy                       |
| `sort`          | sorts the lines                          |
| `ssh`           | remote login                             |
| `tail`          | prints the last few lines to the terminal window |
| `uniq`          | prints the unique lines                  |
| `wc`            | counts the number of lines, characters and words |
| `~`             | shortcut for your home directory         |


## What is the Command Line?

Underlying the pretty Mac OSX and Graphical User Interface (GUI) is the operating system (OS). It's based on BSD (Berkeley Standard Distribution), which is a version of Unix. Linux is pretty similar and also a very common OS in bioinformatics and you'll run into dialects by Red Hat, Ubuntu, Git and others.

The command line gives you access to the internals of the OS, and is also a convenient way to write custom software and scripts.  

Most bioinformatics tools are written to run on the command line and have no Graphical User Interface. In many cases, a command-line tool is more versatile than a graphical tool because you can easily combine command line tools into automated scripts that accomplish custom tasks sequentially without human intervention.  

The Unix OS is complicated and there are always more things to learn about it. We'll just cover enough to get us going.

## Getting Started

### Bringing up the command line 

#### Mac
Use the Finder to navigate to _Applications->Utilities_ and double-click on the _Terminal_ application. This will bring up a window like the following:

![image](https://github.com/user-attachments/assets/16c913c0-24a4-425a-abcd-c4739692d1f4)


#### Windows
Once downloaded, open the Git Bash application

![image](https://github.com/user-attachments/assets/b1ff847d-603c-4a3d-af0a-383da8f529c2)




