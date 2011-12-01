class GameState
        constructor: (ai) ->
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

        getTimeElapsed: -> @timeElapsed
        getTemplate: ->
                if !@templates[type]
                        null
                else
                        new EntityTemplate @templates[type]
        applyCiv: (str) ->
                str.replace /\{civ\}/g, @playerData.civ

        getResources: ->
                new Resources this.playerData.resourceCounts

        getMap: ->
                if @ai.map then @ai.map else @ai.passabilityMap

        getPopulation: -> @playerData.popCount
        getPopulationLimit: -> @playerData.popLimit
        getPopulationMax: -> @playerData.popMax

        getPassabilityClassMask: (name) ->
                if name not of @ai.passabilityClasses
                        error "Tried to use invalid passability class name '" + name + "'"
                return null

        getPlayerID: -> @player

        isPlayerAlly: (id) -> @playerData.isAlly[id]
        isPlayerEnemy: (id) -> @playerData.isEnemy[id]
        isEntityAlly: (ent) ->
                if ent and ent.owner
                        return this.playerData.isAlly[if typeof ent.owner is "function" then ent.owner() else ent.owner]
                return false
        isEntityEnemy: (ent) ->
                if ent and ent.owner
                        return this.playerData.isEnemy[if typeof ent.owner is "function" then ent.owner() else ent.owner]
                return false
        isEntityEnemy: (ent) ->
                if ent and ent.owner and typeof ent.owner is "function"
                        return ent.owner() == @player
                else if ent and ent.owner
                        return ent.owner == @player

                return false

        getOwnEntities: -> new EntityCollection @ai @ai._ownEntities

        getOwnEntitiesWithRole: Memoize('getOwnEntitiesWithRole', (role) ->
                metas = @ai._entityMetadata
                if role?
                        return @getOwnEntities().filter_raw (ent) ->
                                metadata = metas[ent.id]
                                if !metadata or !('role' of metadata)
                                        return false
                                return (metadata.role is role)

                else
                        return @getOwnEntities().filter_raw (ent) ->
                                metadata = metas[ent.id]
                                if !metadata or !('role' of metadata)
                                        return true
                                return (metadata.role is `undefined`)
                )

        countEntitiesWithType: (type) ->
                foundationType = "foundation|" + type
                count=0
                @getOwnEntities().forEach ()->
                        t = ent.templateName()
                        if t == foundationType
                                ++count
                count
