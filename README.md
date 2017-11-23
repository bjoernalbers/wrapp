# Wrapp

Wrap an App... in a disk image (DMG).

[![Gem Version](https://badge.fury.io/rb/wrapp.png)](http://badge.fury.io/rb/wrapp)
[![Build Status](https://travis-ci.org/bjoernalbers/wrapp.svg?branch=master)](https://travis-ci.org/bjoernalbers/wrapp)


## Prologue

Say you wanna put your nice Mac OS X application in a handy disk image
(DMG) for distribution.
Why not use *wrapp* for this?
It is a short wrapper around `hdiutil` ;-)


## Requirements

This runs only on macOS.


## Installation

Install it yourself as:

    $ sudo gem install wrapp -n /usr/local/bin

(Note: Rbenv/RVM users probably want to install without `sudo`.)


## Usage

```
$ wrapp --help
Usage: wrapp [options] APP_PATH
    -f, --filesystem FILESYSTEM      Causes a filesystem of the specified type to be written to the image.
    -n, --volume-name NAME           Volume name of the newly created filesystem.
```

Examples...

```
wrapp /Applications/Chunky\ Bacon.app
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

Copyright (c) 2017 Björn Albers
