Entity::deleteMetadata = (id) ->
        delete @_ai._entityMetadata[@id()];

EntityCollection::attack = (unit) ->
        unitId = if typeOf(unit) is "Entity" then unit.id() else unit

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
