#define AROUSAL_REMOVAL_AMOUNT -12
#define STAMINA_REMOVAL_AMOUNT_EXTERNAL 15
#define STAMINA_REMOVAL_AMOUNT_SELF 8

/// Lowers arousal and pleasure by a bunch to not chain climax.

/datum/status_effect/climax
	id = "climax"
	tick_interval = 1 SECONDS
	duration = 10 SECONDS
	alert_type = null

/datum/status_effect/climax/tick()
	if(!owner.client?.prefs?.read_preference(/datum/preference/toggle/erp/sex_toy))
		return

	var/mob/living/carbon/human/affected_mob = owner

	owner.reagents.add_reagent(/datum/reagent/drug/aphrodisiac/dopamine, 0.5)
	owner.adjustStaminaLoss(STAMINA_REMOVAL_AMOUNT_EXTERNAL)
	affected_mob.adjust_arousal(AROUSAL_REMOVAL_AMOUNT)
	affected_mob.adjust_pleasure(AROUSAL_REMOVAL_AMOUNT)

/// A second step in preventing chain climax, and also prevents spam.
/datum/status_effect/climax_cooldown
	id = "climax_cooldown"
	tick_interval = 1 SECONDS
	duration = 30 SECONDS
	alert_type = null

/datum/status_effect/climax_cooldown/tick()
	var/obj/item/organ/external/genital/vagina/vagina = owner.get_organ_slot(ORGAN_SLOT_VAGINA)
	var/obj/item/organ/external/genital/testicles/balls = owner.get_organ_slot(ORGAN_SLOT_TESTICLES)
	var/obj/item/organ/external/genital/testicles/penis = owner.get_organ_slot(ORGAN_SLOT_PENIS)
	var/obj/item/organ/external/genital/testicles/anus = owner.get_organ_slot(ORGAN_SLOT_ANUS)

	if(penis)
		penis.aroused = AROUSAL_NONE
	if(vagina)
		vagina.aroused = AROUSAL_NONE
	if(balls)
		balls.aroused = AROUSAL_NONE
	if(anus)
		anus.aroused = AROUSAL_NONE
