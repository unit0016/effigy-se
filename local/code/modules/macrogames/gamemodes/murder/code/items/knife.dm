/obj/item/knife/combat/macrogames_murderer
	force = 300
	throwforce = 300

/obj/item/knife/combat/macrogames_murderer/attempt_pickup(mob/user)
	if(!IS_MURDERER(user))
		to_chat(user, span_danger("You feel pins and needles in the back of your head as you reach for the knife..."))
		return FALSE
	return ..()
