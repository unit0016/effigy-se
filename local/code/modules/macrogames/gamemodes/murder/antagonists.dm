// We let the ruleset handle objective assignment as it can assess current station population
/datum/antagonist/macrogames/murderer
	name = "\improper Murderer"

/datum/antagonist/macrogames/murderer/on_gain()
	. = ..()
	equip_murderer()

/datum/antagonist/macrogames/murderer/proc/equip_murderer()
	var/mob/living/carbon/H = owner.current
	if(!istype(H))
		return
	var/obj/item/knife/combat/macrogames_murderer/our_knife = new(H)
	var/where = H.equip_conspicuous_item(our_knife)
	if(!where)
		our_knife.forceMove(H.loc)
