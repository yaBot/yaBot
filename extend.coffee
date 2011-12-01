Entity::deleteMetadata = (id) ->
        delete @_ai._entityMetadata[@id()];

EntityCollection::attack = (unit) ->
        unitId = if typeOf(unit) is "Entity" then unit.id() else unit
        Engine.PostCommand
                type: "walk"
                entities: @toIdArray()
                target: unitId
                queued: false
        return this;

EntityCollection::getCentrePosition = ->
        sumPos = [0, 0]
        count = 0
        for ent in @toEntityArray()
                sumPos[0] += ent.position()[0]
                sumPos[1] += ent.position()[1]
                count+=1
        if count == 0
                return `undefined`
        else
                return [sumPos[0]/count, sumPos[1]/count]


EntityCollectionFromIds = (gameState, idList) ->
        ents = {};
        for i of idList
                id = idList[i];
                if gameState.entities._entities[id]
                        ents[id] = gameState.entities._entities[id]
        return new EntityCollection gameState.ai, ents