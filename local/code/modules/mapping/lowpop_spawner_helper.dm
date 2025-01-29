// See local/code/datums/lowpop_map_adjustments
/obj/effect/lowpop_adjustment
	name = "Lowpop Map Adjustment"
	icon = 'icons/effects/mapping_helpers.dmi'
	icon_state = ""
	plane = POINT_PLANE
	/// Maximum amount of people present before this stops being spawned. Defaults to 15
	var/maximum_population = 15
	/// Jobs that're relevant to this adjustment being needed - if a job from this list is present; no template is spawned
	var/list/relevant_jobs = null
	/// What's the map template we spawn when valid?
	var/datum/map_template/assigned_map_template = null

/obj/effect/lowpop_adjustment/Initialize(mapload)
	. = ..()
	if(!SSticker.HasRoundStarted())
		RegisterSignal(SSticker, COMSIG_TICKER_ROUND_STARTING, PROC_REF(round_start))
	else
		round_start()

/obj/effect/lowpop_adjustment/proc/round_start()
	if(!assigned_map_template)
		CRASH("No map template supplied to [src]!")
	/// Raw population checks first; as they're light to perform
	if(maximum_population <= LAZYLEN(GLOB.new_player_list))
		qdel(src)
	/// Job checks if that failed
	if(relevant_jobs)
		for(var/mob/living/found_player in GLOB.player_list)
			if(found_player?.mind?.assigned_role in relevant_jobs)
				qdel(src)
				break
	INVOKE_ASYNC(src, PROC_REF(load_map))

/obj/effect/lowpop_adjustment/proc/load_map()
	var/turf/spawn_area = get_turf(src)

	if(istype(assigned_map_template))
		new assigned_map_template

		assigned_map_template.load(spawn_area)
		qdel(src)
