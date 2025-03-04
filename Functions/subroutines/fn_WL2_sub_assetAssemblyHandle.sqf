#include "..\warlords_constants.inc"

params ["_unit"];

_unit addEventHandler ["WeaponAssembled", {
	if (count WL_PLAYER_VEHS >= BIS_WL_assetLimit) then {
		(_this # 0) action ["Disassemble", (_this # 1)];
		playSound 'AddItemFailed';
		[toUpper localize 'STR_A3_WL_popup_asset_limit_reached'] spawn BIS_fnc_WL2_smoothText;
		if ((_this # 1) isKindOf "Man") then {
			deleteVehicle (_this # 1);
		} else {
			(_this # 1) spawn BIS_fnc_WL2_sub_deleteAsset;
		};
	} else {
		if (({getNumber (configFile >> "CfgVehicles" >> typeOf _unit >> "isUav") == 1} count WL_PLAYER_VEHS) >= BIS_WL_autonomous_limit) then {
			(_this # 0) action ["Disassemble", (_this # 1)];
			playSound 'AddItemFailed';
			[toUpper localize 'STR_A3_WL_popup_asset_limit_reached'] spawn BIS_fnc_WL2_smoothText;
			if ((_this # 1) isKindOf "Man") then {
				deleteVehicle (_this # 1);
			} else {
				(_this # 1) spawn BIS_fnc_WL2_sub_deleteAsset;
			};
		} else {
			[player, (_this # 1), TRUE] spawn BIS_fnc_WL2_newAssetHandle;
		};
	};
}];

_unit addEventHandler ["WeaponDisassembled", {
	_arr = WL_PLAYER_VEHS - vehicles;
	if (count _arr > 0) then {
		_ownedVehiclesVarName = format ["BIS_WL_%1_ownedVehicles", getPlayerUID player];
		missionNamespace setVariable [_ownedVehiclesVarName, WL_PLAYER_VEHS - [_arr # 0]];
		publicVariableServer _ownedVehiclesVarName;
	};
}];