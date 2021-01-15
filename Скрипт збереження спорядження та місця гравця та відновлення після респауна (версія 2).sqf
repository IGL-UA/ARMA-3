//===========================================================================//
//               Створюємо базу даних і вносимо дані гравця                  //
//              ---- ЗБЕРІГАЄМО в профіль кожного бійця ----                 //
//===========================================================================//
params ["_guid", "_primary","_handgun","_secondary","_baza_danuh","_side"];

_baza_danuh = [];

if (alive player) then {
_guid = getPlayerUID player;
_side = side player;
_pos = getpos player;
_loadout = getUnitLoadout player;
_currentTime = format ["%3%2%1", systemTime #0, systemTime #1, systemTime #2];
_baza_danuh append [[_guid,_side,_pos,_loadout,_currentTime]];
};

profileNamespace setVariable ['baza_danuh', _baza_danuh]; 
saveProfileNamespace;

//===========================================================================//
//                  Для завантаження вставити в initPlayerLocal.sqf          //
//===========================================================================//

//Вказуэмо дату останнього збереження даних в такому форматі, як вказано в даному прикладі (в даному випадку дата 15/01/2021)
dataGru = "1512021";

waitUntil {!isnull player};
_baza_danuh_player = profileNamespace getVariable "baza_danuh";

{
if !(_x #4 == dataGru) exitWith {};	
if ((getPlayerUID player == _x #0) && (side player == _x #1)) exitWith {
player setpos _x #2;
player setunitloadout _x #3;
};
} count _baza_danuh_player;