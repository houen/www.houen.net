---
layout: post
title: Easy way to copy one git branch to another local branch
tags: [kill process, mac, mac osx, process]
---

At my work we use a couple of branches for deployment with [CodeShip](https://www.codeship.io/). When we push one of our ‘build’ branches, Codeship automatically starts a new build on it, and deploys if all tests pass. One of these is our QA branch. For this reason it is beneficial for us to have a quick workflow to make one of these branches behave like a dev branch we want to test-deploy. I think I have now found the easiest, fastest Git command for doing so:

## The Git command to easily copy one git branch to another local branch

It is basically just ‘reverting’ the branch to another branch (in this case a remote one):

NOTE: This will OVERWRITE the branch you are copying to

```shell
git checkout local-branch-i-want-to-revert
git reset --hard origin/branch-i-want-to-copy
```

If the branch you wish to copy is not remote, remove the origin/ part

## Book Recommendation

Interested in improving your git skills? Then I would suggest ["Version Control with Git"](https://amzn.to/3pl052t) published by O’reilly.

[![Version Control with Git](/assets/books/oreilly_version_control_with_git.jpg)](https://amzn.to/3pl052t)


