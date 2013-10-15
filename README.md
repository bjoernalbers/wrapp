# Wrapp

Wrap an App... in a disk image (DMG).


## Prologue

Say you wanna put your nice Mac OS X application in a handy disk image
(DMG) for download / deployment.
Why not use `wrapp` for this?
It is even shorter to type then `hdiutil` ;-)

**NOTE: This only runs on Mac OS X!**


## Installation

Add this line to your application's Gemfile:

    gem 'wrapp'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install wrapp


## Usage

Some examples...

Build a dmg from the locally installed 'Chunky Bacon.app':

```
wrapp /Applications/Chunky\ Bacon.app
created chunky_bacon_1.2.3.dmg with SHA-1 deadbeef...
```

Build a dmg from the Chunky Bacon app (the one with the weird directory
layout):

```
wrapp --plist /Applications/Chunky/Bacon.app /Applications/Chunky
created bacon_1.2.3.dmg with SHA-1 deadbeef...
```

Build the dmg in a different directory (and create it first if missing):

```
wrapp --outdir /tmp/dmgs /Applications/Chunky\ Bacon.app
...
created chunky_bacon_1.2.3.dmg with SHA-1 deadbeef...
```

Thats it.


## Contributing

Thanks for your help! Please contact me via Github or check the open
issues. Then:

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request


## Copyright

Copyright (c) 2013 Björn Albers
