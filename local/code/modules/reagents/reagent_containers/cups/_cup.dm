/obj/item/reagent_containers/cup/bucket/attackby_secondary(obj/item/weapon, mob/user, params)
	. = ..()
	if(istype(O, /obj/item/mop))
		if(reagents.total_volume == volume)
			to_chat(user, "The [src.name] can't hold anymore liquids")
			return
		to_chat(user, "You wring out the [attacked_mop.name] into the [src.name].")
		var/obj/item/mop/attacked_mop = O
		attacked_mop.reagents.trans_to(src, attacked_mop.total_reagent_volume * 0.25)
		attacked_mop.reagents.remove_all(attacked_mop.total_reagent_volume)
