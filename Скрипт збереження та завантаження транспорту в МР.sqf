//===========================================================================//
//               Створюємо базу даних і вносимо дані гравця                  //
//              ---- ЗБЕРІГАЄМО в профіль адмыністратора ----                //
//                    Збережіть даний код в init.sqf                         //
//      Потрібно виконати команду глобально -> [] spawn fn_savevehbaceTH;    //
//===========================================================================//
fn_savevehbaceTH = {
params ["_typeof", "_pos","_dir","_loadout","_damage","_veh_bace"];
_veh_bace = [];

{
	if ((typeof _x) isKindOf ["Car_F", configFile >> "CfgVehicles"]) then {
		_typeof = typeof _x;
		_pos = getPosATL _x;
		_dir = vectorDir _x;
		_damage = damage _x;
		_loadout = [];
		{_loadout pushBack _x;} forEach weaponsItemsCargo _x;
		private _magazineCargo = getMagazineCargo _x;
		{_loadout pushBack [_x, (_magazineCargo select 1) select _forEachIndex];} forEach (_magazineCargo select 0);
		private _itemCargo = getItemCargo _x;
		{_loadout pushBack [_x, (_itemCargo select 1) select _forEachIndex];} forEach (_itemCargo select 0);
		private _BackpackCargo = getBackpackCargo _x;
		{_loadout pushBack [_x, (_BackpackCargo select 1) select _forEachIndex];} forEach (_BackpackCargo select 0);		
		_veh_bace append [[_typeof,_pos,_dir,_loadout,_damage]];
	};
} count allMissionObjects "All";

profileNamespace setVariable ['baza_danuh_veh', _veh_bace]; 
saveProfileNamespace;
};

//===========================================================================//
//                                  Завантаження                             //
//===========================================================================//

params ["_newveh","_baza_danuh_veh","_loadoutveh"];

_baza_danuh_veh = profileNamespace getVariable 'baza_danuh_veh';

{
	_newveh = (_x #0) createVehicle (_x #1);
	clearWeaponCargoGlobal _newveh;
    clearMagazineCargoGlobal _newveh;
    clearItemCargoGlobal _newveh;
    clearBackpackCargoGlobal _newveh;
    _newveh setVectorDir _x #2;
    _loadoutveh = _x #3;
	
	{
    if (count _x > 2) then { //Weapon
        _newveh addWeaponWithAttachmentsCargoGlobal [_x, 1];
    } else { //Item
        _x params ["_class", "_count"];
		private _type = _class call BIS_fnc_itemType;
		switch (_type select 0) do {
			case 'Weapon': { 
				_newveh addWeaponCargoGlobal [_class, _count];
			};
			case 'Magazine': {
				_newveh addMagazineCargoGlobal [_class, _count];
			};
			case 'Item': { _newveh addItemCargoGlobal [_class, _count]; };
			case 'Mine': { _newveh addItemCargoGlobal [_class, _count]; };
			case 'Equipment': { 
				if ((_type select 1) == "Backpack") then {
					_newveh addBackpackCargoGlobal [_class, _count];	
				} else {
					_newveh addItemCargoGlobal [_class, _count];									
				};
			};
			default { systemChat format ["Error: can't get item type: %1", _class]; };
		};	
    }
	} foreach _loadoutveh;
	
} forEach _baza_danuh_veh;