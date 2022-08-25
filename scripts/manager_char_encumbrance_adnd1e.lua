CharEncumbranceManager.performInit = peformInit;

-- remove coins encumbrance option
function performInit()
	if not _bInitComplete then
		return;
	end

	-- if CharEncumbranceManager.isEnabled() then
	-- 	if _bInitialized then
	-- 		return;
	-- 	end

	-- 	OptionsManager.registerOption2("CURR", false, "option_header_houserule", "option_label_CURR", "option_entry_cycler", 
	-- 			{ labels = "option_val_on", values = "on", baselabel = "option_val_off", baseval = "off", default = "on" });

	-- 	if Session.IsHost then
	-- 		OptionsManager.registerCallback("CURR", CharEncumbranceManager.onCurrencyOptionUpdate);
	-- 		CurrencyManager.registerCallback(CharEncumbranceManager.onCurrencyUpdate);
	-- 		CharEncumbranceManager.enableCharCurrencyHandlers();

	-- 		CharEncumbranceManager.updateAllCharacters();
	-- 	end

	-- 	_bInitialized = true;
	-- end
end