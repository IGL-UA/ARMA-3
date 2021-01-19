call compile preprocessFileLineNumbers "RLO\settings.sqf";
RLO addAction ["<t color='#00FF00'>Открыть РЛО</t>", {createDialog "RLO_Main"}, nil, 6, true, true, "", "vehicle _this == RLO"];