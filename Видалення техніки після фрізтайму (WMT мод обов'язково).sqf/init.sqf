// чекаємо поки завершиться фрізтайм і продовжуємо скрипт
waitUntil {sleep 1; WMT_pub_frzState > 1};
sleep 2; 
if (zminna == 1) then {
[allMasive] execVM "scripts\deletevehicals.sqf"; // передаємо масив з даними про командирів та техніку та видаляємо техніку де не має екіпажу та командирів підрозділів
} else {nil};