#define SLASHER_SELECTION_RANDOM "Random"
#define SLASHER_SELECTION_PICK_BY_CLASS "Unknown Class"
#define SLASHER_SELECTION_PICK_ANY "Unknown"

/datum/dynamic_ruleset/roundstart/slashers
	name = "Slashers - Random"
	persistent = TRUE
	antag_flag = ROLE_SLASHER
	antag_datum = /datum/antagonist/slasher
	weight = INFINITY // the name of GOD
	delay = 1 MINUTES
	requirements = list(0,0,0,0,0,0,0,0,0,0)
	antag_cap = 1
	scaling_cost = 20
	flags = ONLY_RULESET
	/// Race Condition Workaround. Bodge. Get rid of this longterm
	var/first_run = TRUE
	/// SLASHER SCALING ///
	/// What's the maximum amount of Slashers? Defaults to 1; but scales +1 for every 6 players. Note that if this is VV'd it'll override the order!
	var/maximum_slashers = 1
	/// Have we spawned in the slashers yet?
	var/spawned_slashers = FALSE
	/// Our slasher selection mode. Used purely for flavor text.
	var/slasher_selection_mode = SLASHER_SELECTION_RANDOM

/datum/dynamic_ruleset/roundstart/slashers/rule_process()
	if(first_run)
		sleep(1 MINUTES) // we LOVE Our race conditions; marge
		first_run = FALSE
	var/winner = process_victory()
	if (isnull(winner))
		return

	if(winner == TRUE && !SSslashco.bypass_failstate)
		GLOB.revolutionary_win = TRUE // we can just hijack the revolution victory lol
		for(var/mob/target in GLOB.player_list)
			if(!isnewplayer(target))
				SEND_SOUND(target, 'local/code/modules/slashco13/sound/music/lost.ogg')
		return RULESET_STOP_PROCESSING

	return

/datum/dynamic_ruleset/roundstart/slashers/proc/process_victory()
	for(var/datum/antagonist/slasher/antagge as anything in GLOB.antagonists)
		for(var/datum/objective/assassinate/objective in antagge.objectives)
			if(!(objective.check_completion()))
				return FALSE
		return TRUE

/datum/dynamic_ruleset/roundstart/slashers/pre_execute(population)
	. = ..()
	if(maximum_slashers == initial(maximum_slashers)) // Only scale if we haven't varedited maximum_slashers.
		maximum_slashers = handle_slasher_scaling(population)
	var/got_one = FALSE // prevents game resets so long as there's at least ONE slasher
	for (var/i in 1 to maximum_slashers)
		if(candidates.len <= 0 && !got_one) // This shouldn't happen; the round is bricked. Restart
			to_chat(world,span_announce("Restarting the server - no valid Slashers!"))
			GLOB.revolutionary_win = TRUE // it's just that easy chief
			break
		got_one = TRUE
		var/mob/M = pick_n_take(candidates)
		if(!M)
			break
		assigned += M.mind
		M.mind.restricted_roles = restricted_roles
		M.mind.special_role = ROLE_SLASHER
		GLOB.pre_setup_antags += M.mind
		to_chat(M, span_warning("You have been chosen to become a Slasher."))
		to_chat(M, span_warning("You have 60 seconds to look busy before you respawn..."))
	return TRUE

/// Offerings and Modifiers should override this proc.
/datum/dynamic_ruleset/roundstart/slashers/proc/handle_slasher_scaling(population)
	var/slasher_scaled_number = floor(population * 0.143)
	if(slasher_scaled_number < 1)
		slasher_scaled_number = 1
	return slasher_scaled_number

/datum/dynamic_ruleset/roundstart/slashers/execute()
	if(spawned_slashers)
		return TRUE // We already spawned them in earlier than anticipated thanks to someone messing with a generator; we don't need to give them a second antag datum.
	var/list/possible_slashers = subtypesof(antag_datum) // Done here so that selection types can avoid repeats
	for(var/datum/mind/new_slasher in assigned)
		var/selected_slasher_type = handle_slasher_selection(possible_slashers, new_slasher)
		var/datum/antagonist/slasher/new_antag_datum = new selected_slasher_type
		new_slasher.add_antag_datum(new_antag_datum)
		var/potential_spawn = find_space_spawn()
		if(!potential_spawn)
			potential_spawn = get_safe_random_station_turf() /// No carpspawns? Fuggit; random safe tile
		new_slasher.current.forceMove(potential_spawn)
		GLOB.pre_setup_antags -= new_slasher
		spawned_slashers = TRUE // We got at least one!
	if(spawned_slashers) // Have we found at least one slasher? Wrap up!
		return TRUE
	else
		to_chat(world, span_announce("Failed to set up game - no eligible Slashers! Check your antagonist preferences - server rebooting shortly..."))
		GLOB.revolutionary_win = TRUE
		return FALSE

/// This ruleset's slasher selection. Override to change how slasher types are set!
/datum/dynamic_ruleset/roundstart/slashers/proc/handle_slasher_selection(list/possible_slashers, datum/mind/new_slasher)
	var/our_slasher_type = pick_n_take(possible_slashers)
	if(!our_slasher_type)
		possible_slashers = subtypesof(antag_datum)
		our_slasher_type = pick_n_take(possible_slashers)
	return our_slasher_type

/// Pick Selection Ruleset
/datum/dynamic_ruleset/roundstart/slashers/pick
	name = "Slashers - Pick Any"
	slasher_selection_mode = SLASHER_SELECTION_PICK_ANY

/datum/dynamic_ruleset/roundstart/slashers/pick/handle_slasher_selection(list/possible_slashers, datum/mind/new_slasher)
	var/list/pickable_slashers = cull_unpickable_slashers(possible_slashers)
	if(!new_slasher.current.client) // They dc'd while setup was happening. fuck their choice
		return ..()
	var/list/assoc_list_formatted_slashers
	for(var/datum/antagonist/slasher/to_assoc_list in pickable_slashers)
		assoc_list_formatted_slashers[to_assoc_list.name] = to_assoc_list
	var/picked_slasher = tgui_input_list(new_slasher.current, "Choose; quickly, before your prey gain too much ground.","Slasher Selection", sort_list(assoc_list_formatted_slashers))
	if(isnull(picked_slasher))
		return ..()
	return picked_slasher

/// Override this if you want to restrict pickable slashers.
/datum/dynamic_ruleset/roundstart/slashers/pick/proc/cull_unpickable_slashers(list/possible_slashers)
	var/to_return = possible_slashers
	to_chat(world, "to return: [to_return]")
	return to_return

/// Pick Selection (By Class) Ruleset
/datum/dynamic_ruleset/roundstart/slashers/pick/by_class
	name = "Slashers - Pick By Class"
	slasher_selection_mode = SLASHER_SELECTION_PICK_BY_CLASS

/datum/dynamic_ruleset/roundstart/slashers/pick/by_class/cull_unpickable_slashers(list/possible_slashers)
	var/desired_slasher_class = pick("Cryptid", "Demon", "Umbra")
	var/list_to_edit = possible_slashers
	for(var/datum/antagonist/slasher/found_slasher_type in list_to_edit)
		if(found_slasher_type.slasher_category != desired_slasher_class)
			list_to_edit -= found_slasher_type
	return list_to_edit

/// OFFERING VARIANTS HERE ///
// Tl;dr, in the original, offerings were lobby-voted variants on Slashco's roundflow. Modifiers. These have been made admin-only until I figure out voting lol

// NIGHTMARE MODE: The scaling is inverted! Every 7th player becomes a survivor; while everyone else becomes a slasher... good luck!
/datum/dynamic_ruleset/roundstart/slashers/nightmare
	name = "Slashers - Nightmare Offering"
	weight = 0 // Shouldn't roll naturally

/datum/dynamic_ruleset/roundstart/slashers/nightmare/handle_slasher_scaling(population)
	var/survivor_amount
	if(population == 1)
		return 1 // Shouldn't be possible without admin fuckery anyways.
	if(population <= 7)
		return (population - 1)
	else
		survivor_amount = floor((population - (round(population, 7) * 0.143)))
	var/slasher_scaled_number = (population - survivor_amount)
	return slasher_scaled_number

#undef SLASHER_SELECTION_RANDOM
#undef SLASHER_SELECTION_PICK_BY_CLASS
#undef SLASHER_SELECTION_PICK_ANY
