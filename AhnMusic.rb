# AhnMusic.rb
#
# Copyright (c) 2020 Pete Favelle <dragonruby@ahnlak.com>
# This file is licensed under the MIT License. See LICENSE for more details.
#
# This is a music handling class, to provide a framework allowing background or title
# music in DragonRuby while we only have 'fire and forget' audio.
#
# It WONT let you just play a WAV; instead, you provide a set of notes as individual sounds,
# and this will handle the scheduling of them when provided with a list of notes and 
# durations - essentially, an Array version of sheet music!
#
# Once configured with the note source and 'sheet music', just call the play method every
# tick, and appropriate notes will be output at appropriate times. By default, the music
# will loop, but this can be changed through the repeat attribute. 
# 
# Music can also be stopped and started with the playing flag.

class AhnMusic


    # Attributes
    attr_accessor :repeat
    attr_accessor :tune
    attr_accessor :playing

    # Creation; possibly providing us with the note source - default is 'music/?.wav'
    def initialize p_notes = 'music/?.wav'

        # Set some defaults
        @repeat = true
        @playing = false
        @tune = []
        @tune_index = -1
        @last_note = 0

        # And save the note source
        @notes_prefix, @notes_postfix = p_notes.split( '?' )

    end


    # Serialization
    def serialize

        { 
            repeat: @repeat, playing: @playing, tune: @tune, tune_index: @tune_index, last_note: @last_note,
        }

    end
    def inspect
        serialize.to_s
    end
    def to_s
        serialize.to_s
    end


    # Play, called every tick to see if there is any notes need playing
    def play tick, sounds

        # Obviously can't play a tune without a tune
        if @tune.empty? || !@playing
            return
        end

        # Right then, see if the current note's played time is past
        while @tune_index == -1 || @last_note + @tune[@tune_index][1] <= tick

            # Move onto the next note, back to the beginning if we reach the end
            @tune_index += 1
            if @tune_index >= @tune.length
                @tune_index = 0
            end

            # Double check if we're repeating
            if !@repeat
                @playing = false
                return
            end

            # Output the note
            sounds << "#{@notes_prefix}#{@tune[@tune_index][0]}#{@notes_postfix}"
            @last_note = tick
        end

    end


end