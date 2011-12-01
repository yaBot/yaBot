class GameState
        constructor: (ai) ->
                MemoizeInit this
                @ai = ai
                @timeElapsed = ai.timeElapsed
                @templates = ai.templates
                @entities = ai.entities
                @player = ai.player
                @playerData = ai.playerData
                @buildingsBuilt = ai.buildingsBuilt

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
                new Resources @playerData.resourceCounts

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
                        return @playerData.isAlly[if typeof ent.owner is "function" then ent.owner() else ent.owner]
                return false
        isEntityEnemy: (ent) ->
                if ent and ent.owner
                        return @playerData.isEnemy[if typeof ent.owner is "function" then ent.owner() else ent.owner]
                return false
        isEntityEnemy: (ent) ->
                if ent and ent.owner and typeof ent.owner is "function"
                        return ent.owner() == @player
                else if ent and ent.owner
                        return ent.owner == @player

                return false

        getOwnEntities: -> new EntityCollection @ai._ownEntities

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
                count=0
                @getOwnEntities().forEach ()->
                        if (ent.templateName() == type)
                                ++count
                count

        countFoundationsWithType: (type) ->
                foundationType = "foundation|" + type
                count = 0
                @getOwnEntities().forEach ()->
                        if (ent.templateName() == foundationType)
                                ++count
                return count

        findTrainers: (template) ->
                maxQueueLength = 2 #avoid tying up resources in giant training

                return @getOwnEntities().filter (ent)->
                        trainable = ent.trainableEntities()
                        return false if (!trainable or trainable.indexOf(template) == -1)

                        queue = ent.trainingQueue()
                        return false if (queue and queue.length >= maxQueueLength)

                        return true

        findBuilders: (template) ->
                return @getOwnEntities().filter (ent) ->
                        buildable = ent.buildableEntities()
                        return (!buildable or template not in buildable)

        findFoundations: (template) ->
                return @getOwnEntities().filter (ent) ->
                        return ent.foundationProgress()?

        findResourceSupplies: ->
                supplies = {}
                @entities.forEach (ent) ->
                        type = ent.resourceSupplyType()
                        return if (!type)
                        amount = ent.resourceSupplyAmount()
                        return if (!amount)

                        if type.generic == "treasure"
                                reportedType = type.specific
                        else
                                reportedType = type.generic

                        if (!supplies[reportedType])
                                supplies[reportedType] = []

                        supplies[reportedType].push
                                "entity" : ent,
                                "amount" : amount,
                                "type" : type,
                                "position" : ent.position()


                        return supplies

