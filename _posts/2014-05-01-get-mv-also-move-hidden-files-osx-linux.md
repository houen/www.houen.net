---
layout: post
title: Get mv to also move hidden files in OSX and Linux
tags: [linux, osx, terminal, mv]
---

I love my terminal. I find it to be a more efficient tool for me to use when doing most things on my filesystem. However one thing has always bugged me: The inability to get mv to also move hidden files.

It turns out there is actually quite a simple way to get mv to also move hidden files that will work in both Mac OSX and Linux.  You simply change the shell options right before you use the move command, like so:

```shell
shopt -s dotglob && mv /everything/from/here/* /to/somehere/else/.
```

The above command will set the shell options to also include dotfiles in glob arguments (like the star argument we used above to move the files), and move the mv command (that we execute right after by chaining it with &&) will also include the dotfiles and everything else. So easy.
