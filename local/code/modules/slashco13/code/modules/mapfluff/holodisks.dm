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

/datum/preset_holoimage/borgmire
	nonhuman_mobtype = /mob/living/basic/slasher/borgmire

/obj/item/disk/holodisk/slashco/slashpoint
	name = "Blackbox Print-out ('Rimpoint')"
	preset_image_type = /datum/preset_holoimage/syndicate_researcher
	preset_record_text = {"
	NAME Victoria Sandys
	DELAY 20
	SAY Strauss; I understand you want to push forwards.
	DELAY 40
	SAY You and I both fully understand this project has gone beyond it's intended purpose.
	SOUND sound/items/lighter_on.ogg
	DELAY 60
	SAY Yes; I know. But our traditional synthetic loyalty methods have been in place for-
	DELAY 40
	SAY Well; a reason, RO.
	SOUND sound/items/lighter_off.ogg
	DELAY 20
	SAY This project was meant to preserve our lives; not create new ones.
	DELAY 40
	SAY Please; just turn her off. We're on the cusp of a breakthr-
	DELAY 40
	SOUND sound/effects/gravhit.ogg
	DELAY 10
	SAY There's-
	DELAY 5
	SOUND local/code/modules/slashco13/sound/slasher/borgmire/step1.ogg
	DELAY 3
	SOUND local/code/modules/slashco13/sound/slasher/borgmire/step2.ogg
	DELAY 4
	SOUND local/code/modules/slashco13/sound/slasher/borgmire/step3.ogg
	DELAY 5
	SOUND local/code/modules/slashco13/sound/slasher/borgmire/step4.ogg
	SAY Strauss, breach. Check i-
	DELAY 10
	SOUND local/code/modules/slashco13/sound/slasher/borgmire/breath_chase.ogg
	SOUND sound/weapons/resonator_blast.ogg
	PRESET /datum/preset_holoimage/borgmire
	LANGUAGE /datum/language/machine
	NAME Borgmire
	DELAY 40
	SAY Goodnight, doctor Sandys.
	DELAY 40
	SAY Now...
	SOUND sound/machines/computer/keyboard_clicks_2.ogg
	DELAY 15
	SAY Rise, dreamer.
	SOUND sound/machines/computer/computer_end.ogg
	DELAY 40"} // absolute cinema

/// SLASHMA OCTANTIS ///

/obj/item/disk/holodisk/slashco/slashma_octantis
	name = "Blackbox Print-out ('TO WHOEVER FINDS THIS')"
	preset_image_type = /datum/preset_holoimage/captain
	preset_record_text = {"
	NAME Jake Brunwick
	DELAY 20
	SAY Let this be my final recording.
	DELAY 40
	SAY We lost contact with the mainland - and, by extension, Central Command, four days ago.
	DELAY 50
	SAY Under current circumstances, we - I - can only... can only assume the worst. We've fallen.
	DELAY 50
	SAY Those bastards finally.. they finally. It's fucked, it's done.
	DELAY 40
	SOUND sound/voice/human/male_sigh.ogg
	DELAY 10
	SAY Ordinarily, this would be cause for deliberation. My crew was sturdy and headstrong, we had...
	DELAY 50
	SAY We had everything.
	DELAY 30
	SAY We could've kept going, kept lookin'. Lookin towards, well. Our namesake.
	DELAY 40
	SAY Even crushed against the ice as we've been, stuck surfaced, we had a chance to stick to our guns.
	DELAY 50
	SAY 'cept for one thing.
	DELAY 20
	SAY It started small - the clown went missing. We figured it was business as usual, there, but...
	DELAY 40
	SAY Then our assistants. Then; our researchers, the miners, when they returned... little by little.
	DELAY 50
	SAY Everyone.
	DELAY 30
	SOUND local/code/modules/slashco13/sound/slasher/bababooey/breathing.ogg
	SAY What's left of security and I deliberated. We stay here, in the bridge.
	DELAY 50
	SAY Whatever it is comes to us.
	SOUND local/code/modules/slashco13/sound/slasher/bababooey/laugh1.ogg
	DELAY 40
	SAY I-"}
