_allMasive = _this select 0; 

if (zminna == 1 and isServer) then {
{

if (isNull (_x select 0)) then {
                                (_x select 1) remoteExec ["deleteVehicle"];
							   };

} forEach _allMasive;

zminna = 2;
publicVariable "zminna";
} else {nil};