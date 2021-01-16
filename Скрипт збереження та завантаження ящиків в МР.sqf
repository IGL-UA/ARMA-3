/*Збереження*/
fn_saveboxbaceTH = {
params ["_typeof", "_pos","_dir","_loadout","_damage","_boxes_bace"];
_boxes_bace = [];

{
	if ((typeof _x) isKindOf ["ReammoBox_F", configFile >> "CfgVehicles"]) then {
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
		_boxes_bace append [[_typeof,_pos,_dir,_loadout,_damage]];
	};
} count allMissionObjects "All";

profileNamespace setVariable ['baza_danuh_box', _boxes_bace]; 
saveProfileNamespace;
};

/* Завантаження  */

params ["_ammobox","_baza_danuh_box","_loadoutbox"];

_baza_danuh_box = profileNamespace getVariable 'baza_danuh_box';

{
	_ammobox = (_x #0) createVehicle (_x #1);
	clearWeaponCargoGlobal _ammobox;
    clearMagazineCargoGlobal _ammobox;
    clearItemCargoGlobal _ammobox;
    clearBackpackCargoGlobal _ammobox;
    _ammobox setVectorDir _x #2;
    _loadoutbox = _x #3;
	
	{
    if (count _x > 2) then { //Weapon
        _ammobox addWeaponWithAttachmentsCargoGlobal [_x, 1];
    } else { //Item
        _x params ["_class", "_count"];
		private _type = _class call BIS_fnc_itemType;
		switch (_type select 0) do {
			case 'Weapon': { 
				_ammobox addWeaponCargoGlobal [_class, _count];
			};
			case 'Magazine': {
				_ammobox addMagazineCargoGlobal [_class, _count];
			};
			case 'Item': { _ammobox addItemCargoGlobal [_class, _count]; };
			case 'Mine': { _ammobox addItemCargoGlobal [_class, _count]; };
			case 'Equipment': { 
				if ((_type select 1) == "Backpack") then {
					_ammobox addBackpackCargoGlobal [_class, _count];	
				} else {
					_ammobox addItemCargoGlobal [_class, _count];									
				};
			};
			default { systemChat format ["Error: can't get item type: %1", _class]; };
		};	
    }
	} foreach _loadoutbox;
	
} forEach _baza_danuh_box;















