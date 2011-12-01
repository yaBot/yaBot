class ModuleManager
        constructor: ->
                @_test = 1

class MilitaryManager extends ModuleManager
  constructor: ->
    @soldiers = {}
    @assigned = {}
    @unassigned = {}
    @defineUnitsAndBuildings()

  init: (gameState) ->
    if civ of @uCivCitizenSoldier
      @uCitizenSoldier = @uCivCitizenSoldier[civ]
      @uAdvanced = @uCivAdvanced[civ]
      @uSiege = this.uCivSiege[civ]
      @bAdvanced = @bCivAdvanced[civ]
      unitType[i] = gameState.applyCiv(unitType) for i in unitType for unitType in [ @uSiege, @uAdvanced, @uCitizenSoldier ]

  defineUnitsAndBuildings: ->
  	# units
  	@uCivCitizenSoldier= {};
  	@uCivAdvanced = {};
  	@uCivSiege = {};

  	@uCivCitizenSoldier.hele = [ "units/hele_infantry_spearman_b", "units/hele_infantry_javelinist_b", "units/hele_infantry_archer_b" ];
  	@uCivAdvanced.hele = [ "units/hele_cavalry_swordsman_b", "units/hele_cavalry_javelinist_b", "units/hele_champion_cavalry_mace", "units/hele_champion_infantry_mace", "units/hele_champion_infantry_polis", "units/hele_champion_ranged_polis" , "units/thebes_sacred_band_hoplitai", "units/thespian_melanochitones","units/sparta_hellenistic_phalangitai", "units/thrace_black_cloak"];
  	@uCivSiege.hele = [ "units/hele_mechanical_siege_oxybeles", "units/hele_mechanical_siege_lithobolos" ];

  	@uCivCitizenSoldier.cart = [ "units/cart_infantry_spearman_b", "units/cart_infantry_archer_b" ];
  	@uCivAdvanced.cart = [ "units/cart_cavalry_javelinist_b", "units/cart_champion_cavalry", "units/cart_infantry_swordsman_2_b", "units/cart_cavalry_spearman_b", "units/cart_infantry_javelinist_b", "units/cart_infantry_slinger_b", "units/cart_cavalry_swordsman_b", "units/cart_infantry_swordsman_b", "units/cart_cavalry_swordsman_2_b", "units/cart_sacred_band_cavalry"];
  	@uCivSiege.cart = ["units/cart_mechanical_siege_ballista", "units/cart_mechanical_siege_oxybeles"];

  	@uCivCitizenSoldier.celt = [ "units/celt_infantry_spearman_b", "units/celt_infantry_javelinist_b" ];
  	@uCivAdvanced.celt = [ "units/celt_cavalry_javelinist_b", "units/celt_cavalry_swordsman_b", "units/celt_champion_cavalry_gaul", "units/celt_champion_infantry_gaul", "units/celt_champion_cavalry_brit", "units/celt_champion_infantry_brit", "units/celt_fanatic" ];
  	@uCivSiege.celt = ["units/celt_mechanical_siege_ram"];

  	@uCivCitizenSoldier.iber = [ "units/iber_infantry_spearman_b", "units/iber_infantry_slinger_b", "units/iber_infantry_swordsman_b", "units/iber_infantry_javelinist_b" ];
  	@uCivAdvanced.iber = ["units/iber_cavalry_spearman_b", "units/iber_champion_cavalry", "units/iber_champion_infantry" ];
  	@uCivSiege.iber = ["units/iber_mechanical_siege_ram"];

  	#defaults
  	@uCitizenSoldier = ["units/{civ}_infantry_spearman_b", "units/{civ}_infantry_slinger_b", "units/{civ}_infantry_swordsman_b", "units/{civ}_infantry_javelinist_b", "units/{civ}_infantry_archer_b" ];
  	@uAdvanced = ["units/{civ}_cavalry_spearman_b", "units/{civ}_cavalry_javelinist_b", "units/{civ}_champion_cavalry", "units/{civ}_champion_infantry"];
  	@uSiege = ["units/{civ}_mechanical_siege_oxybeles", "units/{civ}_mechanical_siege_lithobolos", "units/{civ}_mechanical_siege_ballista","units/{civ}_mechanical_siege_ram"];

  	# buildings
  	@bModerate = [ "structures/{civ}_barracks" ]; #same for all civs

  	@bCivAdvanced = {};
  	@bCivAdvanced.hele = [ "structures/{civ}_gymnasion", "structures/{civ}_fortress" ];
  	@bCivAdvanced.cart = [ "structures/{civ}_fortress", "structures/{civ}_embassy_celtic", "structures/{civ}_embassy_iberian", "structures/{civ}_embassy_italiote" ];
  	@bCivAdvanced.celt = [ "structures/{civ}_kennel", "structures/{civ}_fortress_b", "structures/{civ}_fortress_g" ];
  	@bCivAdvanced.iber = [ "structures/{civ}_fortress" ];

  #getAvailableUnits:

  update: ->
    myUnits = getOwnEntities()
    curPos = myUnits.getCentrePosition()
    target = [255, 255]

    #pathfinder = new PathFinder(gameState)
    #pathsToEnemy = pathFinder.getPaths()
    #rand = Math.floor(Math.random() * pathsToEnemy.length)
    #@path = pathsToEnemy[rand]
    myUnits.move([0,0], [255,255])