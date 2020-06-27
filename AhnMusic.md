AhnMusic
--------

This class provides a (relatively) painless way to drop music into your DragonRuby
game, *but* it does require you to know your music! The notes are individually
programmed, so it's not just a case of dropping your favourite `mp3` file into your
project!

To use, you will need to provide an audio file for each note you use - you'll find
notes C3-C4 in the `04_sounds` sample. By default, these are expected to be in a
`music/` folder, named `<note>.wav` but this can be overridden when creating a new
`AhnMusic` object.

You can then add notes to your tune in `AhnMusic`, which is just an array of pairs
which define the note to be played, and how many frames should pass before the next
note - something a little like this:

    args.state.music = AhnMusic.new
    args.state.music.tune.push( [ 'G3', 45 ], [ 'A3', 15 ], [ 'G3', 30 ], [ 'F3', 30 ], [ 'E3', 30 ], [ 'F3', 30 ], [ 'G3', 60 ] )
    args.state.music.tune.push( [ 'D3', 30 ], [ 'E3', 30 ], [ 'F3', 60 ] )
    args.state.music.tune.push( [ 'E3', 30 ], [ 'F3', 30 ], [ 'G3', 60 ] )
    args.state.music.tune.push( [ 'G3', 45 ], [ 'A3', 15 ], [ 'G3', 30 ], [ 'F3', 30 ], [ 'E3', 30 ], [ 'F3', 30 ], [ 'G3', 60 ] )
    args.state.music.tune.push( [ 'D3', 60 ], [ 'G3', 60 ], [ 'E3', 30 ], [ 'C3', 120 ] )
    args.state.music.playing = true

(This gives a very bad rendition of 'London Bridge Is Falling Down', which was the
first tune I could find that only required the notes provided in `04_sounds`!)

Once this is done, just make sure you call `AhnMusic.play` on every tick - I tend to
stick this near the top of my tick handler to get it out of the way :

  args.state.music.play args.state.tick_count, args.outputs.sounds

Sounds can be concurrent in DragonRuby, so if you want to play a chord of three notes
you can just add then first two with a delay of 0 :

    args.state.music.tune.push( [ 'E3', 0 ], [ 'F3', 0 ], [ 'G3', 60 ] )

(this concurrency also means that you can safely be playing music at the same time
as any sound effects you've added to your game)

By default, tunes are repeated - to disable this simply set repeat to false :

    args.state.music.repeat = false

Music can be turned on and off with the playing flag, so for example if you have a
second tune for the end of the game, you might do something like this when the player
dies:

    args.state.music.playing = false
    args.state.end_music.playing = true
