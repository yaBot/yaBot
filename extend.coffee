Entity::deleteMetadata = (id) ->
        delete @_ai._entityMetadata[@id()];

EntityCollection::attack = (unit) ->
        unitId = if typeOf(unit) is "Entity" then unit.id() else unit
EntityCollection::getCentrePosition = ->
        sumPos = [0, 0]
        count = 0
        sumPos[0] += thisent.position()[0] || sumPos[1] += thisent.position()[1] || count+=1 for thisent in ent
        if count == 0
          return undefined
        else
          return [sumPos[0]/count, sumPos[1]/count]

	Engine.PostCommand
                type: "walk"
                entities: this.toIdArray()
                target: unitId
                queued: false
	return this;


EntityCollectionFromIds = (gameState, idList) ->
	ents = {};
	for i of idList
		id = idList[i];
		if gameState.entities._entities[id]
			ents[id] = gameState.entities._entities[id]
	return new EntityCollection gameState.ai, ents
