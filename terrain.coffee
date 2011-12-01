`function PathFinder(gameState){
	this.TerrainAnalysis(gameState);

	this.territoryMap = Map.createTerritoryMap(gameState);
}

copyPrototype(PathFinder, TerrainAnalysis);

PathFinder.prototype.getPaths = function(start, end, mode){
	var s = this.findClosestPassablePoint(this.gamePosToMapPos(start));
	var e = this.findClosestPassablePoint(this.gamePosToMapPos(end));

	if (!s || !e){
		return undefined;
	}

	var paths = [];

	while (true){
		this.makeGradient(s,e);
		var curPath = this.walkGradient(e, mode);
		if (curPath !== undefined){
			paths.push(curPath);
		}else{
			break;
		}
		this.wipeGradient();
	}

	this.dumpIm("terrainanalysis.png", 511);

	if (paths.length > 0){
		return paths;
	}else{
		return undefined;
	}
};

PathFinder.prototype.makeGradient = function(start, end){
	var w = this.width;
	var map = this.map;

	// Holds the list of current points to work outwards from
	var stack = [];
	// We store the next level in its own stack
	var newStack = [];
	// Relative positions or new cells from the current one.  We alternate between the adjacent 4 and 8 cells
	// so that there is an average 1.5 distance for diagonals which is close to the actual sqrt(2) ~ 1.41
	var positions = [[[0,1], [0,-1], [1,0], [-1,0]],
	                 [[0,1], [0,-1], [1,0], [-1,0], [1,1], [-1,-1], [1,-1], [-1,1]]];

	//Set the distance of the start point to be 1 to distinguish it from the impassable areas
	map[start[0] + w*(start[1])] = 1;
	stack.push(start);

	// while there are new points being added to the stack
	while (stack.length > 0){
		//run through the current stack
		while (stack.length > 0){
			var cur = stack.pop();
			// stop when we reach the end point
			if (cur[0] == end[0] && cur[1] == end[1]){
				return;
			}

			var dist = map[cur[0] + w*(cur[1])] + 1;
			// Check the positions adjacent to the current cell
			for (var i = 0; i < positions[dist % 2].length; i++){
				var pos = positions[dist % 2][i];
				var cell = cur[0]+pos[0] + w*(cur[1]+pos[1]);
				if (cell >= 0 && cell < this.length && map[cell] > dist){
					map[cell] = dist;
					newStack.push([cur[0]+pos[0], cur[1]+pos[1]]);
				}
			}
		}
		// Replace the old empty stack with the newly filled one.
		stack = newStack;
		newStack = [];
	}

};

PathFinder.prototype.wipeGradient = function(){
	for (var i = 0; i < this.length; i++){
		if (this.map[i] > 0){
			this.map[i] = 65535;
		}
	}
};

// Returns the path down a gradient from the start to the bottom of the gradient, returns a point for every 20 cells in normal mode
PathFinder.prototype.walkGradient = function(start, mode){
	var positions = [[0,1], [0,-1], [1,0], [-1,0], [1,1], [-1,-1], [1,-1], [-1,1]];

	var path = [[start[0]*this.cellSize, start[1]*this.cellSize]];

	var blockPoint = undefined;
	var blockPlacementRadius = 45;
	var blockRadius = 30;
	var count = 0;

	var cur = start;
	var w = this.width;
	var dist = this.map[cur[0] + w*cur[1]];
	var moved = false;
	while (this.map[cur[0] + w*cur[1]] !== 0){
		for (var i = 0; i < positions.length; i++){
			var pos = positions[i];
			var cell = cur[0]+pos[0] + w*(cur[1]+pos[1]);
			if (cell >= 0 && cell < this.length && this.map[cell] > 0 &&  this.map[cell] < dist){
				dist = this.map[cell];
				cur = [cur[0]+pos[0], cur[1]+pos[1]];
				moved = true;
				count++;
				if (count === blockPlacementRadius){
					blockPoint = cur;
				}
				if (count % 20 === 0){
					path.unshift([cur[0]*this.cellSize, cur[1]*this.cellSize]);
				}
				break;
			}
		}
		if (!moved){
			break;
		}
		moved = false;
	}
	if (blockPoint === undefined){
		return undefined;
	}
	this.addInfluence(blockPoint[0], blockPoint[1], blockRadius, -10000, 'constant');
	if (mode === 'entryPoints'){
		// returns the point where the path enters the blockPlacementRadius
		return blockPoint;
	}else{
		// return a path of points 20 squares apart on the route
		return path;
	}
};

PathFinder.prototype.countAttached = function(pos){
	var positions = [[0,1], [0,-1], [1,0], [-1,0]];
	var w = this.width;
	var val = this.map[pos[0] + w*pos[1]];

	var stack = [pos];
	var used = {};

	while (stack.length > 0){
		var cur = stack.pop();
		used[cur[0] + " " + cur[1]] = true;
		for (var i = 0; i < positions.length; i++){
			var p = positions[i];
			var cell = cur[0]+p[0] + w*(cur[1]+p[1]);

		}
	}
};
`