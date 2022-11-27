---
title: 'Changelog-driven Agile'
layout: post
tags: []
---

Changelog.md to move to completed state
Changelog-debug.md to move to in-planning states

[Separate git repo](https://stackoverflow.com/a/17313342/465081) for plan: `.gitplan`

Events:
- plan|project-slug|epic-slug|story-slug|

Git branches, tags, reflog

https://stackoverflow.com/questions/3640764/can-i-recover-a-branch-after-its-deletion-in-git

Features:
- Markdown
- File uploads

plan sync (fetches then updates)
plan fetch

plan add
plan drop
plan move

plan assist communication

communication:
  - git commit to branches
    - "work-plan"
    - "work-plan|project-slug|epic-slug|story-slug"
      - or maybe better as tags?
  - git fetch / pull / push

Mutex operations:
  - ordering
  - editing shared 
    - Plan should use event-based programming so there should be little need for this?
      - updates to eg title are `...|title-change-2022-11-17T23:26:49.740+01:00|author:houen`
      - https://martinfowler.com/bliki/CQRS.html
      - https://martinfowler.com/eaaDev/EventNarrative.html



```ruby
class Git
  def self.git(cmd)
    %x'git --git-dir=.gitplan #{cmd}';
  end
end
class Gp < Git
  def self.git(cmd)
    %x'git --git-dir=.gitplan #{cmd}';
  end
end

def git(cmd)
  %x'git --git-dir=.git #{cmd}';
end

def gp(cmd)
  %x'git --git-dir=.gitplan #{cmd}';
end

def gpm
  git checkout main
end

git('branch')
gp('branch')

10.times { gp("checkout -b test-#{_1}") }

```
