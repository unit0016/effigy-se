/obj/item/mop/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/liquids_interaction, TYPE_PROC_REF(/obj/item/mop, attack_on_liquids_turf))

/obj/item/mop/should_clean(datum/cleaning_source, atom/atom_to_clean, mob/living/cleaner)
	var/turf/turf_to_clean = atom_to_clean

	// Disable normal cleaning if there are liquids.
	if(isturf(atom_to_clean) && turf_to_clean.liquids)
		return DO_NOT_CLEAN

	return ..()

/**
 * Proc to remove liquids from a turf using a mop.
 *
 * Arguments:
 * * tile - On which tile we're trying to absorb liquids
 * * user - Who tries to absorb liquids with this?
 * * liquids - Liquids we're trying to absorb.
 */
/obj/item/mop/proc/attack_on_liquids_turf(obj/item/mop/the_mop, turf/T, mob/user, obj/effect/abstract/liquid_turf/liquids)
	if(!user.Adjacent(T))
		return FALSE
	var/free_space = the_mop.reagents.maximum_volume - the_mop.reagents.total_volume
	var/looping = TRUE
	var/speed_mult = 1
	var/datum/liquid_group/targeted_group = T.liquids.liquid_group
	while(looping)
		if(speed_mult >= 0.2)
			speed_mult -= 0.05
		if(free_space <= 0)
			to_chat(user, "<span class='warning'>Your mop can't absorb any more!</span>")
			looping = FALSE
			return TRUE
		if(do_after(user, src.mopspeed * speed_mult, target = T))
			if(the_mop.reagents.total_volume == the_mop.max_reagent_volume)
				to_chat(user, "<span class='warning'>Your [src.name] can't absorb any more!</span>")
				return TRUE
			if(targeted_group.reagents_per_turf)
				targeted_group.trans_to_seperate_group(the_mop.reagents, min(targeted_group.reagents_per_turf, 5))
				to_chat(user, "<span class='notice'>You soak up some liquids with the [src.name].</span>")
			else if(T.liquids.liquid_group)
				targeted_group = T.liquids.liquid_group
			else
				looping = FALSE
		else
			looping = FALSE
	user.changeNext_move(CLICK_CD_MELEE)
	return TRUE
