Utility Toolkit
---------------

These classes are all completely standalone; they are designed to be dropped into
your `app/` directory and can be safely included by adding

`$gtk.require 'app/<class>.rb'`

at the top of your `main.rb`.

The have no external dependencies, so can be added in any order (but obviously make
sure to include them before any of your own files which use them!)

[AhnMusic](AhnMusic.md) handles music for you, allowing you to play and pause a
music track as your game requires. You will, however, have to know your musical notes!

[AhnSprite](AhnSprite.md) wraps all your graphical elements into a single, unified
set of render_targets and provides a z-order mechanism to give you better control
over the order in which things get rendered.

All of these are provided under the MIT License; share and enjoy!