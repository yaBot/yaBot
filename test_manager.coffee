class TestManager extends ModuleManager
        constructor: (gameState) ->
                @targetNumWorkers = 15

        init: (gameState) ->
                return null

        reassignRolelessUnits: (gameState) ->
                roleless = gameState.getOwnEntitiesWithRole(`undefined`)
                roleless.forEach (ent)->
                        if ent.hasClass("Worker")
                                ent.setMetadata("role", "worker")
                        else
                                ent.setMetadata("role", "unknown")
                return null

        trainMoreWorkers: (gameState) ->
                numWorkers = gameState.getOwnEntitiesWithRole("worker").length
                type = "units/{civ}_support_female_citizen"
                type = gameState.applyCiv type
                amount = 1
                metadata = role: "worker"

                if numWorkers < @targetNumWorkers
                        trainers = gameState.findTrainers(type).toEntityArray()

                        trainers.sort (a, b) ->
                                a.trainingQueueTime() - b.trainingQueue
                        if trainers.length > 0
                                trainers[0].train(type, amount, metadata)
                return null


        update: (gameState) ->
                # resources = gameState.getResources()
                # resources.wood, stone, food, population, metal
                @reassignRolelessUnits gameState
                @trainMoreWorkers gameState
                return null