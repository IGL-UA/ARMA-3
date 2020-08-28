private _magazines =  magazinesAmmo _target; //magazines 
private _available_magazine_info = [];  //[[magazine, description, icon, число зарядів в магазині] ...]
private _pidgotovleni_snaradu = [];
{private _obj = _x; private _var = magazinesAmmoCargo (_obj); { _x pushBack _obj; } foreach _var; _pidgotovleni_snaradu append _var;} foreach (nearestObjects [_target, ['GroundWeaponHolder_Scripted'], 5]); //приклад [["bn_122mm_OF_462_1", 1, 131b41600# 17: dummyweapon.p3d], ...]
//============ {_pidgotovleni_snaradu append magazinesAmmoCargo (_x)} foreach (nearestObjects [_target, ['GroundWeaponHolder_Scripted'], 5]);
//private _pidgotovleni_snaradu = magazinesAmmo (nearestObjects [_target, ['GroundWeaponHolder_Scripted'], 5] #0); // 5м навколо гармати
{
//	if ((_x isKindOf ["HandGrenade", configFile >> "CfgMagazines"]) || (_x isKindOf ["1Rnd_HE_Grenade_shell",configFile >> "CfgMagazines"])) then {
	if (true) then {
		_available_magazine_info pushBack [
			_x #0,
			getText (configFile >> "CfgMagazines" >> _x #0 >> "displayName"),
			"\bg_arty\data\equip\bg_122mm.paa",    //getText (configFile >> "CfgMagazines" >> _x #0 >> "picture"),
			_x #1,
            _x #2			
		];
	};
} forEach _pidgotovleni_snaradu;

private _actions = [];
if (count (nearestObjects [_target, ['GroundWeaponHolder_Scripted'], 5]) > 0) then {

{
	private _target = _this select 0;
	private _selected_magazine = _x select 0;
    private _action = [
		format["bn_reload_gun:%1",_x], 
		format["%1 (%2)", (_x select 1), (_x select 3)],
		_x select 2, 
        compile format ["
		if (({(_x select 1) > 0} count magazinesAmmoFull _target) > 0) exitWith {hint 'Вже заряжено!';};
		if !(isNull (gunner _target)) exitWith {hint 'Гармата зайнята!'}; 
		_player playAction 'Gear';
		[4, [_target, '%1'], { 
			((_this #0)#0) addMagazine [((_this #0)#1), 1]; 
		{
			_Rearm_Mag = _x;
			if (str _Rearm_Mag == '%3') exitWith {
			_remembers_mags = [];
			_leaves_mags = [];
			_qtE = count (magazinesAmmoCargo _Rearm_Mag);
			_n = 1; 
			{
			if (((_x select 0) == '%1') && (_n == _qtE)) then { 
			DeleteVehicle _Rearm_Mag;
			} else {	
			if (((_x select 0) == '%1')) then {
			_leaves_mags = _leaves_mags + [_x];	
			} else {
			_remembers_mags = _remembers_mags + [_x];	
			};
			}; 
			} forEach (magazinesAmmoCargo _Rearm_Mag);
			if (_n != _qtE) then {  
			_leaves_mags deleteAt 0;
			clearMagazineCargoGlobal _Rearm_Mag;
			{_Rearm_Mag addMagazineCargoGlobal [_x select 0, 1]} forEach _leaves_mags;
			{_Rearm_Mag addMagazineCargoGlobal [_x select 0, 1]} forEach _remembers_mags;
			};
		    };
		    } foreach (nearestObjects [((_this #0)#0), ['GroundWeaponHolder_Scripted'], 5]);
		    hint parsetext format ['Гармата заряджена <br/> %2'];
		}, {hint 'Заряджання перерване'}, 'Заряджаю %2'] call ace_common_fnc_progressBar
		", (_x select 0), (_x select 1), (_x select 4)]
		/*[[гармата, назва магазину],[...] - В одне місце вставляється двома різними способами і з "compile format" і аргументів функції "ace_common_fnc_progressBar" доречі вони беруться через (_this #0) #0. Передаєм не передаваєме, впихуємо не впихуєме, два дня - в трубу....*/
		, 
		{true}, 
		{}, 
		[_selected_magazine, _target], 
		{[0, 0, 0]}, 
		3,
		[false,true,false,false,false],
		{}
		] call ace_interact_menu_fnc_createAction;
    _actions pushBack [_action, [], _target];
} forEach _available_magazine_info;

} else {
{
	private _target = _this select 0;
	private _selected_magazine = _x select 0;
    private _action = [
		format["bn_reload_gun:%1", _x], 
		format["%1", "Відсутні снаряди"],
		"", 
		{
        hint "Підготовте снаряди";
		}, 
		{true}, 
		{}, 
		[_selected_magazine, _target], 
		{[0, 0, 0]}, 
		3,
		[false,true,false,false,false],
		{}
		] call ace_interact_menu_fnc_createAction;
    _actions pushBack [_action, [], _target];
} forEach [["vidsutni_snaryadu"]];	
};
_actions
