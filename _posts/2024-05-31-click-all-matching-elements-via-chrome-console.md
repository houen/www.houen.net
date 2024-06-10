---
layout: post
title: "Click all elements matching a CSS selector via Chrome DevTools console"
description: "Instantly click all elements matching a CSS selector on a webpage using only Chrome DevTools. No jQuery needed."
tags: [chrome, devtools, console, quick tips]
img_path: /assets/2023-05-31-click-all-matching-elements-via-chrome-console/click-all-github-trash-icons.png
img_width: 801
img_height: 245
---

![Clicking all trash buttons on a page of GitHub stale branches](/assets/2023-05-31-click-all-matching-elements-via-chrome-console/click-all-github-trash-icons.png)
_Clicking all trash buttons on a page of GitHub stale branches_

## Click all CSS-selected elements without jQuery
I sometimes need to click all elements on a webpage, for instance to:
- Delete stale branches on GitHub
- Delete recruiter messages on LinkedIn

I struggled to do this without using jQuery, but now found a way, using chrome's built-in `$$` operator:

Here the CSS selector is `button[aria-label=\"Delete branch\"]`, but it can of course be whatever you need:

```
$$("button[aria-label=\"Delete branch\"]").map(e => e.click())
```

## What can you use this for?
### Quickly clean up stale branches on Github
- Go to a Github repos stale branches pages, eg. https://github.com/[handle]/[repo]/branches/stale
- Run `$$("button[aria-label=\"Delete branch\"]").map(e => e.click())`
- Click next page
- Repeat until you have deleted as much as you want

Best,
Søren
