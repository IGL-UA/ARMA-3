//Встановлюємо для кого буде вимкнено фрізтайм
_unitOffFriz = p1;
//Вимикаємо фрізтайм
if (player == _unitOffFriz) then {
WMT_pub_frzState = 3;
} else {nil};
//Видаляємо маркери WMT
{  
_currMarker = toArray _x; 
if(count _currMarker >= 15) then { 
_currMarker resize 15; 
_currMarker = toString _currMarker; 
if(_currMarker == "WMT_PrepareTime" or _currMarker == "WMTPlayerFreeze") then { 
if (getpos _unitOffFriz distance2D getMarkerpos _x < 1) then {deleteMarker _x;};				
}; 
}; 
} foreach allMapMarkers; 
