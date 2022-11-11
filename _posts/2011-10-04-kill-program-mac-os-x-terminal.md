---
layout: post
title: Kill a program from the Mac OS X terminal command line
description: To kill program Mac OS X terminal on Leopard / Snow leopard / Lion do the following commands. The program will shut down immediately
img_path: /assets/2011-10-04-kill-program-mac-os-x-terminal/img.png
img_width: 381
img_height: 298
tags: [kill process, mac, mac osx, process]
---

Even though OS X is a pleasure to work with, we have all had a program or process freeze up. It won’t quit by using “Force quit”. What do you do now? Fortunately, this can be solved quite easily. 

To kill a program on Mac OS X terminal on Leopard or higher (Snow leopard / Lion / Monterey etc), do the following commands:

## Get the ID of the program
```shell
ps -A | grep [name of program you want to close]
```

## Kill the program
This will give you the number of the processes found (if any). Now just close them with this command

```shell
kill -9 [process id]
```

So, for example to kill my activity monitor program

```shell
ps -A | grep activity
39049 ??         0:01.81 /Applications/Utilities/Activity Monitor.app/Contents/MacOS/activitymonitord
kill -9 39049
```

Now the offending program will shut down immediately, no matter what it was doing. This is, however, a last resort. You will lose any unsaved changes.

What happens behind the scenes when you kill the program is a bit different from regular operations. Normally, the operating system asks the program nicely to go away. With the above kill command, it simply shuts it down immediately without asking or telling it anything. There you go. Gone.

Has this post got you interested? Would you like to learn how to do more interesting stuff in OS X’s terminal than just kill a program? Then read [these 10 commands](http://mac.tutsplus.com/tutorials/terminal/10-terminal-commands-that-every-mac-user-should-know/). Even more interested? The OS X terminal is built on top of bash, and you can read more about it [in this tutorial](http://tldp.org/HOWTO/Bash-Prog-Intro-HOWTO.html).
