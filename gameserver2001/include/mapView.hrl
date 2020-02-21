-ifndef(mapView_hrl).

-define(mapView_hrl, 1).


%% From left top to right bottom
%% parameters: 
%% playerList -> players' id in this cell,
%% otherList -> monsters, npcs, collections etc. in this cell
-record(mapViewCell, {index, playerList, otherList}).

%% Hold a table of mapview cells, 
%% 
-define(DIR_S, 0).
-define(DIR_SE, 1).
-define(DIR_E, 2).
-define(DIR_NE, 3).
-define(DIR_N, 4).
-define(DIR_NW, 5).
-define(DIR_W, 6).
-define(DIR_SW, 7).
-define(DIR_COUNT, 8).
-define(DIR_NOT_MOVE, 9).

%% -define( MAP_CELL_WIDTH, 640 ).%% will 1280/2
%% -define( MAP_CELL_HEIGHT, 360 ).%% will 720/2
-define(MAP_CELL_WIDTH, 18).%% 一个9宫格宽度对应的逻辑格子数
-define(MAP_CELL_HEIGHT, 15).%% 一个9宫格高度对应的逻辑格子数


-record(mapViewCellInfo, {index, cellIndexX, cellIndexY,
  aroundCellIndexs, moveDirAppearCellIndexs, moveDirDisappearCellIndexs}).


-endif.