class YaBotAI extends BaseAI
   constructor: (settings) ->
        BaseAI.call this, settings
        @turn = 0
        @modules = [ new MilitaryManager(), new TestManager() ]
        @chat "Test AI"
        @firstTick = true
        @savedEvents = []
        return null

    OnUpdate: ->
        # Run the update every n turns, offset depending on player ID to balance the load
        if (@turn + @player) % 4 == 0
                Engine.ProfileStart("yabot")
                gameState = new GameState this
                @runInit(gameState)
                module.update(gameState) for module in @modules

                #do stuff
                Engine.ProfileStop()

        @turn++
        return null

    runInit: (gameState) ->
        if @firstTick
                @firstTick = false
                module.init(gameState) for module in @modules
                myCivCenters = gameState.getOwnEntities().filter((ent) -> ent.hasClass("CivCentre"))
        return null
