/turf/closed/mineral/random/jungle
	baseturfs = /turf/open/misc/rough_stone
	turf_type = /turf/open/misc/dirt/jungle // Used exclusively by rivergen; shit sucks

/turf/closed/mineral/random/jungle/mineral_chances()
	return list(
		/obj/item/boulder/gulag = 165,
		/turf/closed/mineral/gibtonite = 2,
	)

/turf/closed/mineral/random/stationside/asteroid/porus/gas_giant
	baseturfs = /turf/open/misc/asteroid/gas_giant
