if (isServer) then {
	bg_radar setVariable ["RADAR_ON",false,true];
};

bg_radar_radius = 5000; // Дистанція роботи радара
bg_radar_height = 50; // Висота нижче якої техніка не засікається
bg_radar_degrees = 50; // Кут огляду радара

bg_radar addAction ["Увімкнути радар",{bg_radar setVariable ["RADAR_ON",true,true]; [bg_radar_radius, bg_radar_height, bg_radar_degrees] execVM "radar.sqf";},[],-100,false,false,"","(!(bg_radar getVariable ['RADAR_ON',false])) and (player isEqualTo commander objectParent player)"];
bg_radar addAction ["Вимкнути радар",{bg_radar setVariable ["RADAR_ON",false,true];},[],-100,false,false,"","(bg_radar getVariable ['RADAR_ON',false]) and (player isEqualTo commander objectParent player)"];