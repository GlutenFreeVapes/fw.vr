// CBA SETTINGS ///////////////////////////////////////////////////////////////////////////////////
/*
	- File to define settings handled by CBA, could be from various mods such as ACE3, ACRE2 etc.,
	  but also from scripted components like Diwakos punish-unknown-weapons.
	  no force = default
	  1x force = overwrite clients
	  2x force = overwrite mission
*/
///////////////////////////////////////////////////////////////////////////////////////////////////
// ACE Advanced Ballistics
force ace_advanced_ballistics_enabled = true; //advanced ballistics enabled
force ace_advanced_ballistics_ammoTemperatureEnabled = true;
force ace_advanced_ballistics_barrelLengthInfluenceEnabled = true;
force ace_advanced_ballistics_bulletTraceEnabled = true;
force ace_advanced_ballistics_muzzleVelocityVariationEnabled = true;
force ace_advanced_ballistics_simulationInterval = 0.05;

// ACE Advanced Fatigue
force ace_advanced_fatigue_enabled = false; //advanced fatigue disabled
ace_advanced_fatigue_enableStaminaBar = true; //show stamina bar
ace_advanced_fatigue_fadeStaminaBar = true; //fade stamina bar
force ace_advanced_fatigue_loadFactor = 1; //lower means less impact of weight
force ace_advanced_fatigue_performanceFactor = 1; //higher = better
force ace_advanced_fatigue_recoveryFactor = 1; //higher means faster
force ace_advanced_fatigue_swayFactor = 1; //higher means more sway
force ace_advanced_fatigue_terrainGradientFactor = 1; //higher means more affected by terrain

// ACE Advanced Throwing
force ace_advanced_throwing_enabled = true; //advanced throwing enabled
force ace_advanced_throwing_enablePickUp = true;
force ace_advanced_throwing_enablePickUpAttached = true;
ace_advanced_throwing_showMouseControls = true; //show controls
ace_advanced_throwing_showThrowArc = true; //show throwing arc

// ACE Arsenal
force ace_arsenal_allowDefaultLoadouts = true;
force ace_arsenal_allowSharedLoadouts = true;
ace_arsenal_camInverted = false;
force ace_arsenal_enableIdentityTabs = true;
ace_arsenal_enableModIcons = true;
ace_arsenal_EnableRPTLog = true;
ace_arsenal_fontHeight = 4.5;

// ACE Artillery
force ace_artillerytables_disableArtilleryComputer = true; //no artillery computer
force ace_mk6mortar_allowComputerRangefinder = false; //disallow mk6 artillery computer
force ace_artillerytables_advancedCorrections = false; //artillery air resistance off
force ace_mk6mortar_airResistanceEnabled = false; //no mk6 mortar air resistance
force ace_mk6mortar_allowCompass = true; //allow mk6 compass
force ace_mk6mortar_useAmmoHandling = true; //use ammunition handling

// ACE Captives
force ace_captives_allowSurrender = true; //allow surrendering
force ace_captives_allowHandcuffOwnSide = true; //can handcuff own side
force ace_captives_requireSurrender = 2; //require surrender or no weapon in hand
force ace_captives_requireSurrenderAi = false; //don't require AI surrender

// ACE Common
force ace_common_allowFadeMusic = true; //allow ace scripts to turn down music
force force ace_common_checkPBOsAction = 0; //hard set only warn once for missing pbo
force force ace_common_checkPBOsCheckAll = false; //hard set do not check all pbos
force force ace_common_checkPBOsWhitelist = "[]"; //hard set no specific whitelist
ace_common_displayTextColor = [0,0,0,0.1];
ace_common_displayTextFontColor = [1,1,1,1];
ace_common_settingFeedbackIcons = 1;
ace_common_settingProgressBarLocation = 0;
force ace_noradio_enabled = true; //mute player controller avatar (voice callouts)
ace_parachute_hideAltimeter = true; //hide parachute altimeter

// ACE Cook off
force ace_cookoff_enable = 2; //enable damage handling and turret effect for both player and AI vics (might cause issues with mod vehicles?)
force ace_cookoff_ammoCookoffDuration = 0.8; //slightly lower cookoff duration
force ace_cookoff_enableAmmobox = true; //enable ammobox cookoff
force ace_cookoff_enableAmmoCookoff = true; //enable ammo cookoff
force ace_cookoff_probabilityCoef = 0.8; //slightly lowered cookoff chance

// ACE Crew Served Weapons
force ace_csw_defaultAssemblyMode = false; //disable crew served weapon handling
force ace_csw_ammoHandling = 1; //don't use csw handling for AI turrets
ace_csw_dragAfterDeploy = false; //don't start dragging the tripod after deploying automatically
force ace_csw_handleExtraMagazines = true; //store csw magazines next to turret
force ace_csw_progressBarTimeCoefficent = 0.8; //slightly lowered csw deploy time coeff.

// ACE Explosives
force ace_explosives_explodeOnDefuse = true; //explode on defusal
force ace_explosives_punishNonSpecialists = true; //punish non specialists
force ace_explosives_requireSpecialist = false; //don't require specialits

// ACE Fragmentation Simulation
force ace_frag_enabled = true; //enable fragmentation simulation
force ace_frag_maxTrack = 5; //half the fragments tracked for performance
force ace_frag_maxTrackPerFrame = 5; //half the fragments tracked per frame also for performance
force ace_frag_reflectionsEnabled = true; //enable explosion reflection
force ace_frag_spallEnabled = true; //enable spalling

// ACE G-Forces
force ace_gforces_enabledFor = 1; //gforces enabled for aircraft only
force ace_gforces_coef = 1;

// ACE Goggles
ace_goggles_effects = 2; //enable tint + effect
force ace_goggles_showClearGlasses = true; //do show wipe glasses self-interact
ace_goggles_showInThirdPerson = false;

// ACE Hearing
force ace_hearing_enableCombatDeafness = false; //disable combat deafness
force ace_hearing_autoAddEarplugsToUnits = true; //automatically add earplugs to unit
force ace_hearing_disableEarRinging = true; //disable ear ringing
force ace_hearing_earplugsVolume = 0.5; //volume with earplugs
force ace_hearing_enabledForZeusUnits = false; //no advanced hearing for remote controlled unit
ace_hearing_unconsciousnessVolume = 0.8; //unconsious volume

// ACE Interaction
force force ace_interaction_disableNegativeRating = true; //hard disable negative rating cuz it sucks
force ace_interaction_enableMagazinePassing = true; //show pass magazine action
force ace_interaction_enableTeamManagement = true; //show team management actions

// ACE Interaction Menu
ace_gestures_showOnInteractionMenu = 2; //show gestures on interaction menu and keybinds
ace_interact_menu_actionOnKeyRelease = true; //do action when releasing the action
ace_interact_menu_addBuildingActions = true; //show actions on buildings such as ladder climbing and door opening
ace_interact_menu_alwaysUseCursorInteraction = true; //display cursor for action
ace_interact_menu_alwaysUseCursorSelfInteraction = true; //display cursor for action
ace_interact_menu_colorShadowMax = [0,0,0,1];
ace_interact_menu_colorShadowMin = [0,0,0,0.25];
ace_interact_menu_colorTextMax = [1,1,1,1];
ace_interact_menu_colorTextMin = [1,1,1,0.25];
ace_interact_menu_cursorKeepCentered = false; //don't keep cursor centered
ace_interact_menu_cursorKeepCenteredSelfInteraction = false; //don't keep cursor centered
ace_interact_menu_menuAnimationSpeed = 0;
ace_interact_menu_menuBackground = 0;
ace_interact_menu_menuBackgroundSelf = 0;
ace_interact_menu_selectorColor = [1,0,0];
ace_interact_menu_shadowSetting = 2;
ace_interact_menu_textSize = 3;
ace_interact_menu_useListMenu = true; //use lists as menus
ace_interact_menu_useListMenuSelf = true; //use lists as menus

// ACE Logistics
force ace_cargo_enable = true; //enable cargo
force ace_cargo_loadTimeCoefficient = 2; //cargo load time coeff (higher means slower)
force ace_cargo_paradropTimeCoefficent = 1; //paradrop time coeff (higher means slower I think?)
force ace_rearm_distance = 20; //max rearm distance
force ace_rearm_level = 1; //rearm entire magazine
force ace_rearm_supply = 1; //limites amount based on caliber
force ace_refuel_hoseLength = 20; //refuel rope length
force ace_refuel_rate = 2; //refuel rate (higher means faster)
force ace_repair_addSpareParts = true; //add spare parts
force ace_repair_autoShutOffEngineWhenStartingRepair = true; //auto shut off engine on repair
force ace_repair_consumeItem_toolKit = 0; //don't consume toolkit on repair
ace_repair_displayTextOnRepair = false; //don't display hint when you're repairing
force ace_repair_engineerSetting_fullRepair = 1; //only engineer can full repair
force ace_repair_engineerSetting_repair = 0; //anyone can repair
force ace_repair_engineerSetting_wheel = 0; //anyone can repair wheel
force ace_repair_fullRepairLocation = 0; //full repair can happen anywhere
force ace_repair_fullRepairRequiredItems = ["ToolKit"]; //full repair needs toolkit
force ace_repair_miscRepairRequiredItems = ["ToolKit"]; //repair need toolkit
force ace_repair_repairDamageThreshold = 0.6; //0.6 of the damage can be repaired per repair by anyone
force ace_repair_repairDamageThreshold_engineer = 0.4; //an additional 0.4 of the damage can be repaired by engineers
force ace_repair_wheelRepairRequiredItems = []; //no requirements for wheel repair

// ACE Magazine Repack
force ace_magazinerepack_timePerAmmo = 1; //half the default time
force ace_magazinerepack_timePerBeltLink = 4; //half the default time
force ace_magazinerepack_timePerMagazine = 1.5; //half the default time

// ACE Map
force ace_map_BFT_Enabled = false; //disable BFT by default cuz most people use the LMF one
force ace_map_BFT_HideAiGroups = true; //if you enable BFT then hide AI groups
force ace_map_BFT_Interval = 1; //default update interval
force ace_map_BFT_ShowPlayerNames = false; //don't show player names
force ace_map_DefaultChannel = 1; //set side channel as default channel
force ace_map_mapGlow = true; //enable map glow by map flashlights
force ace_map_mapIllumination = true; //enable map illumination by light sources
force ace_map_mapLimitZoom = false; //don't limit map zoom
force ace_map_mapShake = false; //disable map shake
force ace_map_mapShowCursorCoordinates = false; //do not show cursor coordinates on map
force ace_markers_moveRestriction = 0; //anyone can move markers

// ACE Map Gestures
force force ace_map_gestures_enabled = true; //hard enable map gestures
ace_map_gestures_defaultColor = [1,0.88,0,0.7];
ace_map_gestures_defaultLeadColor = [1,0.88,0,0.95];
force ace_map_gestures_interval = 0.03; //update interval
force ace_map_gestures_maxRange = 10; //set max range to 10m instead of 7m
ace_map_gestures_nameTextColor = [0.2,0.2,0.2,0.3];
force ace_map_gestures_onlyShowFriendlys = false; //don't only show friendly map gestures

// ACE Map Tools
ace_maptools_drawStraightLines = true;
ace_maptools_rotateModifierKey = 1;

// ACE Medical
force force ace_medical_ai_enabledFor = 1; //hard enable medical AI for server and HC only
force ace_medical_AIDamageThreshold = 1; //AI damage threshold 1 (default)
force ace_medical_bleedingCoefficient = 0.5; //half the bleeding speed
force ace_medical_blood_bloodLifetime = 600; //500 seconds blood sprinkles lifetime
force ace_medical_blood_enabledFor = 2; //blood effects enabled for everyone
force ace_medical_blood_maxBloodObjects = 500; //max blood objects 500
force ace_medical_fatalDamageSource = 0; //fatal damage source set to only hit's to important vital shit
ace_medical_feedback_bloodVolumeEffectType = 0;
ace_medical_feedback_painEffectType = 0;
force ace_medical_fractureChance = 0.4; //40% fracture chance
force ace_medical_fractures = 1;//enable fractures and splints fully heal them
ace_medical_gui_enableActions = 0;
force force ace_medical_gui_enableMedicalMenu = 1; //hard enable medical menu so retards definitelly have it
ace_medical_gui_enableSelfActions = true;
force ace_medical_gui_maxDistance = 5; //medical menu max range 5 meters
ace_medical_gui_openAfterTreatment = true;
force ace_medical_ivFlowRate = 10; //10x speed for IVs because no one likes waiting
force ace_medical_limping = 1; //limbing on open wounds
force ace_medical_painCoefficient = 0.5; //half the pain
force ace_medical_playerDamageThreshold = 3; //3x player damage resistance
force ace_medical_spontaneousWakeUpChance = 0.75; //75% chance to wake up by yourself
force ace_medical_spontaneousWakeUpEpinephrineBoost = 15; //15x boost to the above by epi
force ace_medical_statemachine_AIUnconsciousness = false; //no AI unconsiousness
force ace_medical_statemachine_cardiacArrestTime = 900; //900 seconds cardiac arrest time
force ace_medical_statemachine_fatalInjuriesAI = 0; //can always inflict fatal injuries to AI
force ace_medical_statemachine_fatalInjuriesPlayer = 1; //can only inflict fatal injuries in cardiac arrest for players
force ace_medical_treatment_advancedBandages = 1; //advanced bandages enabled with no re-opening
force ace_medical_treatment_advancedDiagnose = true; //advanced diagnose enabled (just means it shows the actual pulse and such)
force ace_medical_treatment_advancedMedication = false; //no overdosing
force ace_medical_treatment_allowLitterCreation = true; //enable litter creation
force ace_medical_treatment_allowSelfIV = 1; //do allow self IV
force ace_medical_treatment_allowSelfPAK = 1; //do alow self pak
force ace_medical_treatment_allowSelfStitch = 1; //do allow self stich
force ace_medical_treatment_allowSharedEquipment = 1; //use medic equipment first
force ace_medical_treatment_clearTraumaAfterBandage = false; //don't clear trauma after bandage (means that there will be weapon sway even after banadage unless you get pak'd etc)
force ace_medical_treatment_consumePAK = 0; //don't consume pak
force ace_medical_treatment_consumeSurgicalKit = 0; //don't consume stitching kit
force force ace_medical_treatment_convertItems = 0; //hard force enable the converting of vanilla items to ace ones
force ace_medical_treatment_cprSuccessChance = 0.75; //75% chance of CPR to succeed
force force ace_medical_treatment_holsterRequired = 0; //hard disable the requirement of holstering your weapon to do medical
force ace_medical_treatment_litterCleanupDelay = 500; //500 seconds lifetime for litter objects
force ace_medical_treatment_locationEpinephrine = 0; //allow epi-pen everywhere
force ace_medical_treatment_locationPAK = 0; //allow pak everywhere
force ace_medical_treatment_locationsBoostTraining = false; //locations don't boost training
force ace_medical_treatment_locationSurgicalKit = 0; //can use stitching kit anywhere
force ace_medical_treatment_maxLitterObjects = 300; //max of 300 litter items
force ace_medical_treatment_medicEpinephrine = 0; //anyone can use epi-pen
force ace_medical_treatment_medicIV = 0; //anyone can use IV
force ace_medical_treatment_medicPAK = 1; //medic can use pak
force ace_medical_treatment_medicSurgicalKit = 1; //medic can use stitching kit
force ace_medical_treatment_timeCoefficientPAK = 1; //normal pak speed
force ace_medical_treatment_woundReopenChance = 1; //normal wound reopening coeff. (it's soft disabled anyway though)

// ACE Name Tags
ace_nametags_showPlayerNames = 1; //show player names for players
ace_nametags_defaultNametagColor = [0.77,0.51,0.08,1];
ace_nametags_nametagColorBlue = [0.67,0.67,1,1];
ace_nametags_nametagColorGreen = [0.67,1,0.67,1];
ace_nametags_nametagColorMain = [1,1,1,1];
ace_nametags_nametagColorRed = [1,0.67,0.67,1];
ace_nametags_nametagColorYellow = [1,1,0.67,1];
ace_nametags_playerNamesMaxAlpha = 0.8;
force ace_nametags_playerNamesViewDistance = 5; //nametag max distance of 5m
ace_nametags_showCursorTagForVehicles = true;
ace_nametags_showNamesForAI = false;
ace_nametags_showPlayerRanks = true;
ace_nametags_showSoundWaves = 1;
ace_nametags_showVehicleCrewInfo = true;
ace_nametags_tagSize = 2;

// ACE Nightvision
force ace_nightvision_disableNVGsWithSights = false; //don't disable nvgs in sights
force ace_nightvision_aimDownSightsBlur = 0.4; //40% of the sights blur
force ace_nightvision_effectScaling = 1; //normal effect scaling
force ace_nightvision_fogScaling = 0.4; //40% of the fog
force ace_nightvision_noiseScaling = 0.4; //40% of the noise
force ace_nightvision_shutterEffects = true; //do use shutter effects (whatever that is)

// ACE Overheating
force ace_overheating_enabled = true; //enable overheating
ace_overheating_displayTextOnJam = false; //don't display hint
force ace_overheating_overheatingDispersion = true; //enable dispersion
ace_overheating_showParticleEffects = true; //show particle effects
ace_overheating_showParticleEffectsForEveryone = false; //handle effect locally (performance reasons)
force ace_overheating_unJamFailChance = 0.1; //10% chance to fail clearing a jam
force ace_overheating_unJamOnreload = false; //don't clear jam on reload

// ACE Pointing
force force ace_finger_enabled = true; //hard enforce pointing
ace_finger_indicatorColor = [0.83,0.68,0.21,0.75];
ace_finger_indicatorForSelf = true;
force ace_finger_maxRange = 7; //max range 7m instead of 5m

// ACE Pylons
force ace_pylons_enabledForZeus = true; //enable pylon menu for zeus
force ace_pylons_enabledFromAmmoTrucks = true; //enable pylon menu from ammo trucks
force ace_pylons_rearmNewPylons = true; //rearm new pylons
force ace_pylons_requireEngineer = false; //you don't have to be an engineer to do it
force ace_pylons_requireToolkit = true; //it does require a toolkit
force ace_pylons_searchDistance = 15; //15m search distance if ammo trucks are nearby
force ace_pylons_timePerPylon = 5; //5s per pylon for rearm

// ACE Quick Mount
force ace_quickmount_distance = 4; //4m quickmount action distance
force force ace_quickmount_enabled = true; //hard enable quickmount action
force force ace_quickmount_enableMenu = 3; //hard enable quickmount menu action to show both get in and change seat
ace_quickmount_priority = 0;
force ace_quickmount_speed = 20; //20kmh max speed for quickmount

// ACE Respawn
force ace_respawn_removeDeadBodiesDisconnected = true; //remove dead bodies on disconnect
force ace_respawn_savePreDeathGear = false; //don't save deathgear

// ACE Scopes
force ace_scopes_enabled = true; //enable ace scope zeroing
force force ace_scopes_correctZeroing = false; //hard dissable the correct zeroing for small arms as it breaks some sights on some guns
force ace_scopes_deduceBarometricPressureFromTerrainAltitude = false; //don't deduce the pressure from terrain altitude (it's default off and I dunno what is does so I'll just leve it off)
force ace_scopes_defaultZeroRange = 100; //100m default zero with high powered scopes
force ace_scopes_forceUseOfAdjustmentTurrets = false; //don't adjust zeroing on the "scopes" of high powered turrets
force ace_scopes_overwriteZeroRange = false; //don't overwrite zeroing range of high powered scopes
force ace_scopes_simplifiedZeroing = false; //don't use the old simplified zeroing of 100m increments
ace_scopes_useLegacyUI = false;
force ace_scopes_zeroReferenceBarometricPressure = 1013.25; //default value of barometric pressure
force ace_scopes_zeroReferenceHumidity = 0.35; //average room humidity
force ace_scopes_zeroReferenceTemperature = 22; //average room temperature

// ACE Spectator
force ace_spectator_enableAI = true; //enable AI in spec
ace_spectator_maxFollowDistance = 5;
force ace_spectator_restrictModes = 0; //don't restrict camera viewmodes
force ace_spectator_restrictVisions = 0; //don't restrict vision modes

// ACE Switch Units
force ace_switchunits_enableSwitchUnits = false; //don't enable switching off units via ace
force ace_switchunits_enableSafeZone = true;
force ace_switchunits_safeZoneRadius = 100;
force ace_switchunits_switchToCivilian = false;
force ace_switchunits_switchToEast = false;
force ace_switchunits_switchToIndependent = false;
force ace_switchunits_switchToWest = false;

// ACE Uncategorized
force ace_fastroping_requireRopeItems = false; //don't require rope to fast rope
force ace_gunbag_swapGunbagEnabled = true; //enable gunbag swapping
force ace_hitreactions_minDamageToTrigger = 0.1; //default coefficient to trigger falling damage
ace_inventory_inventoryDisplaySize = 0;
force ace_laser_dispersionCount = 2; //default value of ace laser dispersion count (not even sure what that does)
force ace_microdagr_mapDataAvailable = 2; //microdagr map data is full sat. image + buildings
force ace_microdagr_waypointPrecision = 3; //waypoint precision is down to 1m
ace_optionsmenu_showNewsOnMainMenu = true;
force ace_overpressure_distanceCoefficient = 1; //normal overpressure coeff.
ace_tagging_quickTag = 1;

// ACE User Interface
force ace_ui_allowSelectiveUI = true; //allow clients to customize their ui selectively
ace_ui_ammoCount = false; //show ammo count
ace_ui_ammoType = true; //show ammo type
ace_ui_commandMenu = true; //show command menu
ace_ui_firingMode = true; //show firing mode
ace_ui_groupBar = true; //show group bar
ace_ui_gunnerAmmoCount = true; //show ammo count as gunner
ace_ui_gunnerAmmoType = true; //show ammo type as gunner
ace_ui_gunnerFiringMode = true; //show firing mode as gunner
ace_ui_gunnerLaunchableCount = true; //show launchable count as gunner
ace_ui_gunnerLaunchableName = true; //show launchable name as gunner
ace_ui_gunnerMagCount = true; //show mag count as gunner
ace_ui_gunnerWeaponLowerInfoBackground = true; //show gunner weapon info background
ace_ui_gunnerWeaponName = true; //show gunner weapon name
ace_ui_gunnerWeaponNameBackground = true; //show gunner weapon name background
ace_ui_gunnerZeroing = true; //show gunner zeroing
ace_ui_magCount = true; //show mag count
ace_ui_soldierVehicleWeaponInfo = true; //show vehicle weapon info
ace_ui_staminaBar = true; //show stamina bar
ace_ui_stance = true; //show stance
ace_ui_throwableCount = true; //show throwable count
ace_ui_throwableName = true; //show throwable name
ace_ui_vehicleAltitude = true; //show vehicle altitude
ace_ui_vehicleCompass = true; //show vehicle compass
ace_ui_vehicleDamage = true; //show vehicle damage
ace_ui_vehicleFuelBar = true; //show vehicle fuel bar
ace_ui_vehicleInfoBackground = true; //show vehicle info background
ace_ui_vehicleName = true; //show vehicle name
ace_ui_vehicleNameBackground = true; //show vehicle name background
ace_ui_vehicleRadar = true; //show vehicle radar
ace_ui_vehicleSpeed = true; //show vehicle speed
ace_ui_weaponLowerInfoBackground = true; //show lower weapon info background
ace_ui_weaponName = true; //show weapon name
ace_ui_weaponNameBackground = true; //show weapon background
ace_ui_zeroing = true; //show zeroing

// ACE Vehicle Lock
force ace_vehiclelock_defaultLockpickStrength = 10; //lockpick strenght (default)
force ace_vehiclelock_lockVehicleInventory = false; //don't lock vehicle inventory
force ace_vehiclelock_vehicleStartingLockState = -1; //have vehicles start as unlocked by default

// ACE Vehicles
force force ace_vehicles_hideEjectAction = false; //hard don't hide the eject action on vehicles (that sucks)
force ace_vehicles_keepEngineRunning = false; //don't force the engine to keep on running
ace_vehicles_speedLimiterStep = 5;

// ACE View Distance Limiter
force ace_viewdistance_enabled = false; //disable view distance limiter
force ace_viewdistance_limitViewDistance = 10000; //max 10km viewdistance limit
ace_viewdistance_objectViewDistanceCoeff = 0;
ace_viewdistance_viewDistanceAirVehicle = 0;
ace_viewdistance_viewDistanceLandVehicle = 0;
ace_viewdistance_viewDistanceOnFoot = 0;

// ACE Weapons
force ace_laserpointer_enabled = true; //enable ace laserpointer
ace_common_persistentLaserEnabled = false; //don't enable persistent laser/flashlight
ace_reload_displayText = false;
force ace_reload_showCheckAmmoSelf = true; //enable self interact to check ammo count of current mag
ace_weaponselect_displayText = false;

// ACE Weather
force ace_weather_enabled = true; //enable ace weather
force ace_weather_showCheckAirTemperature = true; //self interact to check air temperature
force ace_weather_updateInterval = 60; //update interval in seconds of ace weather
force ace_weather_windSimulation = false; //don't base wind simulation on map

// ACE Wind Deflection
force ace_winddeflection_enabled = true; //enable ace wind deflection
force ace_winddeflection_simulationInterval = 0.05;
force ace_winddeflection_vehicleEnabled = true; //enable wind deflection for vehicles

// ACE Zeus
force ace_zeus_autoAddObjects = true; //add objects to zeus
force force ace_zeus_canCreateZeus = 0; //hard encforce the adding of an ace action for admins to give themselves zeus
force ace_zeus_radioOrdnance = false; //no ordnance warning
force ace_zeus_remoteWind = false; //no wind effect
force ace_zeus_revealMines = 0; //no revealing of mines
force force ace_zeus_zeusAscension = false; //hard enforce no ascension warning
force force ace_zeus_zeusBird = false; //hard enforce no bird


// ACEX Field Rations
force acex_field_rations_enabled = false; //disable acex field rations
force acex_field_rations_affectAdvancedFatigue = true;
acex_field_rations_hudShowLevel = 0;
acex_field_rations_hudTransparency = -1;
acex_field_rations_hudType = 0;
force acex_field_rations_hungerSatiated = 1;
force acex_field_rations_terrainObjectActions = true;
force acex_field_rations_thirstQuenched = 1;
force acex_field_rations_timeWithoutFood = 2;
force acex_field_rations_timeWithoutWater = 2;
force acex_field_rations_waterSourceActions = 2;

// ACEX Fortify
acex_fortify_settingHint = 1; //show hint of budget only when you have a fortify tool

// ACEX Headless
force force acex_headless_enabled = false; //HARD DISABLE auto transfer of units to headless (without this, people that are ignorant of locality will break their mission)
force force acex_headless_delay = 60; //hard set this to 60. there is also no need to lower or alter this as long as the auto transfer is disabled
force force acex_headless_endMission = 2; //hard set this to end the mission after 60 seconds if HC is the only one left in the mission
force acex_headless_log = false; //don't write additional logs into .rpt
force acex_headless_transferLoadout = 0; //don't transfer loadouts on transfer (doesn't matter anyway as auto transfer is disabled)

// ACEX Sitting
force acex_sitting_enable = true; //enable ace sitting

// ACEX View Restriction
force acex_viewrestriction_mode = 0; //disable acex view restriction (kinda pointless with our difficulty settings anyway)
force acex_viewrestriction_modeSelectiveAir = 0;
force acex_viewrestriction_modeSelectiveFoot = 0;
force acex_viewrestriction_modeSelectiveLand = 0;
force acex_viewrestriction_modeSelectiveSea = 0;
acex_viewrestriction_preserveView = false;

// ACEX Volume
acex_volume_enabled = true; //enable volume reduction
acex_volume_fadeDelay = 1;
acex_volume_lowerInVehicles = true; //do lower in vehicles
acex_volume_reduction = 5; //reduce volume by 50%
acex_volume_remindIfLowered = false;
acex_volume_showNotification = false;

// ACRE2
force force acre_sys_core_automaticAntennaDirection = true; //hard enforce automatic antenna direction
acre_sys_core_defaultRadioVolume = 0.8;
force acre_sys_core_fullDuplex = true; //full duplex by default
force force acre_sys_core_ignoreAntennaDirection = true; //hard enforce ignore antenna direction
force force acre_sys_core_interference = false; //hard disable model interference
acre_sys_core_postmixGlobalVolume = 1;
acre_sys_core_premixGlobalVolume = 1;
force acre_sys_core_revealToAI = 1;
acre_sys_core_spectatorVolume = 1;
force acre_sys_core_terrainLoss = 1;
force force acre_sys_core_ts3ChannelName = "ACRE2"; //hard set channel name
force force acre_sys_core_ts3ChannelPassword = "123"; //hard set channel password
acre_sys_core_ts3ChannelSwitch = true;
acre_sys_core_unmuteClients = true;
force force acre_sys_signal_signalModel = 1; //hard enforce signal calculation LOS simple

// ACRE2 Animations
radioAnims_ads = false;
radioAnims_handset = false;
force radioAnims_headsets = "[""G_WirelessEarpiece_F""]"; //headpieces that have the headset animation played
radioAnims_userPreference = "Auto";

// ACRE2 UI
acre_sys_gui_volumeColorScale = [[1,1,0,0.5],[1,0.83,0,0.5],[1,0.65,0,0.5],[1,0.44,0,0.5],[1,0,0,0.5]];
acre_sys_list_CycleRadiosColor = [0.66,0.05,1,1];
acre_sys_list_DefaultPTTColor = [1,0.8,0,1];
acre_sys_list_HintBackgroundColor = [0,0,0,0.8];
acre_sys_list_HintTextFont = "RobotoCondensed";
acre_sys_list_LanguageColor = [1,0.29,0.16,1];
acre_sys_list_PTT1Color = [1,0.8,0,1];
acre_sys_list_PTT2Color = [1,0.8,0,1];
acre_sys_list_PTT3Color = [1,0.8,0,1];
acre_sys_list_SwitchChannelColor = [0.66,0.05,1,1];
acre_sys_list_ToggleHeadsetColor = [0.66,0.05,1,1];

// ACRE2 Zeus
acre_sys_zeus_zeusCanSpectate = true; //can join spectators as zeus
acre_sys_zeus_zeusCommunicateViaCamera = true; //can communicate through camera as zeus
acre_sys_zeus_zeusDefaultVoiceSource = false; //default voice source is the remote controlled unit

// CBA UI
cba_ui_notifyLifetime = 4;
cba_ui_StorePasswords = 1;

// CBA Weapons
cba_disposable_dropUsedLauncher = 2;
force force cba_disposable_replaceDisposableLauncher = true; //hard set replacing of disposable launchers
cba_events_repetitionMode = 1;
cba_optics_usePipOptics = true;

// CUP
force CUP_Vehicles_PreventBarrelClip = true; //prevent tank gun clip

// DUI - Squad Radar - Indicators
force diwako_dui_indicators_crew_range_enabled = true; //allow dui vehicle range indicators (higher range of indicators in vehicles)
diwako_dui_indicators_fov_scale = false;
diwako_dui_indicators_icon_buddy = true;
diwako_dui_indicators_icon_leader = true;
diwako_dui_indicators_icon_medic = true;
diwako_dui_indicators_range = 20;
diwako_dui_indicators_range_crew = 300;
diwako_dui_indicators_range_scale = false;
diwako_dui_indicators_show = true;
diwako_dui_indicators_size = 1;
diwako_dui_indicators_style = "standard";
diwako_dui_indicators_useACENametagsRange = true;

// DUI - Squad Radar - Main
diwako_dui_ace_hide_interaction = false;
diwako_dui_colors = "standard";
diwako_dui_font = "PuristaMedium";
diwako_dui_icon_style = "nato";
diwako_dui_main_hide_ui_by_default = false;
diwako_dui_main_squadBlue = [0,0,1,1];
diwako_dui_main_squadGreen = [0,1,0,1];
diwako_dui_main_squadMain = [1,1,1,1];
diwako_dui_main_squadRed = [1,0,0,1];
diwako_dui_main_squadYellow = [1,1,0,1];

// DUI - Squad Radar - Radar
diwako_dui_compass_hide_alone_group = false;
diwako_dui_compass_hide_blip_alone_group = false;
diwako_dui_compass_icon_scale = 1;
diwako_dui_compass_opacity = 1;
diwako_dui_compass_style = ["\z\diwako_dui\addons\radar\UI\compass_styles\milint\limited.paa","\z\diwako_dui\addons\radar\UI\compass_styles\milint\full.paa"];
diwako_dui_compassRange = 35;
diwako_dui_compassRefreshrate = 0;
diwako_dui_dir_showMildot = false;
diwako_dui_dir_size = 1.25;
diwako_dui_distanceWarning = 10;
diwako_dui_enable_compass = true;
diwako_dui_enable_compass_dir = 2;
diwako_dui_enable_occlusion = false;
diwako_dui_enable_occlusion_cone = 360;
diwako_dui_hudScaling = 0.906482;
diwako_dui_namelist = true;
diwako_dui_namelist_bg = 0;
diwako_dui_namelist_only_buddy_icon = false;
diwako_dui_namelist_size = 0.863055;
diwako_dui_namelist_text_shadow = 2;
diwako_dui_namelist_width = 215;
diwako_dui_radar_ace_finger = true;
diwako_dui_radar_compassRangeCrew = 500;
diwako_dui_radar_group_by_vehicle = false;
diwako_dui_radar_icon_scale_crew = 6;
diwako_dui_radar_leadingZeroes = true;
diwako_dui_radar_namelist_hideWhenLeader = false;
diwako_dui_radar_namelist_vertical_spacing = 1.10317;
diwako_dui_radar_occlusion_fade_time = 10;
diwako_dui_radar_pointer_color = [1,0.5,0,1];
diwako_dui_radar_pointer_style = "standard";
diwako_dui_radar_show_cardinal_points = true;
diwako_dui_radar_showSpeaking = true;
diwako_dui_radar_showSpeaking_radioOnly = false;
diwako_dui_radar_showSpeaking_replaceIcon = true;
diwako_dui_radar_sortType = "fireteam2";
diwako_dui_radar_sqlFirst = true;
diwako_dui_radar_trackingColor = [0.93,0.26,0.93,1];
diwako_dui_radar_vehicleCompassEnabled = false;
diwako_dui_reset_ui_pos = false;
diwako_dui_use_layout_editor = false;

// Enhanced Movement Rework
force EMR_main_allowMidairClimbing = true; //allow jump climbing
force EMR_main_blacklist = "Land_WiredFence_01_16m_F,Land_WiredFence_01_4m_F,Land_WiredFence_01_8m_F,Land_Mil_WiredFenceD_F,Land_Mil_WiredFence_F,Land_New_WiredFence_10m_Dam_F,Land_New_WiredFence_10m_F,Land_New_WiredFence_5m_F,Land_NetFence_03_m_9m_F,Land_IndFnc_9_F,Land_IndFnc_3_Hole_F,Land_NetFence_03_m_3m_hole_F,Land_NetFence_03_m_3m_d_F,Land_IndFnc_3_D_F,Land_NetFence_03_m_3m_corner_F,Land_IndFnc_Corner_F,Land_NetFence_03_m_3m_F,Land_IndFnc_3_F,Land_Razorwire_F,Fort_RazorWire,Wire,WireFence"; //jump/climb blacklist
force EMR_main_climbingEnabled = true; //enable climbing
force EMR_main_climbOnDuty = 3.4; //climb stamina cost
force EMR_main_climbOverDuty = 3; //vault stamina cost
force EMR_main_dropDuty = 0.7; //jump down stamin cost
force EMR_main_enableWalkableSurface = true; //put a walkable surface under yourself when climbin on top of objects
force EMR_main_enableWeightCheck = false; //don't check against weight for climbing
force EMR_main_jumpDuty = 1; //jump stamina cost
force EMR_main_jumpingEnabled = true; //enable jumping
force EMR_main_jumpingLoadCoefficient = 1; //jump load coeff multiplier
force EMR_main_jumpVelocity = 3.4; //jump velocity
force EMR_main_maxClimbHeight = 2.6; //jump max height
force EMR_main_maxDropHeight = 5; //max drop height
force EMR_main_maxWeightClimb1 = 100; //max player weight coeff for 1m climb
force EMR_main_maxWeightClimb2 = 85; //max player weight coeff for 2m climb
force EMR_main_maxWeightClimb3 = 60; //max player weight coeff for 3m climb
force EMR_main_maxWeightJump = 100; //max player weight coeff for jump
EMR_main_preventHighVaulting = true; //prevent high edge vaulting down
force EMR_main_staminaCoefficient = 1; //stamina cost coeff default

// GRAD Trenches
force grad_trenches_functions_allowBigEnvelope = true;
force grad_trenches_functions_allowCamouflage = true;
force grad_trenches_functions_allowDigging = true;
force grad_trenches_functions_allowGiantEnvelope = true;
force grad_trenches_functions_allowLongEnvelope = true;
force grad_trenches_functions_allowShortEnvelope = true;
force grad_trenches_functions_allowSmallEnvelope = true;
force grad_trenches_functions_allowVehicleEnvelope = true;
force grad_trenches_functions_bigEnvelopeDigTime = 40;
force grad_trenches_functions_buildFatigueFactor = 1; //stamina cost coeff. (default)
force grad_trenches_functions_camouflageRequireEntrenchmentTool = true; //require entrechment too to add camo
force grad_trenches_functions_giantEnvelopeDigTime = 90;
force grad_trenches_functions_LongEnvelopeDigTime = 100;
force grad_trenches_functions_shortEnvelopeDigTime = 15;
force grad_trenches_functions_smallEnvelopeDigTime = 30;
force grad_trenches_functions_stopBuildingAtFatigueMax = false; //don't stop building at max fatigue
force grad_trenches_functions_vehicleEnvelopeDigTime = 120;

// ITC Land
force force ITC_LAND_CIWS = true; //hard enable ITC stuff

// LAMBS Danger
force lambs_danger_combatShareRange = 200; //200m combat mode share range
force lambs_danger_CQB_formations_COLUMN = false;
force lambs_danger_CQB_formations_DIAMOND = true; //enable diamond as CQB formation
force lambs_danger_CQB_formations_ECH LEFT = false;
force lambs_danger_CQB_formations_ECH RIGHT = false;
force lambs_danger_CQB_formations_FILE = true; //enable file as CQB formation
force lambs_danger_CQB_formations_LINE = false;
force lambs_danger_CQB_formations_STAG COLUMN = false;
force lambs_danger_CQB_formations_VEE = false;
force lambs_danger_CQB_formations_WEDGE = false;
force lambs_danger_CQB_range = 60; //60m CQB range
force force lambs_danger_debug_Drawing = false; //force debug mode off
force force lambs_danger_debug_FSM = false; //force debug mode off
force force lambs_danger_debug_FSM_civ = false; //force debug mode off
force force lambs_danger_debug_functions = false; //force debug mode off
force lambs_danger_disableAIAutonomousManoeuvres = false; //don't disable autonomous group maneuvers
force lambs_danger_disableAICallouts = false; //don't disable AI callouts
force lambs_danger_disableAIDeployStaticWeapons = false; //don't disable deploying of static weapons
force lambs_danger_disableAIFindStaticWeapons = false; //don't disable manning of static weapons
force lambs_danger_disableAIFleeing = true; //dissable AI fleeing
force lambs_danger_disableAIGestures = false; //don't disable AI gestures
force lambs_danger_disableAIHideFromTanksAndAircraft = false; //don't disable AI hiding from tanks and aircraft
force lambs_danger_disableAIImediateAction = false; //don't disable AI immediate reaction
force lambs_danger_disableAIPlayerGroup = true; //disable lambs danger behaviour on player group
force lambs_danger_disableAIPlayerGroupReaction = true; //disable lambs danger behaviour on player group
force lambs_danger_disableAIPlayerGroupSuppression = true; //disable lambs danger behaviour on player group
force lambs_danger_disableAutonomousFlares = false; //don't disable autonomous flares
force lambs_danger_disableAutonomousSmokeGrenades = false; //don't disable autonomous smoke grenades
force lambs_danger_maxRevealValue = 1; //accuracy of shared info coeff
force lambs_danger_minFriendlySuppressionDistance = 5; //how far in m does an AI have to be away from other friendly units to suppress
force lambs_danger_minSuppression_range = 20; //minimum distance that the AI has to be away from enemies before they start suppressing
force lambs_danger_panic_chance = 1; //panic chance 1%
force lambs_danger_radio_backpack = 500; //info sharing max distance in m
force lambs_danger_radio_disabled = true; //do disable info sharing
force lambs_danger_radio_EAST = 200; //info sharing max distance in m
force lambs_danger_radio_GUER = 200; //info sharing max distance in m
force lambs_danger_radio_shout = 20; //info sharing max distance in m
force lambs_danger_radio_WEST = 200; //info sharing max distance in m
force force lambs_danger_RenderExpectedDestination = false; //force debug mode off

// LAMBS Danger Eventhandlers
force lambs_eventhandlers_ExplosionEventHandlerEnabled = true; //do enable the lambs danger explosion eventhandler
force lambs_eventhandlers_ExplosionReactionTime = 9;

// LAMBS Danger WP
force lambs_wp_autoAddArtillery = true; //add artillery units to the lambs artiller module automatically

// NIArms
force force niarms_accswitch = true; //enable model switching for guns for NIARMS
force force niarms_magSwitch = true; //enable model switching for guns for NIARMS

// Zeus Enhanced
zen_camera_adaptiveSpeed = true;
zen_camera_defaultSpeedCoef = 1;
zen_camera_fastSpeedCoef = 1;
zen_camera_followTerrain = false;
force force zen_common_ascensionMessages = false; //hard disable ascension messages
force zen_common_autoAddObjects = false; //don't autoadd objects cuz ace does it anyway
force force zen_common_cameraBird = false; //hard disable zeus bird
zen_common_darkMode = false;
force force zen_common_disableGearAnim = true; //hard disable the zeus gear animation
zen_common_preferredArsenal = 1;
zen_context_menu_enabled = 2;
zen_editor_addGroupIcons = false;
zen_editor_declutterEmptyTree = true;
zen_editor_disableLiveSearch = false;
zen_editor_moveDisplayToEdge = true;
force zen_editor_parachuteSounds = true; // play jet fly by sound when paradropping items
zen_editor_previews_enabled = true;
zen_editor_randomizeCopyPaste = false;
zen_editor_removeWatermark = true;
zen_editor_unitRadioMessages = 2;
zen_placement_enabled = true;
zen_visibility_enabled = true;
zen_vision_enableBlackHot = true;
zen_vision_enableBlackHotGreenCold = false;
zen_vision_enableBlackHotRedCold = false;
zen_vision_enableGreenHotCold = false;
zen_vision_enableNVG = true;
zen_vision_enableRedGreenThermal = false;
zen_vision_enableRedHotCold = false;
zen_vision_enableWhiteHot = true;
zen_vision_enableWhiteHotRedCold = false;