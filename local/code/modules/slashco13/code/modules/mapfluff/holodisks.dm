/obj/item/disk/holodisk/slashco/Initialize(mapload)
	. = ..()
	add_filter("slashco_item", 2, outline_filter(1, COLOR_SYNDIE_RED))

/// SLASHPOINT ///
/datum/outfit/syndicate_empty/researcher
	name = "Syndicate Researcher"
	uniform = /obj/item/clothing/under/rank/rnd/scientist/skyrat/utility/syndicate
	suit = /obj/item/clothing/suit/toggle/labcoat/interdyne
	back = /obj/item/storage/backpack/satchel/science
	ears = /obj/item/radio/headset/syndicate/alt
	mask = /obj/item/clothing/mask/gas/syndicate

/datum/preset_holoimage/syndicate_researcher
	outfit_type = /datum/outfit/syndicate_empty/battlecruiser
	species_type = /datum/species/akula

/obj/item/disk/holodisk/slashco/slashpoint
	name = "Blackbox Print-out ('Rimpoint')"
	preset_image_type = /datum/preset_holoimage/syndicate_researcher
	preset_record_text = {"
	NAME Victoria Sandys
	DELAY 10
	SAY Strauss; I understand you want to push forwards.
	DELAY 20
	SAY You and I both fully understand this project has gone beyond it's intended purpose.
	SOUND sound/items/lighter_on.ogg
	DELAY 30
	SAY Yes; I know. But our traditional synthetic loyalty methods have been in place for-
	DELAY 20
	SAY Well; a reason, RO.
	SOUND sound/items/lighter_off.ogg
	DELAY 10
	SAY This project was meant to preserve our lives; not create new ones.
	DELAY 20
	SAY Please; just turn her off. We're on the cusp of a breakthr-
	DELAY 20"}
