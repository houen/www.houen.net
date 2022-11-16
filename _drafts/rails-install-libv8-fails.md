
- https://github.com/rubyjs/mini_racer/#troubleshooting
- https://gist.github.com/fernandoaleman/868b64cd60ab2d51ab24e7bf384da1ca?permalink_comment_id=4071064
- https://github.com/rubyjs/mini_racer/issues/250
- https://github.com/avvo/docker-ruby/issues/3
- https://billykong.github.io/ruby/2020/03/17/fixing-libv8-in-osx-catalina.html

```shell
Gem::Ext::BuildError: ERROR: Failed to build gem native extension.

    current directory: /Users/houen/.rbenv/versions/2.7.6/lib/ruby/gems/2.7.0/gems/libv8-node-16.10.0.0/ext/libv8-node
/Users/houen/.rbenv/versions/2.7.6/bin/ruby -I /Users/houen/.rbenv/versions/2.7.6/lib/ruby/2.7.0 -r ./siteconf20221114-1900-qt2mxs.rb extconf.rb
creating Makefile
==== in /Users/houen/.rbenv/versions/2.7.6/lib/ruby/gems/2.7.0/gems/libv8-node-16.10.0.0/ext/libv8-node
==== running /Users/houen/.rbenv/versions/2.7.6/lib/ruby/gems/2.7.0/gems/libv8-node-16.10.0.0/libexec/download-node
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
 25 61.6M   25 15.7M    0     0  8195k      0  0:00:07 --:--:--  0:00:17 3580k
 87 61.6M   87 53.9M    0     0  10.3M      0  0:00:05  0:00:03  0:00:02 10.3M
100 61.6M  100 61.6M    0     0  11.0M      0  0:00:05  0:00:05 --:--:-- 12.6M
/Users/houen/.rbenv/versions/2.7.6/lib/ruby/gems/2.7.0/gems/libv8-node-16.10.0.0/libexec/../src/node-v16.10.0.tar.gz: OK
==== in /Users/houen/.rbenv/versions/2.7.6/lib/ruby/gems/2.7.0/gems/libv8-node-16.10.0.0/ext/libv8-node
==== running /Users/houen/.rbenv/versions/2.7.6/lib/ruby/gems/2.7.0/gems/libv8-node-16.10.0.0/libexec/extract-node
patching file tools/icu/icutrim.py
patching file tools/genv8constants.py
==== in /Users/houen/.rbenv/versions/2.7.6/lib/ruby/gems/2.7.0/gems/libv8-node-16.10.0.0/ext/libv8-node
==== running /Users/houen/.rbenv/versions/2.7.6/lib/ruby/gems/2.7.0/gems/libv8-node-16.10.0.0/libexec/build-libv8
parallel job count: 8
configure: --openssl-no-asm --without-npm --shared --with-intl=full-icu
compilers: CC='clang' CXX='clang++' CC_host='' CXX_host=''
Apple clang version 14.0.0 (clang-1400.0.29.202)
Target: x86_64-apple-darwin21.6.0
Thread model: posix
InstalledDir: /Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin
Apple clang version 14.0.0 (clang-1400.0.29.202)
Target: x86_64-apple-darwin21.6.0
Thread model: posix
InstalledDir: /Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin
Please use python3.9 or python3.8 or python3.7 or python3.6.
	/usr/local/bin/python3.9 configure
	/usr/local/bin/python3.8 configure
Node.js configure: Found Python 3.10.8...
/Users/houen/.rbenv/versions/2.7.6/lib/ruby/gems/2.7.0/gems/libv8-node-16.10.0.0/ext/libv8-node/builder.rb:14:in `build_libv8!': failed to build libv8 16.10.0 (Libv8::Node::BuilderError)
	from /Users/houen/.rbenv/versions/2.7.6/lib/ruby/gems/2.7.0/gems/libv8-node-16.10.0.0/ext/libv8-node/location.rb:30:in `install!'
	from extconf.rb:9:in `<main>'

extconf failed, exit code 1

Gem files will remain installed in /Users/houen/.rbenv/versions/2.7.6/lib/ruby/gems/2.7.0/gems/libv8-node-16.10.0.0 for inspection.
Results logged to /Users/houen/.rbenv/versions/2.7.6/lib/ruby/gems/2.7.0/extensions/x86_64-darwin-21/2.7.0/libv8-node-16.10.0.0/gem_make.out
```

I tried all of the readily available solutions:

## Use system v8
```shell
brew install v8
gem install libv8 -v '16.10.0.0' -- --with-system-v8
```

## Add architecture to Gemfile.lock
What saved me was in the end, [the troubleshooting section of the mini_racer docs](https://github.com/rubyjs/mini_racer/#troubleshooting)

```shell
bundle lock --add-platform x86_64-darwin-21
```
