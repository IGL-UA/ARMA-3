//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Created by IGL //
// 1. Скопіюйте цей код //
// 2. Переконатися, що інших мінометів в радіусі (в даному випадку 20 метрів) - немає. //
// 3. Виконати код локально. //
// 4. Коли ви вимкнете пристрілювання, для повторного використання виконайте команду локально ще раз. //
// 5. Для пристрілювання іншого типу зброї заміни клас зброї (в даному випадку стоїть 2Б-14-1 Піднос - "rhsgref_ins_2b14") //
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

_list = player nearEntities 20; // відстань в метрах в межах якої потрібно виконати код від Арт.установки
{if (typeOf _x == "rhsgref_ins_2b14") then {gunArt = _x;};} foreach _list; // Виставити тип зброї, яку пристрелюєте в даному випадку клас міномета 2Б-14-1 Піднос --->>> "rhsgref_ins_2b14"
sprGun = createMarker ["MarkerGun", getpos gunArt];
sprGun setMarkerType "mil_triangle";
sprGun setMarkerText "Установка";
sprGun setMarkerColor "ColorRed";

spr = createMarker ["MarkerSnaryad", getpos gunArt];
spr setMarkerType "waypoint";
spr setMarkerText "Снаряд";
spr setMarkerColor "ColorWhite";
gunArt addEventHandler ["Fired", {
_null = _this spawn {
_missil = _this select 6;
waitUntil {
if (isNull _missil) exitWith {true};
spr setMarkerPos (getpos _missil);
false //<-- boolean at the end of the scope NOW REQUIRED
};
sleep 0.4;
};
}];

acted = gunArt addAction ["Вимк. Пристрілювання", {gunArt removeAllEventHandlers "Fired"; deleteMarker sprGun; deleteMarker spr; gunArt removeAction acted;}, "", 1, true, true, "", "_this distance _target < 2"];
