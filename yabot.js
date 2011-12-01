var YaBotAI;

YaBotAI = function(settings) {
  BaseAI.call(this, settings);
  this.turn = 0;
  this.modules = [new MilitaryManager()];
  this.chat("Testing the Military manager");
  this.firstTick = true;
  this.savedEvents = [];
  return null;
};

YaBotAI.prototype = new BaseAI();

YaBotAI.prototype.OnUpdate = function() {
  var gameState, module, _i, _len, _ref;
  if ((this.turn + this.player) % 4 === 0) {
    Engine.ProfileStart("profile 1");
    this.runInit(gameState);
    gameState = new GameState(this);
    _ref = this.modules;
    for (_i = 0, _len = _ref.length; _i < _len; _i++) {
      module = _ref[_i];
      module.update(gameState, this.savedEvents);
    }
    Engine.ProfileStop();
  }
  this.turn++;
  return null;
};

YaBotAI.prototype.runInit = gameState(function() {
  var module, myCivCenters, _i, _len, _ref;
  if (this.firstTick) {
    _ref = this.modules;
    for (_i = 0, _len = _ref.length; _i < _len; _i++) {
      module = _ref[_i];
      module.init(gameState);
    }
    myCivCenters = gameState.getOwnEntities().filter(function() {
      return ent.hasClass("CivCentre");
    });
  }
  return this.firstTick = false;
});
