private _v=_this;

if ((count (crew _v)) < 1) exitWith {false};
if !(_v call DAPS_fnc_HasCharges) exitWith {false};
if !(_v getVariable "dapsActive") exitWith {false};

if (typeOf _v == "O_T_Truck_03_device_ghex_F" || typeof _asset == "O_Truck_03_device_F") then {
	if !(_v getVariable "dazzlerActivated") exitWith {false};
	if (_v getHitPointDamage "hitEngine" > 0.5) exitWith {false};
};

true