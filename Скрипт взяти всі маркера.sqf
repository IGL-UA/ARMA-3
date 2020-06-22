_f = [];
{

	if (getMarkerType _x isEqualTo "mil_arrow") then {
		_f pushBack [[_x]];
        _f select ((count _f) - 1) pushBack (getmarkerpos _x);
		};

} foreach allMapMarkers;

hint format ["%1", _f];

copyToClipboard str _f;
