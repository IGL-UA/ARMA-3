params ["_display", "_range", "_bearing", "_rangeScale"];

_scaleX = (safeZoneH*3/4)*0.259187;
_scaleY = safeZoneH*0.260185;
_centerX = safeZoneX + (0.492145*safeZoneW) - (0.015*3/4/2);
_centerY = safezoneY + (0.449074*safezoneH) - (0.015/2);

_dY = cos(180 - _bearing) * _range;
_dX = cos(90 - (180 - _bearing)) * _range;

_mark = _display ctrlCreate ["RLO_Mark", -1];
_mark ctrlSetPosition [_centerX+(_dX/_rangeScale*_scaleX), _centerY + (_dY/_rangeScale*_scaleY)];
_mark ctrlSetAngle [_bearing, 0.5, 0.5];
_mark ctrlCommit 0;
_mark