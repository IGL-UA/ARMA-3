
RLO_InitX = safezoneX + ((safezoneW - safezoneH*4/3)/2);
RLO_InitY = safeZoneY;
RLO_width = safezoneH*4/3;
RLO_height = safeZoneH;
RLO_RangeMode = 0;

private ["_initTime", "_beam", "_display", "_lastBearing", "_objDir"];
disableSerialization;
_display = _this select 0;

_beam = _display displayCtrl 6559;
_initTime = time;
_lastBearing = (time-_initTime)/RLO_scanRate*360;

RLO_targetsArray = [];
RLO_markersArray = [];

RLO_arrayUpdateThread = [] spawn {
	while {dialog} do {
		RLO_targetsArray = nearestObjects [player, ["Air"], RLO_highRange + 1000];
		sleep 1;
	};
};
while {dialog} do {
	private ["_bearing", "_targetsArray"];
	_bearing = (time-_initTime)/RLO_scanRate*360;
	_beam ctrlSetAngle [_bearing, 0.5, 0.5];
	
	_targetsArray = RLO_targetsArray;
	{
		_objDir = player getDir _x;
		if (((_objDir <= (_bearing % 360)) && (_objDir >= (_lastBearing % 360)) && !(terrainIntersectASL [getPosASL player, getPosASL _x])) ||
			(((_lastBearing % 360) > (_bearing % 360)) && (_objDir >= (_lastBearing % 360)) && (_objDir <= (_bearing % 360)) && !(terrainIntersectASL [getPosASL player, getPosASL _x]))
			) then {
			_range = switch (RLO_RangeMode) do {
				case 0: {RLO_lowRange};
				case 1: {RLO_midRange};
				case 2: {RLO_highRange};
			};
			if ((player distance2D _x) <= _range) then	{
				_mark = [_display, player distance2D _x, _objDir, _range] call RLO_fnc_createMark;
				RLO_targetsArray deleteAt (RLO_targetsArray find _x);
				_mark ctrlSetFade ((((player distance2D _x)^2)/(RLO_highRange*0.85)/(RLO_highRange*0.85)) min 1);
				_mark ctrlCommit 0;
				if (vectorMagnitude (velocity _x) == 0) then {_mark ctrlSetFade 1; _mark ctrlCommit 0;}; 
				_mark ctrlSetFade 1;
				_mark ctrlCommit 2.5;
			};
		};
	} forEach _targetsArray;
	_lastBearing = _bearing;
};