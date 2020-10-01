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
//Приклад:
//_baza_danuh = [["76561198054446177",WEST,[1786.95,5998.06,0.00143909],[["arifle_MX_Hamr_pointer_F","","acc_pointer_IR","optic_Hamr",["30Rnd_65x39_caseless_mag",30],[],""],[],["hgun_P07_F","","","",["16Rnd_9x21_Mag",17],[],""],["U_B_CombatUniform_mcam_vest",[["ACE_fieldDressing",1],["ACE_packingBandage",1],["ACE_morphine",1],["ACE_tourniquet",1],["30Rnd_65x39_caseless_mag",2,30]]],["V_PlateCarrierGL_rgr",[["30Rnd_65x39_caseless_mag",1,30],["30Rnd_65x39_caseless_mag_Tracer",2,30],["16Rnd_9x21_Mag",2,17],["HandGrenade",2,1],["B_IR_Grenade",2,1],["SmokeShell",1,1],["SmokeShellGreen",1,1],["SmokeShellBlue",1,1],["SmokeShellOrange",1,1],["Chemlight_green",2,1]]],["tf_rt1523g",[]],"H_HelmetB_desert","",["Binocular","","","",[],[],""],["ItemMap","ItemGPS","tf_anprc152_1","ItemCompass","tf_microdagr","NVGoggles"]]]];
//
{
if ((getPlayerUID player == _x #0) && (side player == _x #1)) exitWith {
player setpos _x #2;
player setunitloadout _x #3;
};
} foreach _baza_danuh;
