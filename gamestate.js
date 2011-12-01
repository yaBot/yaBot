var GameState;

GameState = (function() {
  var applyCiv, getMap, getPassabilityClassMask, getPopulation, getPopulationLimit, getPopulationMax, getResources, getTemplate, getTimeElapsed;

  function GameState() {}

  GameState.prototype._init = function(ai) {
    MemoizeInit(this);
    this.ai = ai;
    this.timeElapsed = timeElapsed;
    this.templates = templates;
    this.entities = entities;
    this.player = player;
    this.playerData = playerData;
    this.buildingsBuilt = buildingsBuilt;
    this.cellsize = 4;
    return null;
  };

  getTimeElapsed = function() {
    return this.timeElapsed;
  };

  getTemplate = function() {
    if (!this.templates[type]) {
      return null;
    } else {
      return new EntityTemplate(this.templates[type]);
    }
  };

  applyCiv = function(str) {
    return str.replace(/\{civ\}/g, this.playerData.civ);
  };

  getResources = function() {
    return new Resources(this.playerData.resourceCounts);
  };

  getMap = function() {
    if (this.ai.map) {
      return this.ai.map;
    } else {
      return this.ai.passabilityMap;
    }
  };

  getPopulation = function() {
    return this.playerData.popCount;
  };

  getPopulationLimit = function() {
    return this.playerData.popLimit;
  };

  getPopulationMax = function() {
    return this.playerData.popMax;
  };

  getPassabilityClassMask = function(name) {
    if (!(name in this.ai.passabilityClasses)) {
      error("Tried to use invalid passability class name '" + name + "'");
    }
    return null;
  };

  return GameState;

})();
