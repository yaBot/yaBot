YaBotAI = (settings) ->
        BaseAI.call this, settings
        this.turn = 0
        this.chat "Welcome!"
        return null

YaBotAI.prototype = new BaseAI()

YaBotAI.prototype.OnUpdate = ->
        # Run the update every n turns, offset depending on player ID to balance the load
        if (this.turn + this.player) % 4 == 0
                gameState = new GameState this
                Engine.ProfileStart("profile 1")
                #do stuff
                Engine.ProfileStop()

        this.turn++
        return null
