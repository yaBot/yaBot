class GameState
        _init: (ai) ->
                MemoizeInit this
                @ai = ai
                @timeElapsed = timeElapsed
                @templates = templates
                @entities = entities
                @player = player
                @playerData = playerData
                @buildingsBuilt = buildingsBuilt

                @cellsize = 4 # Size of each map tile
                return null

        getTimeElapsed = -> @timeElapsed
        getTemplate = ->
                if !@templates[type]
                        null
                else
                        new EntityTemplate @templates[type]
        applyCiv = (str) ->
                str.replace /\{civ\}/g, @playerData.civ

        getResources = ->
                new Resources this.playerData.resourceCounts

        getMap = ->
                if @ai.map then @ai.map else @ai.passabilityMap

        getPopulation = -> @playerData.popCount
        getPopulationLimit = -> @playerData.popLimit
        getPopulationMax = -> @playerData.popMax

        getPassabilityClassMask = (name) ->
                if name not of @ai.passabilityClasses
                        error "Tried to use invalid passability class name '" + name + "'"
                return null