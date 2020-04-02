// Цей скрипт вставляється в initPlayerLocal.sqf
//тому використовується змінна (_this select 0) замість неї можна використовувати player
//Видаємо командирам рації (необхідно вимкнути автоматичну видачу радіостанцій у TasckForce)
if (isFormationLeader (_this select 0) and side (_this select 0) == west and zminna == 1) then {
_BackPackLoadout = getUnitLoadout (_this select 0) select 5;
//removeBackpack _this select 0; // Якщо не коментувати то буде видаляти рюкзак який падає під ноги з інвентарьом
_this select 0 addBackpack "tf_rt1523g_rhs";
_this select 0 setUnitLoadout [[],[],[],[],[],_BackPackLoadout,"","",[],[]];
};
if (isFormationLeader (_this select 0) and side (_this select 0) == east and zminna == 1) then {
_BackPackLoadout = getUnitLoadout (_this select 0) select 5;
//removeBackpack _this select 0; // Якщо не коментувати то буде видаляти рюкзак який падає під ноги з інвентарьом
_this select 0 addBackpack "tf_mr3000_rhs";
_this select 0 setUnitLoadout [[],[],[],[],[],_BackPackLoadout,"","",[],[]];
};
if (isFormationLeader (_this select 0) and side (_this select 0) == independent and zminna == 1) then {
_BackPackLoadout = getUnitLoadout (_this select 0) select 5;
//removeBackpack _this select 0; // Якщо не коментувати то буде видаляти рюкзак який падає під ноги з інвентарьом
_this select 0 addBackpack "tf_rt1523g_big_bwmod";
_this select 0 setUnitLoadout [[],[],[],[],[],_BackPackLoadout,"","",[],[]];
};
