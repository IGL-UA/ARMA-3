params ["_ctrl", "_code", "_mode"];
disableSerialization;
_display = findDisplay 9901;
switch (_mode) do {
	case 0: {
		playSound "TFAR_rotatorPush";
		switch (RLO_RangeMode) do {
			case 0: {
				if (_code == 0) then {(_display displayCtrl 6560) ctrlSetAngle [30, 0.5, 0.5]; RLO_RangeMode = 1; hintSilent format ["Дальність: %1", RLO_midRange];};
			};
			case 1: {
				if (_code == 0) then {(_display displayCtrl 6560) ctrlSetAngle [60, 0.5, 0.5]; RLO_RangeMode = 2; hintSilent format ["Дальність: %1", RLO_highRange];} else {(_display displayCtrl 6560) ctrlSetAngle [0, 0.5, 0.5]; RLO_RangeMode = 0; hintSilent format ["Дальність: %1", RLO_lowRange];};
			};
			case 2: {
				if (_code == 1) then {(_display displayCtrl 6560) ctrlSetAngle [30, 0.5, 0.5]; RLO_RangeMode = 1; hintSilent format ["Дальність: %1", RLO_midRange];};
			};
		}; 
	};
};