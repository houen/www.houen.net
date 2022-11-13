---
layout: post
tags: [google chrome devtools, javascript]
title: "Turn off Javascript in Google Chrome using DevTools"
img_path: "/assets/2022-06-16-turn-off-javascript-in-google-chrome-devtools/devtools-command-palette-disable-javascript.png"
img_width: 509
img_height: 191
---

When testing and debugging, I often need to see how a web page looks like and behaves with Javascript / JS turned off. Luckily it is easy to turn off javascript in Google Chrome DevTools.

## Step 1: Open Google Chrome DevTools

Either right click any element and choose “Inspect”, or use a keyboard shortcut (Mac/OSX: Cmd + Option + J, Windows: Ctrl + Alt + J)

You will see something like this bar:

![Chrome turn off Javascript Step 1: Open DevTools](/assets/2022-06-16-turn-off-javascript-in-google-chrome-devtools/chrome-open-devtools.png)

## Step 2: Open the Run command box

Use keyboard shortcut:

- Mac / OSX: Cmd + Shift + P
- Windows: Ctrl + Shift + P

You should now see this:

![Chrome turn off Javascript Step 2: Open the Run command box](/assets/2022-06-16-turn-off-javascript-in-google-chrome-devtools/devtools-command-pallette.png)

## Step 3: Turn off Javascript

Start typing “Javascript” in the run cmd box. After a bit of the word, you will see the option “Disable Javascript” to turn it off, or “Enable Javascript” to turn it back on. Select it with the keyboard or mouse, and you are done. Javascript is now turned off in Google Chrome

![Chrome DevTools Command Palette: Disable Javascript](/assets/2022-06-16-turn-off-javascript-in-google-chrome-devtools/devtools-command-palette-disable-javascript.png)

## Step 4: Turn Javascript back on

Complete steps 1-3 and choose “Enable Javascript” to revert to normal:

![Chrome DevTools Command Palette: Enable Javascript](/assets/2022-06-16-turn-off-javascript-in-google-chrome-devtools/chrome-devtools-turn-on-javascript-again.png)

There. With this post, I will never forget how to turn off javascript in Chrome again.

If you liked this post, also check out more [Chrome keyboard shortcuts](https://developer.chrome.com/docs/devtools/shortcuts/) or more on the [Run Command menu](https://developer.chrome.com/docs/devtools/command-menu/). Who likes doing extra work after all?
