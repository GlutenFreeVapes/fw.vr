class PLUGIN {
	class init {
		file = QPLUGIN_PATHFILES;
		class setParams {postInit = 1;};
		class postInit {postInit = 1;};
	};
	class fnc {
		file = QPLUGIN_PATHFILE(fnc);
		class addLives {};
		class onRespawn {};
		class onRespawnUnit {};
		class playerTimer {};
		class setup {};
	};
};