class MilitaryManager extends ModuleManager
  init: (gameState) ->
    if civ of @uCivCitizenSoldier
      @uCivCitizenSoldier = @uCivCitizenSoldier[civ]
      @uAdvanced = @uCivAdvanced[civ]
      @uSiege = this.uCivSiege[civ]
      @bAdvanced = @bCivAdvanced[civ]

  this.unitType[i] = gameState.applyCiv(this.unitType[i]) for i in this.unitType for this.unitType in @uCitizenSoldier @uAdvanced @uSiege
