YaBotAI = (settings) ->
        BaseAI.call this, settings
        this.turn = 0
        this.modules = [ new MilitaryManager() ]
        this.chat "Testing the Military manager"
        this.firstTick = true
        this.savedEvents = []
        return null

YaBotAI.prototype = new BaseAI()

YaBotAI.prototype.OnUpdate = ->
        # Run the update every n turns, offset depending on player ID to balance the load
        if (this.turn + this.player) % 4 == 0
                Engine.ProfileStart("profile 1")
                @runInit(gameState)
                gameState = new GameState this
                module.update(gameState, @savedEvents) for module in @modules

                #do stuff
                Engine.ProfileStop()

        this.turn++
        return null

YaBotAI.prototype.runInit = gameState ->
        if @firstTick
          module.init(gameState) for module in @modules
          myCivCenters = gameState.getOwnEntities().filter(-> ent.hasClass("CivCentre"))
        @firstTick = false