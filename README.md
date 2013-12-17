# Wrapp

Wrap an App... in a disk image (DMG).

[![Gem Version](https://badge.fury.io/rb/wrapp.png)](http://badge.fury.io/rb/wrapp)


## Prologue

Say you wanna put your nice Mac OS X application in a handy disk image
(DMG) for distribution.
Why not use *wrapp* for this?
It is even shorter to type then `hdiutil` ;-)


## Requirements

This obviously runs on Mac OS X only.
You also need to have Xcode and a recent Ruby version installed
(Mavericks ships with Ruby 2.0 which works fine).


## Installation

Install it yourself as:

    $ sudo gem install wrapp

(Note: Rbenv/RVM users probably want to install without `sudo`.)


## Usage

Try `wrapp --help`!

Some examples...

Wrap the *Chunky Bacon* App:

```
wrapp /Applications/Chunky\ Bacon.app
```

Wrap the *Chunky Bacon* App and include the parent directory with all
the content (some stuff like *TeamViewer* or *FileMaker* reside in
sub-directories of `/Applications` rather then the top-level itself):

```
wrapp --include-parent-dir /Applications/why/Chunky Bacon.app
```

The commands create a DMG like `chunky_bacon_1.2.3.dmg` that contains
the given App. (the filename automatically includes the name and version).

Thats it.

(NOTE: On authorization errors try prefixing the command with `sudo`!)

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
