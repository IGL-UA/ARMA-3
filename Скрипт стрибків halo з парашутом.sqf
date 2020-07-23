//=====================================================Додаємо до стовпа актіон===============================================================//
// 1. Додайте в ініт обєкта який буде ініціалізатором стрибків (стіл чи стовп)                                                                //
// this addAction ["Телепорт HALO", {[_this select 1] execVM "halo.sqf";}, "", 1, true, true, "", "_this distance _target < 1.5"];            //
// 2. Створіть квадратний маркер "marker_0" та розтяніть його як зону де дозволено робити стрибки, в атрибутах зробыть його невидимим         //
// Якщо непотрібно визначати дозволені зони стрибків видаліть умову  if (_pos inArea "marker_0") then {};, тоді маркер створювати не потрібно //
//============================================================================================================================================//

_tpStart = openMap [true,false];
hintc "Натисніть лівою клавішою миші на мапі, де необхідно телепортуватися.";
_plr = _this #0; 
["mineClick", "onMapSingleClick", {
hint ""; 

if (_pos inArea "marker_0") then {

_this select 4 setPos _pos;
[_this select 4, 300] spawn BIS_fnc_halo; 

openmap [false,false];
["mineClick", "onMapSingleClick"] call BIS_fnc_removeStackedEventHandler;
} else {
hint parseText format ["%1", "<t color='#ffc600'>ТЕЛЕПОРТ</t> <br /> <t color='#ffc600'>ПОЗА ВИЗНАЧЕНОЮ ЗОНОЮ</t> <br /> <t color='#ff0000'>ЗАБОРОНЕНО!</t>"];
};
}, [_plr]] call BIS_fnc_addStackedEventHandler;