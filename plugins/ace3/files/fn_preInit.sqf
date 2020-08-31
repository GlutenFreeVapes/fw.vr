/* ----------------------------------------------------------------------------
Function: ace3_fnc_preInit

Description:
	Ace3

Parameters:
	none
Returns:
	nothing
Examples:
	call ace3_fnc_preInit;
	Runs in the postInit from functions.cpp

Author:
	nigel
---------------------------------------------------------------------------- */
#include "script_component.cpp"
// Code begins

// check if server or mission settings
private _srv = missionNamespace getVariable ['mission_ace3_srv',false];
private _source = ['mission','server'] select _srv;

// exit non servers
if (!isServer && _srv) exitWith {};

private _enabled = (missionNamespace getVariable ["mission_ace3_enabled",true]);
if !(_enabled) exitWith {};

//ACE 3 Revive Settings ========================================================

//["ace_medical_enableRevive", ACE3_SETTINGS_REVIVE_ENABLE, true, _source, false] call CBA_settings_fnc_set;
//["ace_medical_maxReviveTime", ACE3_SETTINGS_REVIVE_TIME, true, _source, false] call CBA_settings_fnc_set;
//["ace_medical_amountOfReviveLives", ACE3_SETTINGS_REVIVE_LIVES, true, _source, false] call CBA_settings_fnc_set;

//ACE 3 Medical ================================================================

["ace_medical_AIDamageThreshold", ACE3_SETTINGS_AI_HEALTH, true, _source, false] call CBA_settings_fnc_set;
["ace_medical_bleedingcoefficient", ACE3_SETTINGS_MED_BLEED, true, _source, false] call CBA_settings_fnc_set;
["ace_medical_blood_bloodLifetime", ACE3_SETTINGS_MED_BLEED, true, _source, false] call CBA_settings_fnc_set;
["ace_medical_blood_enabledFor", ACE3_SETTINGS_MED_BLEED, true, _source, false] call CBA_settings_fnc_set;
["ace_medical_blood_maxBloodObjects", ACE3_SETTINGS_MED_BLEED, true, _source, false] call CBA_settings_fnc_set;
["ace_medical_fatalDamageSource", 0, true, _source, false] call CBA_settings_fnc_set;
["ace_medical_fractureChance", 0.4, true, _source, false] call CBA_settings_fnc_set;
["ace_medical_fractures", 0, true, _source, false] call CBA_settings_fnc_set;
//["ace_medical_gui_enableMedicalMenu", 1, true, _source, false] call CBA_settings_fnc_set;
["ace_medical_ivFlowRate", 10, true, _source, false] call CBA_settings_fnc_set;
["ace_medical_limping", 1, true, _source, false] call CBA_settings_fnc_set;
["ace_medical_painCoefficient", ACE3_SETTINGS_MED_PAIN, true, _source, false] call CBA_settings_fnc_set;
["ace_medical_playerDamageThreshold", (missionNamespace getVariable ["mission_ace3_med_player_health",ACE3_PARAM_MED_PLAYER_HEALTH]), true, _source, false] call CBA_settings_fnc_set;
["ace_medical_spontaneousWakeUpChance", 0.75, true, _source, false] call CBA_settings_fnc_set;
["ace_medical_spontaneousWakeUpEpinephrineBoost", 15, true, _source, false] call CBA_settings_fnc_set;
["ace_medical_statemachine_AIUnconsciousness", false, true, _source, false] call CBA_settings_fnc_set;

["ace_medical_statemachine_cardiacArrestTime", 0, true, _source, false] call CBA_settings_fnc_set;
["ace_medical_statemachine_fatalInjuriesAI", 0, true, _source, false] call CBA_settings_fnc_set;
["ace_medical_statemachine_fatalInjuriesPlayer", 0, true, _source, false] call CBA_settings_fnc_set;

["ace_medical_treatment_advancedBandages", ACE3_SETTINGS_ADV_WOUNDS, true, _source, false] call CBA_settings_fnc_set;
["ace_medical_treatment_advancedDiagnose", true, true, _source, false] call CBA_settings_fnc_set;
["ace_medical_treatment_advancedMedication", false, true, _source, false] call CBA_settings_fnc_set;
["ace_medical_treatment_allowLitterCreation", true, true, _source, false] call CBA_settings_fnc_set;

["ace_medical_treatment_allowSelfIV", 1, true, _source, false] call CBA_settings_fnc_set;
["ace_medical_treatment_allowSelfPAK", 1, true, _source, false] call CBA_settings_fnc_set;
["ace_medical_treatment_allowSelfStitch", 1, true, _source, false] call CBA_settings_fnc_set;
["ace_medical_treatment_allowSharedEquipment", 1, true, _source, false] call CBA_settings_fnc_set;

["ace_medical_treatment_clearTraumaAfterBandage", false, true, _source, false] call CBA_settings_fnc_set;//ACE3_SETTINGS_ADV_HITPOINTS
["ace_medical_treatment_consumePAK", ACE3_SETTINGS_ADV_PAK_CONSUME, true, _source, false] call CBA_settings_fnc_set;
["ace_medical_treatment_consumeSurgicalKit", 0, true, _source, false] call CBA_settings_fnc_set;
["ace_medical_treatment_convertItems", 1, true, _source, false] call CBA_settings_fnc_set;
["ace_medical_treatment_cprSuccessChance", 0.75, true, _source, false] call CBA_settings_fnc_set;
["ace_medical_treatment_holsterRequired", 0, true, _source, false] call CBA_settings_fnc_set;

["ace_medical_treatment_litterCleanupDelay", 0, true, _source, false] call CBA_settings_fnc_set;
["ace_medical_treatment_locationEpinephrine", 0, true, _source, false] call CBA_settings_fnc_set;
["ace_medical_treatment_locationPAK", 0, true, _source, false] call CBA_settings_fnc_set;
["ace_medical_treatment_locationsBoostTraining", true, true, _source, false] call CBA_settings_fnc_set;
["ace_medical_treatment_locationSurgicalKit", 0, true, _source, false] call CBA_settings_fnc_set;

["ace_medical_treatment_maxLitterObjects", 300, true, _source, false] call CBA_settings_fnc_set;
["ace_medical_treatment_medicEpinephrine", 0, true, _source, false] call CBA_settings_fnc_set;
["ace_medical_treatment_medicIV", 0, true, _source, false] call CBA_settings_fnc_set;
["ace_medical_treatment_medicPAK", 1, true, _source, false] call CBA_settings_fnc_set;
["ace_medical_treatment_medicSurgicalKit", 1, true, _source, false] call CBA_settings_fnc_set;
["ace_medical_treatment_timeCoefficientPAK", 1, true, _source, false] call CBA_settings_fnc_set;
["ace_medical_treatment_woundReopenChance", 1, true, _source, false] call CBA_settings_fnc_set;

//ACE 3 Captives ===============================================================

["ace_captives_allowHandcuffOwnSide", true, true, _source, false] call CBA_settings_fnc_set;
["ace_captives_allowSurrender", true, true, _source, false] call CBA_settings_fnc_set;
["ace_captives_requireSurrender", 2, true, _source, false] call CBA_settings_fnc_set;

//ACE 3 Varius other settigns ==================================================

// hearing
["ace_hearing_enableCombatDeafness", false, true, _source, false] call CBA_settings_fnc_set;
["ace_hearing_disableEarRinging", true, true, _source, false] call CBA_settings_fnc_set;
["ace_hearing_earplugsVolume", 0.5, true, _source, false] call CBA_settings_fnc_set;

// fatiuge
["ace_advanced_fatigue_enabled", false, true, _source, false] call CBA_settings_fnc_set;
["ace_advanced_fatigue_performanceFactor", 2, true, _source, false] call CBA_settings_fnc_set;
["ace_advanced_fatigue_recoveryFactor", 5, true, _source, false] call CBA_settings_fnc_set;
["ace_advanced_fatigue_swayFactor", 5, true, _source, false] call CBA_settings_fnc_set;
["ace_advanced_fatigue_loadFactor", 0.75, true, _source, false] call CBA_settings_fnc_set;
["ace_advanced_fatigue_terrainGradientFactor", 1, true, _source, false] call CBA_settings_fnc_set;

// repair
["ace_repair_engineerSetting_repair", 0, true, _source, false] call CBA_settings_fnc_set;
["ace_repair_engineerSetting_wheel", 0, true, _source, false] call CBA_settings_fnc_set;
["ace_repair_repairDamageThreshold", 0, true, _source, false] call CBA_settings_fnc_set;
["ace_repair_repairDamageThreshold_engineer", 0.4, true, _source, false] call CBA_settings_fnc_set;
["ace_repair_consumeItem_toolKit", 0, true, _source, false] call CBA_settings_fnc_set;
["ace_repair_fullRepairLocation", 0, true, _source, false] call CBA_settings_fnc_set;
["ace_repair_engineerSetting_fullRepair", 0, true, _source, false] call CBA_settings_fnc_set;
["ace_repair_addSpareParts", true, true, _source, false] call CBA_settings_fnc_set;
["ace_repair_wheelRepairRequiredItems", 0, true, _source, false] call CBA_settings_fnc_set;
["ace_repair_autoShutOffEngineWhenStartingRepair", true, true, _source, false] call CBA_settings_fnc_set;

["ace_rearm_level", 2, true, _source, false] call CBA_settings_fnc_set;
["ace_rearm_supply", 0, true, _source, false] call CBA_settings_fnc_set;

// map
["ace_map_mapShake", true, true, _source, false] call CBA_settings_fnc_set;
["ace_map_mapShowCursorCoordinates", false, true, _source, false] call CBA_settings_fnc_set;
["ace_map_mapIllumination", true, true, _source, false] call CBA_settings_fnc_set;
["ace_map_mapLimitZoom", false, true, _source, false] call CBA_settings_fnc_set;

// wind / ballistics
["ace_winddeflection_enabled", true, true, _source, false] call CBA_settings_fnc_set;
["ace_winddeflection_vehicleEnabled", true, true, _source, false] call CBA_settings_fnc_set;
["ace_advanced_ballistics_enabled", true, true, _source, false] call CBA_settings_fnc_set;
["ace_advanced_ballistics_simulateForSnipers", true, true, _source, false] call CBA_settings_fnc_set;
["ace_advanced_ballistics_simulateForGroupMembers", false, true, _source, false] call CBA_settings_fnc_set;
["ace_advanced_ballistics_simulateForEveryone", false, true, _source, false] call CBA_settings_fnc_set;
["ace_advanced_ballistics_disabledInFullAutoMode", true, true, _source, false] call CBA_settings_fnc_set;
["ace_advanced_ballistics_ammoTemperatureEnabled", true, true, _source, false] call CBA_settings_fnc_set;
["ace_advanced_ballistics_barrelLengthInfluenceEnabled", true, true, _source, false] call CBA_settings_fnc_set;
["ace_advanced_ballistics_bulletTraceEnabled", true, true, _source, false] call CBA_settings_fnc_set;
["ace_advanced_ballistics_muzzleVelocityVariationEnabled", true, true, _source, false] call CBA_settings_fnc_set;

["ace_finger_enabled", true, true, _source, false] call CBA_settings_fnc_set;
["ace_finger_maxRange", 7, true, _source, false] call CBA_settings_fnc_set;
["ace_explosives_requireSpecialist", false, true, _source, false] call CBA_settings_fnc_set;
["ace_explosives_punishNonSpecialists", true, true, _source, false] call CBA_settings_fnc_set;


// weather
["ace_weather_enableServerController", false, true, _source, false] call CBA_settings_fnc_set;
["ace_weather_useACEWeather", false, true, _source, false] call CBA_settings_fnc_set;
["ace_weather_syncRain", false, true, _source, false] call CBA_settings_fnc_set;
["ace_weather_syncWind", false, true, _source, false] call CBA_settings_fnc_set;
["ace_weather_syncMisc", false, true, _source, false] call CBA_settings_fnc_set;


//ACE 3 Respawn Settings
["ace_respawn_SavePreDeathGear", false, true, _source, false] call CBA_settings_fnc_set;
["ace_respawn_RemoveDeadBodiesDisconnected", true, true, _source, false] call CBA_settings_fnc_set;
