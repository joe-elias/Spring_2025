# Unix Basics

Note: Much of this weeks materials are borrowed from the [Programing for Biology](http://programmingforbiology.org/) Course in Cold Spring Harbor Laboratory. The link will take you to the course schedule 
which can lead you to various bioinformatics lectures and problemsets. Also a great way to learn Python! 


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


You can open many Terminal windows at once. This is often helpful. A common way to work is to open your code editor in one window, run the code from another and view data and files in another.

### OK. I've Logged in.  What Now?


Mac terminal windows run **shell** called "zsh", **bash** for Windows. The shell is a loop that:
1. Prints a prompt
2. Reads a line of input from the keyboard
3. Parses the line into one or more commands
4. Executes the commands (which usually print some output to the terminal)
5. Go back step 1.


There are many different shells with bizarre names like **bash**, **sh**, **csh**, **tcsh**, **ksh**, and **zsh**.  The "sh" part means shell.  Each shell has slightly different syntax and features.

### Command Line Prompt


Most of bioinformatics is done by running command line software in a shell, so you should take some time to learn to use the shell effectively.


This is a command line prompt:

```
bush202>
```


This is another:

```
(~) 51%
```

This is another:

```
robda@LAPTOP-5VM2NF6A MINGW64 ~
$
```

What you see depends on how the system administrator has customized your login.  You can customize it yourself (but we won't go into that here)


The prompt tells you the shell is ready for you to type a command.  Most commands run almost instantly, but if you run a long command, the prompt will not reappear until it is finished and the system is ready to accept your next request.

### Issuing Commands


You type in a command and press the &lt;Enter&gt; key to execute it.  If the command has output, it will appear on the screen.  Example:

```
robda@LAPTOP-5VM2NF6A MINGW64 ~
$ ls -F
 AppData/                 ntuser.dat.LOG2
'Application Data'@       NTUSER.DAT{94aa1212-3972-11ef-af10-6c2f80253da1}.TM.blf
 Contacts/                NTUSER.DAT{94aa1212-3972-11ef-af10-6c2f80253da1}.TMContainer00000000000000000001.regtrans-ms
 Cookies@                 NTUSER.DAT{94aa1212-3972-11ef-af10-6c2f80253da1}.TMContainer00000000000000000002.regtrans-ms
 Documents/               ntuser.ini
 Downloads/               OneDrive/
 Favorites/               Pictures/
 IntelGraphicsProfiles/   PrintHood@
 Links/                   Recent@
'Local Settings'@        'Saved Games'/
 Music/                   Searches/
'My Documents'@           SendTo@
 NetHood@                'Start Menu'@
 NTUSER.DAT               Templates@
 ntuser.dat.LOG1          Videos/
robda@LAPTOP-5VM2NF6A MINGW64 ~
$
```
The command here is `ls -F`, which produces a listing of files and directories in the current directory.  Below its output, the command prompt appears again.

### Command Line Editing

Most shells offer command line editing.  Up until the moment you press \<Enter\>, you can go back over the command line and edit it using the keyboard.  Here are the most useful keystrokes:

- _Backspace_: Delete the previous character and back up one.
- _Left arrow_, right arrow: Move the text insertion point (cursor) one character to the left or right.
- _control-a (^a)_: Move the cursor to the beginning of the line. (Mnemonic: A is first letter of alphabet)
- _control-e (^e)_: Move the cursor to the end of the line. (Mnemonic: E for the End) (^z was already used to interrupt a command).
- _control-d (^d)_: Delete the character currently under the cursor. D=Delete.
- _control-k (^k)_: Delete the entire line from the cursor to the end. k=kill.  The line isn't actually deleted, but put into a temporary holding place called the "kill buffer". This is like cutting text
- _control-y (^y)_: Paste the contents of the kill buffer onto the command line starting at the cursor.  y=yank. This is like paste.
- _Up arrow, down arrow_: Move up and down in the command history.  This lets you rerun previous commands, possibly modifying them before you do.

There are also some useful shell commands you can issue:  

- `history` Show all the commands that you have issued recently, nicely numbered.
- `!<number>` Reissue an old command, based on its number (which you can get from `history`).
- `!!` Reissue the last command.
- `!<partial command string>`: Reissue the previous command that began with the indicated letters.  For example, `!l` (the letter el, not a number 1) would reissue the`ls -F` command from the earlier example.
- *control-r (^r)*: enter string and search through history for commands that match it. This is really useful.

**zsh** offers automatic command completion and spelling correction.  If you type part of a command and then the <tab> key, it will prompt you with all the possible completions of the command.  For example:

```
robda@LAPTOP-5VM2NF6A MINGW64 ~
$ fd<tab><tab>
fdBth.dll       FdDevQuery.dll  fdeploy.dll     fdPnp.dll       fdProxy.dll     fdSSDP.dll      fdWNet.dll
fdBthProxy.dll  fde.dll         fdPHost.dll     fdprint.dll     FDResPub.dll    fdWCN.dll       fdWSD.dll

robda@LAPTOP-5VM2NF6A MINGW64 ~
$ fd
```
If you hit tab after typing a command, but before pressing \<Enter\>, **zsh** will prompt you with a list of file names. This is because many commands operate on files.

### Wildcards

You can use wildcards when referring to files.  `*` stands for zero or more characters.  `?` stands for any single character.  For example, to list all files with the extension ".txt", run `ls` with the wildcard pattern "*.txt"

```
robda@LAPTOP-5VM2NF6A MINGW64 ~/hacky
$ ls
alien_cookbook.txt  chris_hair_routine.txt  how_to_fly.txt  how_to_stop_flying.txt  sexy_hulk.jpeg
robda@LAPTOP-5VM2NF6A MINGW64 ~/hacky
$ ls *.txt
alien_cookbook.txt  chris_hair_routine.txt  how_to_fly.txt  how_to_stop_flying.txt
```

There are several more advanced types of wildcard patterns that you can read about in the **zsh** manual page.  For example, if you want to match files that begin with the characters "a" or "c" and end with ".txt", you can put both characters inside square brackets `[ac]` as part of the wildcard pattern. Here's an example

```
robda@LAPTOP-5VM2NF6A MINGW64 ~/hacky
$ ls [ac]*.txt
alien_cookbook.txt  chris_hair_routine.txt
```

You can also search for a range of characters e.g. `[a-e]` or `[1-5]`.

## Directories

A computer comes with a place to store scripts, data, images, OS, and other files. It used to be floppy disks, then hard drives and these days it's often a solid state drive (SSD). Let's talk about how the storage is organized to help you find what you are working on. Directories or folders are created inside other directories. One directory is special. This is the **root directory** because it is not inside any other directories (it's written `/`). Files that go together are created inside a directory to keep them organized. This creates a structure that can be drawn like a branching tree. We find it clearer to turn it upside down to look like branching roots. 

**Example diagram of a Linux directory structure starting from the root directory**

![image](https://github.com/user-attachments/assets/ea6c7dd3-4b45-42d5-856e-f9f140dc9571)

### The Home Directory '~'


When you first log in, you'll be in your personal directory (or folder), called the **home directory**. This directory has the same name as your login name, and on macOS is located inside the directory `/Users`.  (On Linux, it's typically in `/home`). If your username is `robda`, your home directory would (probably) be `/Users/robda`. This is a filepath or a path. Unix if full of abbreviations to save on typing common things. The shell allows you to abbreviate it as `~username` (where "username" is your user name or someone elses), or simply as `~`. The weird character (called "tilde" or "twiddle") is at the upper left corner of your keyboard. The `$HOME` variable is usually set to your home directory. Note: Windows users might have an extra `/c/Users` in from of their path. The letter depends on the name of the hard drive your are working out of.

In your home directory, you have permission to save, delete, open and move files and other directories. In general, you can read but not write or modify files elsewhere in the system.

To see what is in your home directory, issue the command `ls` for list directory contents

```
 AppData/                 ntuser.dat.LOG2
'Application Data'@       NTUSER.DAT{94aa1212-3972-11ef-af10-6c2f80253da1}.TM.blf
 Contacts/                NTUSER.DAT{94aa1212-3972-11ef-af10-6c2f80253da1}.TMContainer00000000000000000001.regtrans-ms
 Cookies@                 NTUSER.DAT{94aa1212-3972-11ef-af10-6c2f80253da1}.TMContainer00000000000000000002.regtrans-ms
 Documents/               ntuser.ini
 Downloads/               OneDrive/
 Favorites/               Pictures/
 hacky/                   PrintHood@
 IntelGraphicsProfiles/   Recent@
 Links/                  'Saved Games'/
'Local Settings'@         Searches/
 Music/                   SendTo@
'My Documents'@          'Start Menu'@
 NetHood@                 Templates@
 NTUSER.DAT               Videos/
 ntuser.dat.LOG1
```
You can modify the way a command works with switches. These are single letters typed after a dash `-`. The case is important. So `ls -aF` lists all (`a`) files including hidden filenames that start with a `.` with fancy formatting turned on (`F`) such that a`/` is added to the end of directory names.

```
robda@LAPTOP-5VM2NF6A MINGW64 ~
$ ls -aF
 ./                       NTUSER.DAT
 ../                      ntuser.dat.LOG1
 .ssh/                    ntuser.dat.LOG2
 .vscode/                 NTUSER.DAT{94aa1212-3972-11ef-af10-6c2f80253da1}.TM.blf
 AppData/                 NTUSER.DAT{94aa1212-3972-11ef-af10-6c2f80253da1}.TMContainer00000000000000000001.regtrans-ms
'Application Data'@       NTUSER.DAT{94aa1212-3972-11ef-af10-6c2f80253da1}.TMContainer00000000000000000002.regtrans-ms
 Contacts/                ntuser.ini
 Cookies@                 OneDrive/
 Documents/               Pictures/
 Downloads/               PrintHood@
 Favorites/               Recent@
 hacky/                  'Saved Games'/
 IntelGraphicsProfiles/   Searches/
 Links/                   SendTo@
'Local Settings'@        'Start Menu'@
 Music/                   Templates@
'My Documents'@           Videos/
 NetHood@
```
> Don't go deleting the hidden files. Many of them are essential configuration files for commands and other programs.  For example, the `.zshrc` file contains configuration information for the **zsh** shell. You can edit it (a bit later, when you know what you're doing) in order to change things like the command prompt and command search path.

### Creating and Changing to Directories

We dont really want to fill up our home directory with a bunch of files that are unrelated, so lets use `mkdir` (for make directory) to create new directory to work out of:
```
robda@LAPTOP-5VM2NF6A MINGW64 ~
$ mkdir hackyhours
```

You can move around from directory to directory using the `cd` command (for change directory).  Give the name of the directory you want to move to, or give no name to move back to your home directory.  Use the `pwd` command (print working directory) to see where you are (or, if configured, this information will appear in the prompt):

```
robda@LAPTOP-5VM2NF6A MINGW64 ~
$ cd hackyhours/

robda@LAPTOP-5VM2NF6A MINGW64 ~/hackyhours
$ pwd
/c/Users/robda/hackyhours

robda@LAPTOP-5VM2NF6A MINGW64 ~/hackyhours
$ cd

robda@LAPTOP-5VM2NF6A MINGW64 ~
$ ls
 AppData/                 ntuser.dat.LOG1
'Application Data'@       ntuser.dat.LOG2
 Contacts/                NTUSER.DAT{94aa1212-3972-11ef-af10-6c2f80253da1}.TM.blf
 Cookies@                 NTUSER.DAT{94aa1212-3972-11ef-af10-6c2f80253da1}.TMContainer00000000000000000001.regtrans-ms
 Documents/               NTUSER.DAT{94aa1212-3972-11ef-af10-6c2f80253da1}.TMContainer00000000000000000002.regtrans-ms
 Downloads/               ntuser.ini
 Favorites/               OneDrive/
 hacky/                   Pictures/
 hackyhours/              PrintHood@
 IntelGraphicsProfiles/   Recent@
 Links/                  'Saved Games'/
'Local Settings'@         Searches/
 Music/                   SendTo@
'My Documents'@          'Start Menu'@
 NetHood@                 Templates@
 NTUSER.DAT               Videos/
```
> Each directory contains two special hidden directories named `.` and `..`. The first, `.` refers always to the current directory. `..` refers to the parent directory.  This lets you move upward in the directory hierarchy like this:
```
robda@LAPTOP-5VM2NF6A MINGW64 ~/hackyhours
$ cd ..

robda@LAPTOP-5VM2NF6A MINGW64 ~
$
```
> and do fancy stuff like this:
```
robda@LAPTOP-5VM2NF6A MINGW64 ~
$ cd hackyhours/../Documents/
```
> The latter command moved us down one level to `hackyhours`, then back up a level via the `..`, and into the `Documents` directory in the home `~` directory.

If you get lost, the `pwd` command prints out the full path to the current directory:
```
robda@LAPTOP-5VM2NF6A MINGW64 ~/Documents
$ pwd
/c/Users/robda/Documents
```

## Essential Unix Commands


With the exception of a few commands that are built directly into the shell (e.g. `history`, `for`, `if`), all Unix commands are actually executable programs.  When you type the name of a command, the shell will search through all the directories listed in the `$PATH` environment variable for an executable of the same name.  If found, the shell will execute the command. Otherwise, it will give a "command not found" error.

Most commands live in `/bin`, `/sbin`, `/usr/bin`, `/usr/sbin/` or `/usr/local/bin`. You can use the `which` command to find a program's location, e.g., `which ls` may show `/bin/ls`.

### Getting Information About Commands


The `man` command will give a brief synopsis of a command. Git Bash doesn't include the `man` function however, we can use the `--help` argument for the same result. Let's get information about the command `wc`

```
robda@LAPTOP-5VM2NF6A MINGW64 ~
$ wc --help
Usage: wc [OPTION]... [FILE]...
  or:  wc [OPTION]... --files0-from=F
Print newline, word, and byte counts for each FILE, and a total line if
more than one FILE is specified.  A word is a non-zero-length sequence of
characters delimited by white space.

With no FILE, or when FILE is -, read standard input.

The options below may be used to select which counts are printed, always in
the following order: newline, word, character, byte, maximum line length.
  -c, --bytes            print the byte counts
  -m, --chars            print the character counts
  -l, --lines            print the newline counts
      --files0-from=F    read input from the files specified by
                           NUL-terminated names in file F;
                           If F is - then read names from standard input
  -L, --max-line-length  print the maximum display width
  -w, --words            print the word counts
      --help     display this help and exit
      --version  output version information and exit

GNU coreutils online help: <https://www.gnu.org/software/coreutils/>
Full documentation <https://www.gnu.org/software/coreutils/wc>
or available locally via: info '(coreutils) wc invocation'
```

### Downloading files

The most common commands used to download files from anywhere online, given a link, are `wget` and `curl`. 

Lets use whichever command is available in our bash shell to download a short story by Philip K. Dick into the `hackyhour` directory.

```
cd hackyhour

curl -O https://raw.githubusercontent.com/BinghamtonBioHackyHours/Spring_2025/refs/heads/main/data/week_03/the_eyes_have_it.txt

wget https://raw.githubusercontent.com/BinghamtonBioHackyHours/Spring_2025/refs/heads/main/data/week_03/the_eyes_have_it.txt
```
Note '-O' is the letter O not the number Zero 0

### Arguments and Command Line Switches 

Many commands take arguments.  Arguments are often the names of one or more files to operate on.  Most commands also take command line "switches" or "options", which fine-tune what the command does.  Some commands recognize "short switches" that consist of a minus sign `-` followed by one or more single characters, while others recognize "long switches" consisting of two minus signs `--` followed by a whole word. 


The `wc` (word count) program is an example of a command that recognizes both long and short options.  You can pass it the single`-c`,  `-w` and/or `-l` options (or combinations of them) to count the characters, words, and lines in a text file, respectively.  Or you can use the longer but more readable `--chars`,  `--words` or `--lines` options.  Both these examples count the number of characters and lines in the text file `/var/log/messages`:

```
robda@LAPTOP-5VM2NF6A MINGW64 ~/hacky
$ wc -c -l the_eyes_have_it.txt
  76 6130 the_eyes_have_it.txt

robda@LAPTOP-5VM2NF6A MINGW64 ~/hacky
$ wc --chars --lines the_eyes_have_it.txt
  76 6040 the_eyes_have_it.txt
```

You can cluster one-character switches by concatenating them together, as shown in this example:

```
robda@LAPTOP-5VM2NF6A MINGW64 ~/hacky
$ wc -cl the_eyes_have_it.txt
  76 6130 the_eyes_have_it.txt
```

## Useful Commands

Here are some commands that are used extremely frequently.  Use `man` or `--help` to learn more about them.  Some of these commands may be useful for solving the problem set ;-)

### Manipulating  Directories

| Command | Description                                                  |
| ------- | ------------------------------------------------------------ |
| `ls`    | Directory listing.  Most frequently used as `ls -F` (decorated listing), `ls -l` (long listing), `ls -a` (list all files). |
| `mv`    | Rename or move a file or directory.                          |
| `cp`    | Copy a file. `cp -r` (recursively) to copy directories       |
| `rm`    | Remove (delete) a file. `rm -rf olddata.tsv`                 |
| `mkdir` | Make a directory                                             |
| `ln`    | Create a symbolic or hard link. `ln -s` makes a symbolic (sym) link |
| `chmod` | Change the permissions of a file or directory.               |


### Reading files

| Command           | Description                                                  |
| ----------------- | ------------------------------------------------------------ |
| `cat`             | Concatenate program.  Can be used to concatenate multiple files together into a single file, or, much more frequently, to view the contents of a file or files in the terminal. |
| `more`            | Scroll through a file page by page.  Very useful when viewing large files.  Works even with files that are too big to be opened by a text editor. |
| `less`            | A version of `more` with more features.                      |
| `head`            | View the first few lines of a file.  You can control how many lines to view `head -3` prints the first three lines. |
| `tail`            | View the end of a file.  You can control how many lines to view.  You can also use `tail -f` to view a file that you are writing to. |

### Analyzing, processing files
| Command | Description                                                  |
| ------- | ------------------------------------------------------------ |
| `wc`              | Count words, lines and/or characters in one or more files.   |
| `sort`            | Sort the lines in a file alphabetically or numerically (-g or -n) in reverse order (-r). |
| `uniq`            | Remove duplicated lines in a file.                           |
| `cut`             | Remove columns from each line of a file or files.            |
| `grep`            | Filter a file for lines matching a specified pattern.  Can also be reversed to print out lines that don't match the specified pattern. |
| `gzip` (`gunzip`) | Compress (uncompress) a file.                                |
| `tar`             | Archive or unarchive an entire directory into a single file. |

### Editing files
| Command | Description                                                  |
| ------- | ------------------------------------------------------------ |
| `tr`              | Substitute one character for another.  Also useful for deleting characters. |
| `nano`            | Very basic and easy to use text editor |
| `emacs`           | Run the Emacs text editor (good for experts).                |
| `vi`              | Run the vi text editor (confusing even for experts).         |
| `echo`            | print text to the screen. E.g. `echo 'Hello World!'` |


### Connecting to other computers

| Command                | Description                                                  |
| ---------------------- | ------------------------------------------------------------ |
| `ssh`                  | A secure (encrypted) way to log into machines.               |
| `scp`                  | A secure way to copy (cp) files to and from remote machines. |

### Standard I/O and Redirection


Unix commands print output to the terminal (screen) for you to see, and accept input from the keyboard (that is, from _you_!)


Every Unix program starts out with three connections to the outside world.  These connections are called "streams", because they act like a stream of information (metaphorically speaking):


| Stream Name     | Description                                                  |
| --------------- | ------------------------------------------------------------ |
| standard input  | This is initially attached to the keyboard.  When the program reads from standard input, it reads whatever text you type in. |
| standard output | This stream is initially attached to the terminal. Anything the program prints to this stream appears in your terminal window. |
| standard error  | This stream is also initially attached to the terminal. It is a separate stream intended for printing error messages. |

The word "initially" might lead you to think that standard input, output, and error can somehow be detached from their starting places and reattached somewhere else.  And you'd be right.  You can attach one or more of these three streams to a file, a device, or even to another program.  This sounds esoteric, but it is actually very useful.

### A Simple Example


The `wc` program counts lines, characters, and words in data sent to its standard input.  You can use it interactively like this:

```
robda@LAPTOP-5VM2NF6A MINGW64 ~/hacky
$ wc
Grad School Lament
Oh, woe is me, a grad stuck tight
Drowning in work, awake all night
Reviewer Two just crushed my soul
My stipend's smaller than Billy Joel
My data's a mess, my patience is thin,
Is crying in a lab a measurable sin?
^d                    # ** NOTE - this is ctrl-d which you type, but no output shows up 
                      # in terminal window
      7      45     234
```
In this example, I ran the `wc` program.  It waited for me to type in the most beautiful poem.  When I was done, I typed the END-OF-FILE character, control-d (^d for short).  `wc` then printed out three numbers indicating the number of lines (7), words (25), and characters (234) in the input.

More often, you'll want to count the number of lines in a big file and save the results in another file. We'll see this in two steps. First, we send the output of `wc` to stdout. In the second command, we _redirect_ stdout from `wc` to a file with the `>` symbol.

```
robda@LAPTOP-5VM2NF6A MINGW64 ~/hacky
$ wc the_eyes_have_it.txt
  76 1092 6130 the_eyes_have_it.txt

robda@LAPTOP-5VM2NF6A MINGW64 ~/hacky
$ wc the_eyes_have_it.txt > count.txt
```
Now if you `cat` the file _count.txt_, you'll see that the data has been recorded.

```
robda@LAPTOP-5VM2NF6A MINGW64 ~/hacky
$ cat count.txt
  76 1092 6130 the_eyes_have_it.txt
```

### Standard I/O and Pipes


The coolest thing about the Unix shell is its ability to chain commands together into mini pipelines.  Here's an example:

```
robda@LAPTOP-5VM2NF6A MINGW64 ~/hacky
$ grep arm the_eyes_have_it.txt | wc -l
6
```
There are two commands here. `grep` searches a file or standard input for lines containing a particular string.  Lines which contain the string are printed to standard output.  `wc -l` is the familiar word count program, which counts words, lines, and characters in a file or standard input.  The `-l` command line option instructs `wc` to print out just the line count.  The `|` character, which is known as a "pipe", connects the two commands together so that the standard output of `grep` becomes the standard input of `wc`. Think of pipes connecting streams of flowing data. 

What does this pipe do?  It prints out the number of lines in which the string "arm" appears in the file `the_eyes_have_it.txt`.
