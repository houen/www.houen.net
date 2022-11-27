---
layout: post
title: "Ruby: Solving mini_racer and libv8-node bundle ERROR: Failed to build gem native extension"
description: "Solving the Ruby mini_racer / libv8-node error when trying to bundle install"
tags: [ruby, bundler, mini_racer, libv8]
img_path: /assets/2022-11-27-mini-racer-libv8-node-bundle-error-native-extensions/mini-racer-libv8-node-bundle-error-native-extensions.jpg
img_width: 393
img_height: 73
---

![Solving mini_racer and libv8-node bundle ERROR: Failed to build gem native extension](/assets/2022-11-27-mini-racer-libv8-node-bundle-error-native-extensions/mini-racer-libv8-node-bundle-error-native-extensions.jpg)

I had a somewhat frustrating debugging adventure recently after upgrading a project from Ruby 2.6 to 2.7. In the end the solution turned out to be very simple.

I was trying to install `mini_racer`, and more specifically `libv8` / `libv8-node`. I got the quite common and dreaded error when trying to build native extensions:

`Gem::Ext::BuildError: ERROR: Failed to build gem native extension.`

> NOTE: If you just want to jump through to the solution, [here is the link](#the-solution-add-platform)

Anyone who has used Ruby for a while will tell you: This is not uncommon. The recipe for solving it is most often this:

**Checklist: Bundle install Failed to build gem native extension:**:

1. Read through the error message
   - Find out what gem failed.
2. Try to install the gem with `gem install` instead of using bundler.
3. Google the relevant error messages from `gem install` to see if others have already solved it. 
   - Perform trial-and-error to try to find a solution that fits.
   - Try not to mess up your system even more when trying out solutions
4. Search in the gem Github repo for the relevant error message from `gem install`.
   - Same as above; trial-and-error; try not to mess up your system

## Step 1: Read through the error message

The error message had these interesting parts:

Gem::Ext::BuildError: ERROR: Failed to build gem native extension.

> ```
/Users/houen/.rbenv/versions/2.7.6/lib/ruby/gems/2.7.0/gems/
libv8-node-16.10.0.0/ext/libv8-node/builder.rb:14:in `build_libv8!': 
failed to build libv8 16.10.0 (Libv8::Node::BuilderError)
> ```

> ```
> Please use python3.9 or python3.8 or python3.7 or python3.6.
>	/usr/local/bin/python3.9 configure
>	/usr/local/bin/python3.8 configure
> Node.js configure: Found Python 3.10.8...
> ```

Ok. So what does this tell us? The failing gem is `libv8`? However, look at the folder path. It fails when building libv8, but it is trying to install the mini_racer-required gem `libv8-node`. 

This means that the failing build path looks like this:

> bundle install > install mini_racer > install libv8-node > install libv8 > ERROR

On to step 2:

## Step 2: Try to install the gem with `gem install libv8-node -v '16.10.0.0'`

So normally this command will reproduce the error, and give more clues to what is wrong. However, this time it installed normally with gem install:

```
gem install libv8-node -v '16.10.0.0'
Successfully installed libv8-node-16.10.0.0-x86_64-darwin
Parsing documentation for libv8-node-16.10.0.0-x86_64-darwin
Done installing documentation for libv8-node after 0 seconds
1 gem installed
```

However, a re-bundle produced the exact same error again.

What?!? This was puzzling. Very puzzling. However, the bundle error was the same as always. 
Since I had no more clues to go on I went on to step 3: See if others have solved this.

## Step 3: Google the errors to see if others have solved it

Quick, to the internet machine! A couple of searches produced the following:

- [Fixing libv8 and therubyracer on Mac - gists · GitHub](https://gist.github.com/fernandoaleman/868b64cd60ab2d51ab24e7bf384da1ca)
- [Unable To Install libv8/therubyracer on M1 Macbook](https://github.com/rubyjs/libv8/issues/312)
- [What is libv8 and Why its Installation Fails - Billy's Tech Blog](https://billykong.github.io/ruby/2020/03/17/fixing-libv8-in-osx-catalina.html)
- [Installing libv8 gem on OS X 10.9+ - Stack Overflow](https://stackoverflow.com/questions/19577759/installing-libv8-gem-on-os-x-10-9)

First: [Gist: Fixing libv8 and therubyracer on Mac - gists · GitHub](https://gist.github.com/fernandoaleman/868b64cd60ab2d51ab24e7bf384da1ca?permalink_comment_id=4071064)

Here the original Gist "Fixing libv8 and therubyracer on Mac" was for therubyracer, not mini_racer. 
However, down in the comments was [something similar](https://gist.github.com/fernandoaleman/868b64cd60ab2d51ab24e7bf384da1ca?permalink_comment_id=4211086#gistcomment-4211086) to what I was getting.

The author apparently solved it by using python 3.9.x instead of 3.10.x. 
The line from my error saying `Please use python3.9 or python3.8 or python3.7 or python3.6.` meant I felt this was worth a shot.

> ```
> pyenv install 3.9.1
> pyenv global 3.9.1
> bundle
> ```

Adding to the above, remember the part of "try not to mess up your system"? Start by running `pyenv global`. Note down the current version pyenv is using. Restore pyenv global to that one after trying to install. 

No go. Still the same error. [This solution suggestion](https://github.com/avvo/docker-ruby/issues/3) was something along the same lines, 
just using Python 2 and `ln -s` instead of `pyenv`.
However, I could see my system was trying to configure libv8-node using Python 3.9 and 3.8.
This, and the gem installing on its own led me to think that the `Please use python3.9 or python3.8 or python3.7 or python3.6.` part of the error was probably misleading in this case.

Some more Googling around this topic led me across [a solution to libv8 issues from the past](https://github.com/avvo/docker-ruby/issues/3)

This tinkered around the `-- --with-system-v8` range of solutions. I did not think this was a likely culprit, since I could install the standalone gem just fine.
I have had issues solved by `--with-system-v8` several times in the past, and every time the gem would not install at all.

This part got me a bit interested: `bundle config --global build.libv8 --with-system-v8`. But this is related to libv8, not libv8-node specifically. Likely not my solution.

(Despite my misgiving, I still tried a couple of them. I had no other ideas at the time, so it was worth a shot.)

After reading through the other first hits and deciding they were too focused on libv8, not libv8-node or mini_racer, I went for step 4:

## Step 4: Search in the gem Github repo

In the `mini_racer` Github repo I came across this issue: [Gem::Ext::BuildError: ERROR: Failed to build gem native extension #250](https://github.com/rubyjs/mini_racer/issues/250)

Here they are trying several solutions which have worked for me in the past with issues related to `therubyracer`:

[SamSaffron commented on Aug 16](https://github.com/rubyjs/mini_racer/issues/250#issuecomment-1216249107)
```
gem update --system
gem install bundler 
gem uninstall libv8-node 
gem install libv8-node 
```

This also did not help. Still issues doing bundle install.

[tisba commented on Sep 29](https://github.com/rubyjs/mini_racer/issues/250#issuecomment-1262775343)

> All mentioned steps, including to update bundler, are in https://github.com/rubyjs/mini_racer/#troubleshooting

Hmm... Ok, `mini_racer` has a troubleshooting section. I should check that out:

And in [the troubleshooting section](https://github.com/rubyjs/mini_racer/#troubleshooting) was pay dirt:

> if you are using bundler, make sure to have PLATFORMS set correctly in Gemfile.lock via bundle lock --add-platform

Hmm... Since gem install works, but bundle install does not, could this be related?

## The solution: `add-platform`
It was related. When checking Gemfile.lock's `PLATFORMS` section, I noticed there were no entries matching my system, x86_64-darwin-21. 

In the end, the solution turned out to be as simple as:

```shell
# Replace x86_64-darwin-21 with your relevant version, eg. x86_64-darwin-20, x86_64-darwin-19, etc. 
bundle lock --add-platform x86_64-darwin-21
```

Bundle complete! 74 Gemfile dependencies, 204 gems now installed.
Use `bundle info [gemname]` to see where a bundled gem is installed.

Success! Now `bundle install` works without issue.

So in the end the solution turned out to be very, very simple, 
and had seemingly little to do with what could be gleaned from the bundle errors. 

It seems silly that I had not checked the troubleshooting section already. 
But so few gems have one worth looking at, and I did not know about `mini_racer` having one. 

Since I was simply using an already-preexisting bundle in a system I had worked with for years, 
I simply went with my normal flow when troubleshooting native extension errors.

A lesson learned and a new step to my "gem issues checklist":

#### Updated checklist: Bundle install Failed to build gem native extension

1. Read through the error message
   - Find out what gem failed.
2. Try to install the gem with `gem install` instead of using bundler.
   - **If non-bundler install works, check Gemfile.lock for my system missing from `PLATFORMS` section.**
3. Google the relevant error messages from `gem install` to see if others have already solved it.
   - Perform trial-and-error to try to find a solution that fits.
   - Try not to mess up your system even more when trying out solutions
4. Search in the gem Github repo for the relevant error message from `gem install`.
   - Same as above; trial-and-error; try not to mess up your system
