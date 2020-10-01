//===========================================================================//
//        Створюємо базу даних і забиваємо її даними по гравцям              //
//                   ---- КОПІЮЄМО в буфер обміну ----                       //
//===========================================================================//
params ["_guid", "_primary","_handgun","_secondary","_baza_danuh","_side"];

_baza_danuh = [];

{
if (alive _x) then {
_guid = getPlayerUID _x;
_side = side _x;
_pos = getpos _x;
_loadout = getUnitLoadout _x;
_baza_danuh append [[_guid,_side,_pos,_loadout]];
};
} foreach allPlayers;

copyToClipboard str _baza_danuh;

//===========================================================================//
//                  Для завантаження вставити в initPlayerLocal.sqf          //
//===========================================================================//

waitUntil {!isnull player};
_baza_danuh = // -= сюди вставити базу даних що створена і є в буфері обміну на кінець гри (після виконання коду зверху) =- //
{
if ((getPlayerUID player == _x #0) && (side player == _x #1)) exitWith {
player setpos _x #2;
player setunitloadout _x #3;
};
} forach _baza_danuh;
