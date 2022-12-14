--
-- Please see the license.html file included with this distribution for
-- attribution and copyright information.
--

function onInit()
    registerOptions()
end

function registerOptions()
    OptionsManager.registerOption2(
        "RMMT",
        true,
        "option_header_client",
        "option_label_RMMT",
        "option_entry_cycler",
        {
            labels = "option_val_on|option_val_multi",
            values = "on|multi",
            baselabel = "option_val_off",
            baseval = "off",
            default = "multi"
        }
    )

    OptionsManager.registerOption2(
        "SHRR",
        false,
        "option_header_game",
        "option_label_SHRR",
        "option_entry_cycler",
        {
            labels = "option_val_on|option_val_friendly",
            values = "on|pc",
            baselabel = "option_val_off",
            baseval = "off",
            default = "on"
        }
    )
    OptionsManager.registerOption2(
        "PSMN",
        false,
        "option_header_game",
        "option_label_PSMN",
        "option_entry_cycler",
        {labels = "option_val_on", values = "on", baselabel = "option_val_off", baseval = "off", default = "off"}
    )

    -- auto NPC initiative
    -- change values to off/on, because grouped initiative always occurs in 1e/OSRIC
    OptionsManager.registerOption2(
        "autoNpcInitiative",
        false,
        "option_header_combat",
        "option_label_autoNpcInitiative",
        "option_entry_cycler",
        {labels = "option_val_off", values = "off", baselabel = "option_val_on", baseval = "on", default = "on"}
    )

    OptionsManager.registerOption2(
        "NPCD",
        false,
        "option_header_combat",
        "option_label_NPCD",
        "option_entry_cycler",
        {
            labels = "option_val_fixed",
            values = "fixed",
            baselabel = "option_val_variable",
            baseval = "off",
            default = "off"
        }
    )
    OptionsManager.registerOption2(
        "BARC",
        false,
        "option_header_combat",
        "option_label_BARC",
        "option_entry_cycler",
        {labels = "option_val_tiered", values = "tiered", baselabel = "option_val_standard", baseval = "", default = ""}
    )
    OptionsManager.registerOption2(
        "SHPC",
        false,
        "option_header_combat",
        "option_label_SHPC",
        "option_entry_cycler",
        {
            labels = "option_val_detailed|option_val_status",
            values = "detailed|status",
            baselabel = "option_val_off",
            baseval = "off",
            default = "detailed"
        }
    )
    OptionsManager.registerOption2(
        "SHNPC",
        false,
        "option_header_combat",
        "option_label_SHNPC",
        "option_entry_cycler",
        {
            labels = "option_val_detailed|option_val_status",
            values = "detailed|status",
            baselabel = "option_val_off",
            baseval = "off",
            default = "status"
        }
    )

    -- Set this to deprecating/use options and house rules extension instead
    OptionsManager.registerOption2(
        "HRFC",
        false,
        "option_header_houserule",
        "option_label_HRFC",
        "option_entry_cycler",
        {
            labels = "option_val_fumbleandcrit|option_val_fumble|option_val_crit",
            values = "both|fumble|criticalhit",
            baselabel = "option_val_off",
            baseval = "off",
            default = "off"
        }
    )

    if Interface.getVersion() < 4 then
        OptionsManager.registerOption2(
            "HRDD",
            false,
            "option_header_houserule",
            "option_label_HRDD",
            "option_entry_cycler",
            {
                labels = "option_val_variant",
                values = "variant",
                baselabel = "option_val_standard",
                baseval = "",
                default = ""
            }
        )
    else
        OptionsManager.registerOption2(
            "HRDD",
            false,
            "option_header_houserule",
            "option_label_HRDD",
            "option_entry_cycler",
            {
                labels = "option_val_standard|option_val_variant",
                values = "standard|variant",
                baselabel = "option_val_raw",
                baseval = "raw",
                default = "raw"
            }
        )
    end
end
