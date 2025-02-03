/*
	There was originally a comment here about not knowing what Subspace was; and I don't want to take the heat from describing what it is on-repo.
	If you're confused; too - please just look it up; wikipedia has a good resource for informal BDSM terminology. Alternatively - talk to people in your local scene.
	Or; you know; if you're some poor schmuck who isn't into this and just has to be here - treat yourself for having to put up with this shit.
*/

/// Rarely applied when spanked - see leather_whip.dm and spanking_pad.dm
/datum/status_effect/subspace
	id = "subspace"
	tick_interval = 10
	duration = 5 MINUTES
	alert_type = null

/datum/status_effect/subspace/on_apply()
	. = ..()
	var/mob/living/carbon/human/target = owner
	target.add_mood_event("subspace", /datum/mood_event/subspace)

/datum/status_effect/subspace/on_remove()
	. = ..()
	var/mob/living/carbon/human/target = owner
	target.clear_mood_event("subspace")

/datum/mood_event/subspace
	description = span_purple("It stings; and it's hard to think...\n")


/// Hips are red after spanking
/datum/status_effect/spanked
	id = "spanked"
	duration = 300 SECONDS
	alert_type = null

/mob/living/carbon/human/examine(mob/user)
	. = ..()
	if(stat >= DEAD || HAS_TRAIT(src, TRAIT_FAKEDEATH) || src == user || !has_status_effect(/datum/status_effect/spanked) || !is_bottomless())
		return

	. += span_purple("[user.p_their(TRUE)] butt has a red tint to it.") + "\n"

/// Applied every time someone with the masochist quirk or bimbo trait is spanked; see leather_whip.dm and spanking_pad.dm
/datum/mood_event/perv_spanked
	description = span_purple("My heart's pumping - it hurts!\n")
	timeout = 5 MINUTES
