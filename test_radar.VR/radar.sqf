params ["_radar_radius", "_radar_height", "_radar_degrees"];


bg_fnc_radar_createLine = {
	[] spawn {
	bg_degrees_1 = 180;
	_posP = getPos player;
	while {true} do {
		for "_i" from 1 to 50 do {
			_pos = [0,0,0];
			_cordX = (_posP # 0) + (bg_radar_radius * (cos (bg_degrees_1 + _i)));
			_cordY = (_posP # 1) + (bg_radar_radius * (sin (bg_degrees_1 + _i)));
			_pos set [0,_cordX];
			_pos set [1,_cordY];
			missionNamespace setVariable [format["VECTORPOS_%1",_i],_pos];
		};
		uiSleep 0.05; // Швидкість обертання радару
		bg_degrees_1 = bg_degrees_1 - 1;
		if (bg_degrees_1 == 0) then {bg_degrees_1 = 360};
	};
};
/*
[] spawn {
	bg_degrees_2 = 360 - bg_radar_degrees;
	_posP = getPos player;
	while {true} do {
		_pos = [0,0,0];
		_cordX = (_posP # 0) + (bg_radar_radius * (cos bg_degrees_2));
		_cordY = (_posP # 1) + (bg_radar_radius * (sin bg_degrees_2));
		_pos set [0,_cordX];
		_pos set [1,_cordY];
		missionNamespace setVariable ["VECTORPOS2",_pos];
		bg_degrees_2 = bg_degrees_2 - 1;
		if (bg_degrees_2 == 0) then {bg_degrees_2 = 360};
		uiSleep 0.05;
	};
};*/
};

bg_fnc_radar_checkVehicle = {
_return = [false,""];
_veh = _this # 0;
degreesVeh = 0;
//Якщо не повітряне судно то завершуємо
if !(_veh isKindOf "Air") exitWith {_return};
_pos = getPos _veh;

if ((_pos # 2 < bg_radar_height) || (_veh distance2d (getPos player) > bg_radar_radius)) exitWith {_return};
//Перевіряємо чи перетинається з місцевістю
if (terrainIntersect [getPos player, _pos]) exitWith {_return};
_h = (_pos # 1) - ((getPos player) # 1);
_w = (_pos # 0) - ((getPos player) # 0);
_deg = atan (_h / _w);
if (_w > 0) then {
	if (_h > 0) then {
		_deg = _deg + 0;
	} else {
		_deg = _deg + 360;
	};
} else {
	_deg = _deg + 180;
};
if (_deg > bg_degrees_1 && (_deg < (bg_degrees_1 + bg_radar_degrees))) then {
	degreesVeh = _deg - bg_degrees_1;
	_return = [true,(1 / degreesVeh * 20)];
};
_return
};

bg_fnc_radar_draw = {
	_draw = ((findDisplay 12) displayCtrl 51) ctrlAddEventHandler ["Draw",{
	if (bg_radar getVariable ["RADAR_ON",false]) then {
		if (player isEqualTo commander objectParent player) then {
			{
			if (_x isKindOf "Air") then {
				_veh = _x;
				_iconType = getText (configFile >> "CfgVehicles" >> typeOf _veh >> "icon");
				_color = [0.7,0,0,1];
				_pos = getPosASL _veh;
				_iconSize = 28;
				_dir = getDir _veh;
				_text = name _veh;
				_shadow = 1;
				_textSize = 0.04;
				_textFont = "puristaMedium";
				_textOffset = "right";
				_vehCall = [_veh] call bg_fnc_radar_checkVehicle;
				if (_vehCall # 0) then {
					_color = [1,0,0,_vehCall # 1];
					(_this select 0) drawIcon [
						_iconType,
						_color,
						_pos,
						_iconSize,
						_iconSize,
						_dir
					];
				};
			};
			} forEach allMissionObjects "All";
			
			for "_i" from 1 to 50 do {
				_alpha = (1 / _i) * 2;
				(_this select 0) drawLine [
					getPos player,
					missionNamespace getVariable [format["VECTORPOS_%1",_i],getPos player],
					[1,0,0,_alpha]
				];
			};
		};
	};
}];
};

[] spawn bg_fnc_radar_createLine;
[] spawn bg_fnc_radar_draw;