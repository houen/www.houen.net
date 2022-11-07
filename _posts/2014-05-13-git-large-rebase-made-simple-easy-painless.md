---
layout: post
title: Git large rebase made simple, easy and painless
tags: [git, rebase]
---

## The large Git rebase

At my work we use a [simple and clean workflow](https://blogs.atlassian.com/2014/01/simple-git-workflow-simple/), for getting our code into production. We use Pull Requests for our branches, and rebase them so our history is nice and tight. This works very well 95% of the time. Branches are sufficiently small, turnaround is fast, and we have no problems. But, sometimes we still end up with something less than ideal. Luckily there is a nifty way of doing this.

## The large, breaking commit left a little too long

Inevitably, we sometimes have a large Pull Request that is just too cumbersome for a very fast turnaround time. So it is left to sit. For a couple of weeks. Other branches are in the meantime happily trotting along, and they sometimes end up having many conflicting changes. This leads to:

## The large git rebase nightmare

Suddenly, we have a branch that has 13 different rebase conflicts, some of them even affecting the same branch multiple times. It is extremely painful and wasteful to keep this branch rebased to master. So we look longignly at that wonderfully simple command:

```shell
git merge
```

We know we should not use it, and we will pay the price on all other branches. So maybe we freeze everything and have a ‘merge day’. Very frustrating for everybody. Here is another way:

## The merge-squash

### Merge step

What we can do instead, is create a ‘provision’ branch, based on the current master. We then select the (very conflicting) branches we want to be provisioned and put into master, and merge them into the provision branch. The merge conflicts will have to be dealt with, of course, but that should not be too much of a problem.

### Squash step

After we have merged in all the branches to be provisioned, we can then easily _merge squash_ them to a single commit, like so (It is a good idea to do this on a backup provision branch the first couple of times, since we will be rewriting history with no safety net):

1. First, get the commit tags of your current head, and the time of the latest master commit. A great tool for this is [GitX](http://gitx.frim.nl/). In our case, this could be **0bc47b1** (provision HEAD) and **4154fcb** (latest master commit)

2. Rewind the provision branch to latest master commit:
```shell
git reset --hard 4154fcb
```

3. Now merge squash the branch with the latest HEAD from above:
```shell
git merge --squash 0bc47b1
```
All of the merged changes from all of the provisioned branches will now be one single edit right after 4154fcb. Commit this edit:

```shell
git commit -am 'Description of the provisioned changes here'
```

You have now painlessly merged the changes to one commit that other work can easily be integrated with.
