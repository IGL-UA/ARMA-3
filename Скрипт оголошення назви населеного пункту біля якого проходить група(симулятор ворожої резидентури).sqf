//============================================================================//
//     Симулятор ворожої резидентури (можливо зробити модулем)
//        Для запуску виконати [] execVM "residenture.sqf";
//                або вставити в initServer.sqf 
//============================================================================//

//Створюємо масив на сервері та обявляємо його для всіх
mista = [];
publicVariable "mista";

//Створюємо функцію 

fn_module_residenture = {
_perevirka = 5;	
if (side player == west and count nearestLocations [getpos leader baranu, ["NameVillage", "NameCity", "NameCityCapital"], 500] > 0 and getpos leader baranu distance (nearestLocations [getpos leader baranu, ["NameVillage", "NameCity", "NameCityCapital"], 500] #0) <= 500) then {
if (count mista > 0) then {
{
if (text (nearestLocations [getpos leader baranu, ["NameVillage", "NameCity", "NameCityCapital"], 500] #0) isEqualTo _x) exitWith {_perevirka = 1;};
} foreach mista;
if (_perevirka == 1) exitWith {};
if (_perevirka == 5) exitWith {
//Хінт для синіх (поміняти сторону якщо шо)	
parseText format ["<t color='#33cc33' size='1.2' shadow='1' shadowColor='#000000' align='center'>Група була помічена біля</t> <br/> <t color='#ffea00' size='1.2' shadow='1' shadowColor='#000000' align='center'>н.п. %1</t>", text (nearestLocations [getpos leader baranu, ["NameVillage", "NameCity", "NameCityCapital"], 500] #0)] remoteExec ["hint", west];	
mista append [text (nearestLocations [getpos leader baranu, ["NameVillage", "NameCity", "NameCityCapital"], 500] #0)];
};
} else {
if (_perevirka == 5) exitWith {
//Хінт для синіх (поміняти сторону якщо шо)	
parseText format ["<t color='#33cc33' size='1.2' shadow='1' shadowColor='#000000' align='center'>Група була помічена біля</t> <br/> <t color='#ffea00' size='1.2' shadow='1' shadowColor='#000000' align='center'>н.п. %1</t>", text (nearestLocations [getpos leader baranu, ["NameVillage", "NameCity", "NameCityCapital"], 500] #0)] remoteExec ["hint", west];
mista append [text (nearestLocations [getpos leader baranu, ["NameVillage", "NameCity", "NameCityCapital"], 500] #0)];
};
};
};	
	
};

//Запускаємо функцію
_str = true;
while {_str} do { 
[] call fn_module_residenture;
sleep 5;
};
