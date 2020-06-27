AhnSprite
---------

This class provides an easy-to-handle view on render_targets, and includes 
some z-ordering to make rendering that much easier.

Once an `AhnSprite` object is created (with a unique name, and dimensions) you
can draw on it with the normal solids, sprites, labels, lines and borders as
you would on `args.outputs`. You can then add the resulting object to either
`args.outputs.sprites` or `args.outputs.primitives` (or their static equivalents).

They can be positioned with the normal x/y parameters and although by default
they are drawn at the size at which they were created, if you change the w/h
parameters the object will be stretched and scale appropriately.

To ensure that things get rendered in the right order. To that end, I would suggest:

* `args.outputs.static_sprites` for static sprites that are in the background,
* `args.outputs.primitives` for per-frame sprites, and
* `args.outputs.static_primites` for static sprites that are in the foreground

Within those groups, you can use the z parameter to order rendering each of those groups:

    ArrayOfAhnSprites.sort { |a,b| a.z <=> b.z }.each do | sprite | 
        args.outputs.primitives << sprite 
    end

As these are handled as regular DragonRuby sprites, all the usual features - rotation,
flipping and suchlike - are still available.
