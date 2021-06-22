# iccat-spillover

###ICCAT Data Code System, as found on https://www.iccat.int/en/stat_codes.html ###

To confirm that no spillover was occurring between treated and untreated units, we used catch data reported to the International Convention on the Conservation of Atlantic Tunas (ICCAT). In addition to the data already available, we created two new columns – one unique identifier that combined fleet (typically corresponding to a Contracting Party name) and gear type (i.e., CAN.LL is the Canadian Longline fleet), and another unique identifier that combined species and stock (i.e., ALB.ATN is North Atlantic Albacore tuna). Species-specific price data from NOAA were also acquired, although these data only represented landing prices in the United States (specifically New England, Middle Atlantic and South Atlantic), and were therefore not representative of landing prices for all Contracting Parties.

Several modifications were made to this dataset to remove any potential biases that have been driven by the increase in Contracting Parties (12 CPs in 1970 and 53 CPs in 2019) or the increase in the scope of species-stocks included in the Task I dataset (47 in 1970 and 115 in 2019). These subset datasets were individually examined for potential leakage.
(a)	Is leakage occurring for the Fleet-Gears with the longest time series in the ICCAT database? We examined this by isolating Fleet-Gears that had reported at least forty years of data to ICCAT (~1979 to 2019).
(b)	Is leakage occurring as new Fleet-Gear entrants join the agreement? Fleet-Gears that represented new entrants (Fleet-Gears that reported less than forty years of data).
(c)	Is leakage occurring for Species-Stocks with the longest time series in the ICCAT database? Species-Stocks that had at least forty years of data to ICCAT (~1979 to 2019).
(d)	Are certain gear types more prone to leakage? 
a.	Longline Fleets only.
b.	Purse Seine Fleets only.

#Species: Species abbreviation code
#ScieName: Scientific name
#SpeciesGrp: Six general categories ("1-Tuna (major sp.)" "2-Tuna (small)" "3-Tuna (other)" "5-Sharks (other)" "4-Sharks (major)"  "6-Other Species")
#YearC: Reporting year
#Decade: Reporting decade
#Lustrum: Reporting bi-decadal
#PartyStatus: Three options "CP" Contracting Party  "NCO" Non-Contracting Parties "NCC" Non-Contracting Cooperator
#PartyName: Name of CP, NCC, or general NCO category
#Flag: Typically corresponds to PartyName
#Fleet: Typically corresponds to PartyName
#Stock: Location of stock, twelve options "MED" Mediterranean "ATW" Western Atlantic "ATN" North Atlantic "ATE" Eastern Atlantic "ATL" Atlantic "A+M" Atlantic and Mediterranean "ATS" South Atlantic "ASW" South Western Atlantic "ANE" North Eastern Atlantic "ANW" North Western Atlantic "ASE" South Eastern Atlantic "UNK" Unknown
#SampAreaCode: Combination of sampling area identification number and species/gear associations. Mostly relevant for Task II data.
#Area: More specific area or region code (i.e. Canary Islands Area, Bay of Biscay, Azores Islands Area, etc.)
#FishZoneCode: Four categories: "EEZ" Exclusive Economic Zone  "UNKN" Unknown "HSEA" High Seas "COMB" Combined
#SpcGearGrp: Nine categories "Traps" "Other surf." "Sport (Hand Line + Rod and Reel)" "Bait boat" "Troll" "All gears" "Longline" "Purse seine" "Trawl" 
#GearGrp: "TP" Trap "HP" Harpoon "RR" Rod and Reel "GN" Gillnet "BB" Baitboat "TR" Trolling "HL" Handline "UN" Unclassified "LL" Longline "PS" Purse Seine "TW" Trawl "HS" Haul Seine "TN" Trammel Net "TL" Tended Line "SP" Sport
#GearCode: More specific gear code, i.e. longline targeting BFT, longline targeting SWO, gillnet targeting ALB
#CatchTypeCode: Six categories "C" Catches "L" Landings  "DD" Dead Discards "FA"  "LF" "DM"
#QualInfoCode: N/A
#CnvFactor: Conversion Factor (more info on ICCAT website)
#Qty_t: Quantity in metric tons

###New variables added by JML###

#FleetGear: A combination of Flag (PartyName, sometimes more finely divided into area where the most fishing occurs or where the fleet is based) and GearGrp (15 categories, described above)
#SpeciesStock: A combination of Species (species abbreviation code) and Stock (location of stock, geographically divided)
#yearTACimp: The year that the TAC was implemented for each SpeciesStock where a TAC exists.
#tacr: Dummy variable that turns 'on' in the year that the TAC was implemented for each SpeciesStock where a TAC exists.
#tacever: Dummy variable that is 1 if a SpeciesStock ever had a TAC at any point in time, and 0 if a SpeciesStock never had a TAC.
#tac_any: Dummy variable that is 1 if a FleetGear caught at least one TAC-managed stock in a given Year, and 0 if that FleetGear did not catch any TAC-mamanged stocks in a given year.

##END##
