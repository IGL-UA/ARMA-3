zminna = 1;
publicVariable "zminna";

//Скрипт видалення техніки
waituntil {sleep 1; WMT_pub_frzTimeLeft < 240};  // час фрізтайму після якого запускається запис командирів і техніки в радіусі біля них
_allMasive = [];
{
if (isFormationLeader _x) then {_allMasive append [[_x]];
nObject = nearestObjects [_x, ["Car", "Tank", "Air"], 20]; // де 20 - це радіус в якому буде привязуватися до командира техніка коли час фрізтайму стане меншим 240 сек
_allMasive select ((count _allMasive) - 1) pushBack (nObject select 0);
};
} forEach playableUnits;
allMasive = _allMasive;
publicVariable "allMasive";
