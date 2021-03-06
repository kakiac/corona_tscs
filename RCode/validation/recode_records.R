
# These are records with errors
# Once they are fixed, remove the code from this file and commit to Github

mutate_cond <- function(.data, condition, ..., envir = parent.frame()) {
condition <- eval(substitute(condition), .data, envir)
.data[condition, ] <- .data[condition, ] %>% mutate(...)
.data
}


# issue where coders used correction link to enter update
  # note that this issue is partially resolved as of May 10
    # waiting on the following to finish corrections: 
          # Alexander Pachanov, Elfriede Derrer-Merk, Imogen Merket, Jane Murtu, Barbara Bromova, Nikolina Klatt, Mustafa Nasery, Konstanze Schonfeld
          # Konstanze Schonfeld, Maisa Naisirova, Malte Speil, Richmond Silva

    # contact following RAs who said they did the corrections but can't find evidence for it
        # Arianna Shoulten
        # Julia Darge

  # even when the issue is fully resolved, still need to remove these items
qualtrics = qualtrics[-which(qualtrics$link_type == 'C' &qualtrics$entry_type == 'update'),]

# note there are 12 entries where coder made an update using the 'correction' link
# in principal you should be able to fix this in the code, for now remove
qualtrics = qualtrics[-which(qualtrics$link_type == 'U' & qualtrics$entry_type == 'correction'),] 


# remove 2 entries where coders made a new entry using the update link; contact these coders
qualtrics = qualtrics[-which(qualtrics$link_type == 'U' & qualtrics$entry_type == 'new_entry'),] 
 
# remove 18 entries where coders made a new entry using the correction link; contact these coders
qualtrics = qualtrics[-which(qualtrics$link_type == 'C' & qualtrics$entry_type == 'new_entry'),]  

# RA Arianna Schouten asked to change the policy_id for the following 2 records
qualtrics = qualtrics %>% 
    mutate(entry_type_3_TEXT = ifelse(record_id == 8674156, 3827793, entry_type_3_TEXT),
          entry_type_3_TEXT = ifelse(record_id == 6964745, 2738947, entry_type_3_TEXT))

# NOTE: I can't find a trace of this record from RA Arianna Schouten
    # Number 3757671 should be an update of reference number 2777808 (instead of number 7672988)
    # FOLLOW UP LATER
# qualtrics %>% mutate(entry_type_3_TEXT = ifelse(record_id == 3757671, 2777808, entry_type_3_TEXT)) %>% select(record_id, entry_type_3_TEXT)

# RA Katharina Klaunig
# I accidentally selected the wrong initiating country for the below records. I have both Uzbekistan and Kazakhstan. The descriptions are correct in stating Kazakhstan but the initiating country I chose was Uzbekistan. Sorry about that! I'm unable to do this in the corrections survey.
qualtrics = qualtrics %>% mutate(init_country = ifelse(record_id %in% c(5551542, 1335740, 1225028, 5320600), 'Kazakhstan', init_country))


# fixing Cheng-Hao Shen's Palau thing
qualtrics = qualtrics %>% 
    mutate(entry_type_3_TEXT = ifelse(record_id == 8917154, 6006156, entry_type_3_TEXT) )


# issues identified from paper bio-fabric plot

  # this is not a travel ban for people entering Italy, but for leaving Italy
  qualtrics = qualtrics %>% mutate(target_direction = ifelse(record_id == 3071523, "Outbound", target_direction))


  # this is an 'restriction of non-essential business' measure rather than a travel ban
  qualtrics = qualtrics %>% mutate(type = ifelse(record_id %in% c(8819062), 'Restriction of Non-Essential Businesses', type),
                      target_geog_level = ifelse(record_id %in% c(8819062), 'One or more countries, but not all countries', target_geog_level),
                      target_who_what = ifelse(record_id %in% c(8819062), NA, target_who_what),
                      target_direction = ifelse(record_id %in% c(8819062), NA, target_direction),
                      travel_mechanism = ifelse(record_id %in% c(8819062), NA, travel_mechanism))


  # Micronesia, not a ban on all countries, but unsepcificed countries that have coronacases
  qualtrics = qualtrics %>% mutate(target_geog_level = ifelse(record_id %in%c(3625348, 4465391 ), 'One or more countries, but not all countries', target_geog_level) )


  # Colombia: this is quarantine upon arrival, not external border restriction
  qualtrics = qualtrics %>% mutate(type = ifelse(record_id %in%c(1293754 ), 'Quarantine', type),
                                    type_quarantine =ifelse(record_id %in%c(1293754), "Self-Quarantine (i.e. quarantine at home)", type_quarantine  ))


   # Bahrain: these are recommendations, not mandatory bans, targets are citizen residents, target direction is outbound
  qualtrics = qualtrics %>% mutate(target_who_what = ifelse(record_id %in% c(5709516, 9327917 ), 'Citizen Residents', target_who_what),
                                    target_direction =ifelse(record_id %in% c(5709516, 9327917), "Outbound", target_direction),
                                    compliance =  ifelse(record_id %in% c(5709516, 9327917), "Voluntary/Recommended but No Penalties", compliance ))

                                
  # Initiating country is Slovenia, not Iran 
   qualtrics = qualtrics %>% mutate(init_country = ifelse(record_id %in%c(3031369), 'Slovenia', init_country ))

  
   # Germany: target country is not Germany but 'All countries', directio is outbound
  qualtrics = qualtrics %>% mutate(target_country = ifelse(record_id %in%c(1592443), 'All countries', target_country ),
                                   target_direction= ifelse(record_id %in%c(1592443), 'Outbound', target_direction))


   # Germany: target country is not Germany but 'All countries', compliance is voluntary
  qualtrics = qualtrics %>% mutate(target_country = ifelse(record_id %in%c(3788036, 5258786 ), 'All countries', target_country ),
                                   compliance= ifelse(record_id %in%c(3788036, 5258786 ), "Voluntary/Recommended but No Penalties", compliance))


   #Azerbaijan target who what should be 'other' for bsuiness trips/public employees
   qualtrics = qualtrics %>% mutate(target_who_what = ifelse(record_id %in%c(2632978), 'Other', target_who_what ),
                                   target_who_what_10_TEXT = ifelse(record_id %in%c(2632978), "Public/private employees on business trips", target_who_what_10_TEXT ),
                                      target_direction = ifelse(record_id %in%c(2632978), "Outbound", target_direction))
 
  #Tunisia target who what should be 'other' for students
   qualtrics = qualtrics %>% mutate(target_who_what = ifelse(record_id %in%c(7066331), 'Other', target_who_what ),
                                   target_who_what_10_TEXT = ifelse(record_id %in%c(7066331), "Students/school trips", target_who_what_10_TEXT ),
                                   target_direction = ifelse(record_id %in%c(7066331), "Outbound", target_direction))



# some ppl made updates to their entries using the correction link




# note RA Adrianna Poppe did not enter in the record id for her correction to 9008490; doing it for her here
qualtrics[which(qualtrics$entry_type_2_TEXT == 'https://bogota.gov.co/mi-ciudad/salud/decreto-081-de-alerta-amarilla-por-coronavirus-en-bogota'), 'entry_type_2_TEXT'] = "9008490"

# RA Cheng-Hao Shen unncessarily chose other and NA category for target_who_what but otherwise the record is correct  
qualtrics[which(qualtrics$target_who_what_10_TEXT == "N/A"), c('target_who_what', 'target_who_what_10_TEXT')] = ""

# coder already documents this, correctly , in the target_who_what, removing it from 'target_other'
qualtrics[which(qualtrics$target_other == "this travel ban regards towards government officials and State-Owned Enterprises"),'target_other'] = ''

# add in niklas' corrections
# RA Niklas had systematically made the mistake of entering the date he collected a source instead of the date the source was published
# since he already had 68 entries coded, Cindy decided it would be a better use of time to just allow him to fix
# the mistakes in a spreadsheet rather than having him make corrections on every single one, with the understanding that this was def an exception

# the following code loads his corrections and incorporates them

#niklas_sources = read_csv(paste0(path, '/data/CoronaNet/niklasSourcesCorrection_corrected.csv'))
#niklas_sources = niklas_sources[-1,] # remove first row where i had given him a description of the columns
#qualtrics[which(qualtrics$record_id %in% niklas_sources$record_id), c('sources_matrix_1_1', 'sources_matrix_2_1')]  = niklas_sources[, c('correct_date_1', 'correct_date_2')]


# coder used 'other' text entry for target_who_what for hopstials; change to 'health infrastructure' for now and we should think about whether to add an extra option for coders
qualtrics[which(qualtrics$target_who_what_10_TEXT == "Health-Infrastructure"),'target_who_what']  = "Health-Infrastructure"
qualtrics[which(qualtrics$target_who_what_10_TEXT == "Infirmiry"),'target_who_what']  = "Health-Infrastructure"

# Coder made new Entry but it should be update: Record 5733066 should be an update for 4262184 Record  6511463 should be an update for 3083058
qualtrics[which(qualtrics$record_id== 5733066),"entry_type"]  = "Update on Existing Entry (type in Record ID in text box)"
qualtrics[which(qualtrics$record_id== 5733066),"entry_type_3_TEXT"]  = 4262184

qualtrics[which(qualtrics$record_id== 6511463),"entry_type"]  = "Update on Existing Entry (type in Record ID in text box)"
qualtrics[which(qualtrics$record_id== 6511463),"entry_type_3_TEXT"]  = 3083058
 
qualtrics[which(qualtrics$record_id== 5501189),"type_ext_restrict"]  = c("Health Certificates")

# record id 645445 should be recoded as either declaration of emergency or quarantine but not curfew; asana is being super slow, putting this here for now
# record id 384499 should be recoded as restriciton of businesses; asana is being super slow, putting this here for now

# coder coded as internal border restriction when it should be external border restriction
qualtrics[which(qualtrics$record_id %in% c(1004681,
                                           1034745,
                                           2575122,
                                           4920569,
                                           6556074,
                                           6884924,
                                           4743134,
                                           1049744,
                                           361563,
                                           1352371,
                                           2281761,
                                           3130519,
                                           3514992,
                                           4583902,
                                           192041)),"type"] = 'External Border Restrictions'


# coder coded as internal border restriction when it should be quarantine
qualtrics[which(qualtrics$record_id %in% c(3650646,
                                           7760322,
                                           9699354,
                                           4564754)),"type"] = 'Quarantine/Lockdown'


# coder coded as internal border restriction when it should be restriction of businesses
qualtrics[which(qualtrics$record_id %in% c(7053515)),"type"] = "Restriction of Non-Essential Businesses"


# remove test records
qualtrics <- filter(qualtrics, !(record_id %in% c(1703790,
                                                  9241261)))





other = qualtrics %>% filter(type == 'Other Policy Not Listed Above')
 


mask = other %>% 
  filter(grepl('wear', event_description)) %>%
   #filter(grepl('mask|Mask|face|Face', type_15_TEXT)) %>%
  select(record_id, init_country, event_description) %>% data.frame()

 
# social distancing - masks 
qualtrics = qualtrics %>% 
  mutate_cond(record_id %in% c(1900964,
                               7070777,
                               9110335,
                               1057745,
                               5290219,
                               908362,
                               5607578,
                               2822947,
                               2538425,
                               8042890,
                               8993169,
                               1546416,
                               434213,
                               4031696,
                               8530156,
                               4342131,
                               9854171),
              type = 'Social Distancing',
              type_15_TEXT = NA,
              type_other = NA,
              type_soc_distance = "Masks",
              type_soc_distance = 'All public spaces / everywhere')

# social distancing - unspecified
qualtrics = qualtrics %>% 
  mutate_cond(record_id %in% c(3420717,
                               4990764,
                               9162039,
                               3860156),
              type = 'Social Distancing',
              type_15_TEXT = NA,
              type_other = NA,
              type_soc_distance = "Masks",
              type_soc_distance = 'All public spaces / everywhere')



# social distancing - masks  - markets
qualtrics = qualtrics %>% 
  mutate_cond(record_id %in% c(9669797),
              type = 'Social Distancing',
              type_15_TEXT = NA,
              type_other = NA,
              type_soc_distance = "Masks,Other",
              type_soc_distance_7_TEXT = 'markets')


# social distancing - masks
qualtrics = qualtrics %>%
  mutate_cond( record_id %in% c(6725232), 
               type = 'Social Distancing',
               type_15_TEXT = NA,
               type_other = NA,
               type_soc_distance = "Inside public or commercial building (e.g. supermarkets)")

# social distancing - masks  - public transport
qualtrics = qualtrics %>% 
  mutate_cond(record_id %in% c(4257872,
                               3477445,
                               9861723),
              type = 'Social Distancing',
              type_15_TEXT = NA,
              type_other = NA,
              type_soc_distance = "Masks,Other",
              type_soc_distance_7_TEXT = 'public transport')

# social distancing - masks  - buses
qualtrics = qualtrics %>% 
  mutate_cond(record_id %in% c(1978580),
              type = 'Social Distancing',
              type_15_TEXT = NA,
              type_other = NA,
              type_soc_distance = "Masks,Other",
              type_soc_distance_7_TEXT = 'buses')


# health resources - masks
qualtrics = qualtrics %>% 
  mutate_cond(record_id %in% c(9052375,
                               6121319,
                               571522,
                               8150021),
              type = 'Health Resources',
              type_15_TEXT = NA,
              type_other = NA,
              type_health_resource = "Masks")

# health resources - masks - 6 million, maximum 3 per person
qualtrics = qualtrics %>% 
        mutate_cond(record_id %in% c(313900),
                    type = 'Health Resources',
                    type_15_TEXT = NA,
                    type_other = NA,
                    type_health_resource = "Masks",
                    type_health_resource_1_TEXT = '6 million, maximum 3 per person')


# health resources - masks, bans exports
qualtrics = qualtrics %>% 
  mutate_cond(record_id %in% c(5193638),
              type = 'Health Resources',
              type_15_TEXT = NA,
              type_other = NA,
              type_health_resource = "Masks,Personal Protective Equipment (e.g. gowns, goggles)",
              type_health_resource_1_TEXT = 'bans exports of masks',
              type_health_resource_3_TEXTT = 'bans exports of ppe')


# health resources - masks,soap
qualtrics = qualtrics %>% 
  mutate_cond(record_id %in% c(2010153),
              type = 'Health Resources',
              type_15_TEXT = NA,
              type_other = NA,
              type_health_resource = "Masks,Other Health Materials",
              type_health_resource_13_TEXT = 'soap')

 
# External Border Restrictions -- visa extensions
qualtrics = qualtrics %>%
  mutate_cond( record_id %in% c(3335261,
                                3270767,
                                2796253,
                                7976280,
                                9498040,
                                59711,
                                6521977,
                                9299202,
                                3942215,
                                8580682,
                                4555476,
                                2525153,
                                7101715),
               type = 'External Border Restrictions',
               type_15_TEXT = NA,
               type_other = NA,
               type_ext_restrict= "Visa extensions (e.g. visa validity extended)")

# External Border Restrictions -- visa restrictions
qualtrics = qualtrics %>%
  mutate_cond( record_id %in% c(2716396,
                                3561265,
                                401337,
                                25240),
               type = 'External Border Restrictions',
               type_15_TEXT = NA,
               type_other = NA,
               type_ext_restrict= "Visa restrictions (e.g. suspend issuance of visa)")


# restriction of mass gatherings --- prisons
qualtrics = qualtrics %>%
  mutate_cond(record_id %in% c(8097861),
              type = 'Restrictions of Mass Gatherings',
              type_15_TEXT = NA,
              type_other = NA,
              type_mass_category = "Prison population reduced (e.g. early release of prisoners)")

# hygiene, commercial areas, public areas, public transport, 
qualtrics = qualtrics %>%
            mutate_cond(record_id %in% c(3776542,
                                         8852960,
                                         1119313),
                        type = 'Hygiene',
                        type_15_TEXT = NA,
                        type_other = NA,
                        type_hygiene ="Commercial areas (e.g. shopping malls,markets),Public areas (e.g. mosques, government buildings, schools),Public Transport (e.g. subways,trains)")


# hygiene,  commercial areas - markets, public areas-- sports facilities, cultural and entertainment facilities, public transport
qualtrics = qualtrics %>%
  mutate_cond(record_id %in% c(6655920),
              type = 'Hygiene',
              type_15_TEXT = NA,
              type_other = NA,
              type_hygiene ="Commercial areas (e.g. shopping malls,markets),Public areas (e.g. mosques, government buildings, schools),Public Transport (e.g. subways,trains)",
              type_hygiene_11_TEXT = 'markets',
              type_hygiene_12_TEXT =  'sports facilities;cultural and entertainment facilities;commercial areas')


# hygiene, commercial areas, public areas
qualtrics = qualtrics %>%
  mutate_cond(record_id %in% c(3210689),
              type = 'Hygiene',
              type_15_TEXT = NA,
              type_other = NA,
              type_hygiene ="Commercial areas (e.g. shopping malls,markets),Public areas (e.g. mosques, government buildings, schools)")

# hygiene, public transport, commercial areas -- supermarkets; open markets
qualtrics = qualtrics %>%
  mutate_cond(record_id %in% c(7821010),
              type = 'Hygiene',
              type_15_TEXT = NA,
              type_other = NA,
              type_hygiene ="Commercial areas (e.g. shopping malls,markets),Public areas (e.g. mosques, government buildings, schools)",
              type_hygiene_11_TEXT = "supermarkets;markets")

# hygiene, commercial areas areas 
qualtrics = qualtrics %>%
  mutate_cond(record_id %in% c(9255723),
              type = 'Hygiene',
              type_15_TEXT = NA,
              type_other = NA,
              type_hygiene ="Commercial areas (e.g. shopping malls,markets)")


# hygiene, commercial areas areas -- Malls, business centers, supermarkets and entertainment places 
qualtrics = qualtrics %>%
  mutate_cond(record_id %in% c(7500562),
              type = 'Hygiene',
              type_15_TEXT = NA,
              type_other = NA,
              type_hygiene ="Commercial areas (e.g. shopping malls,markets)",
              type_hygiene_11_TEXT = "malls;business centers;supermarkets;entertainment places")


# hygiene, commercial areas areas --markets
qualtrics = qualtrics %>%
  mutate_cond(record_id %in% c(2951510,
                               3846909,
                               9859255),
              type = 'Hygiene',
              type_15_TEXT = NA,
              type_other = NA,
              type_hygiene ="Commercial areas (e.g. shopping malls,markets)",
              type_hygiene_11_TEXT = "markets")


# hygiene, commercial areas areas --bakeries
qualtrics = qualtrics %>%
  mutate_cond(record_id %in% c(3470223),
              type = 'Hygiene',
              type_15_TEXT = NA,
              type_other = NA,
              type_hygiene ="Commercial areas (e.g. shopping malls,markets)",
              type_hygiene_11_TEXT = "bakeries")


# hygiene, public areas 
qualtrics = qualtrics %>%
  mutate_cond(record_id %in% c(5639822,
                               1269772),
              type = 'Hygiene',
              type_15_TEXT = NA,
              type_other = NA,
              type_hygiene ="Public areas (e.g. mosques, government buildings, schools)")


# hygiene, public areas -- mosques
qualtrics = qualtrics %>%
  mutate_cond(record_id %in% c(8159173),
              type = 'Hygiene',
              type_15_TEXT = NA,
              type_other = NA,
              type_hygiene ="Public areas (e.g. mosques, government buildings, schools)",
              type_hygiene_12_TEXT = "mosques")


# hygiene, public areas -- government buildings
qualtrics = qualtrics %>%
  mutate_cond(record_id %in% c(3136002),
              type = 'Hygiene',
              type_15_TEXT = NA,
              type_other = NA,
              type_hygiene ="Public areas (e.g. mosques, government buildings, schools)",
              type_hygiene_12_TEXT = "government buildings")

# hygiene, public areas -- schools
qualtrics = qualtrics %>%
  mutate_cond(record_id %in% c(2180252),
              type = 'Hygiene',
              type_15_TEXT = NA,
              type_other = NA,
              type_hygiene ="Public areas (e.g. mosques, government buildings, schools)",
              type_hygiene_12_TEXT = "schools")

 
 
# hygiene, public areas - parks, public transport -- streets; other - taxis
qualtrics = qualtrics %>%
  mutate_cond(record_id %in% c(1560318),
              type = 'Hygiene',
              type_15_TEXT = NA,
              type_other = NA,
              type_hygiene ="Public areas (e.g. mosques, government buildings, schools),Public Transport (e.g. subways,trains),Other Areas Hygiene Measures Applied",
              type_hygiene_12_TEXT = "parks",
              type_hygiene_13_TEXT  = 'streets',
              type_hygiene_15_TEXT = 'taxis')


# hygiene, public transport
qualtrics = qualtrics %>%
  mutate_cond(record_id %in% c(2544387,
                               6760921,
                               6454317,
                               9581346,
                               6483009,
                               1931576,
                               476932),
              type = 'Hygiene',
              type_15_TEXT = NA,
              type_other = NA,
              type_hygiene ="Public Transport (e.g. subways,trains)")


# hygiene, public transport - buses
qualtrics = qualtrics %>%
  mutate_cond(record_id %in% c(2953224,
                               9310476),
              type = 'Hygiene',
              type_15_TEXT = NA,
              type_other = NA,
              type_hygiene ="Public Transport (e.g. subways,trains)",
              type_hygiene_13_TEXT = 'buses')

# hygiene, public transport - streets
qualtrics = qualtrics %>%
  mutate_cond(record_id %in% c(5181702),
              type = 'Hygiene',
              type_15_TEXT = NA,
              type_other = NA,
              type_hygiene ="Public Transport (e.g. subways,trains)",
              type_hygiene_13_TEXT = 'streets')


# hygiene, public transport -- airports
qualtrics = qualtrics %>%
  mutate_cond(record_id %in% c(3557333),
              type = 'Hygiene',
              type_15_TEXT = NA,
              type_other = NA,
              type_hygiene ="Public Transport (e.g. subways,trains)",
              type_hygiene_13_TEXT = 'airports')

# hygiene, public transport -- aiplanes
qualtrics = qualtrics %>%
  mutate_cond(record_id %in% c(5180729),
              type = 'Hygiene',
              type_15_TEXT = NA,
              type_other = NA,
              type_hygiene ="Public Transport (e.g. subways,trains)",
              type_hygiene_13_TEXT = 'airplanes')

# hygiene, public transport -- public transport terminals; railway depots
qualtrics = qualtrics %>%
  mutate_cond(record_id %in% c(2062179),
              type = 'Hygiene',
              type_15_TEXT = NA,
              type_other = NA,
              type_hygiene ="Public Transport (e.g. subways,trains)",
              type_hygiene_13_TEXT = "public transport terminals;railway depots")

 
# hygiene, burials
qualtrics = qualtrics %>%
  mutate_cond(record_id %in% c(5665693,
                               7067308,
                               4163972,
                               5007948,
                               9084944,
                               9640371),
              type = 'Hygiene',
              type_15_TEXT = NA,
              type_other = NA,
              type_hygiene ="Burial procedures")


# hygiene, other areas - cities/villages
qualtrics = qualtrics %>%
  mutate_cond(record_id %in% c(3960526),
                               type = 'Hygiene',
                               type_15_TEXT = NA,
                               type_other = NA,
                               type_hygiene ="Other Areas Hygiene Measures Applied",
                               type_hygiene_15_TEXT = "cities;villages")
              

# hygiene, other areas - food service
qualtrics = qualtrics %>%
  mutate_cond(record_id %in% c(3726422),
              type = 'Hygiene',
              type_15_TEXT = NA,
              type_other = NA,
              type_hygiene ="Other Areas Hygiene Measures Applied",
              type_hygiene_15_TEXT = "food service")

# hygiene, other areas - food service;retail
qualtrics = qualtrics %>%
  mutate_cond(record_id %in% c(4432599),
              type = 'Hygiene',
              type_15_TEXT = NA,
              type_other = NA,
              type_hygiene ="Other Areas Hygiene Measures Applied",
              type_hygiene_15_TEXT = "food service;retail")

 


# hygiene, other areas - petrol stations
qualtrics = qualtrics %>%
  mutate_cond(record_id %in% c(4608191),
              type = 'Hygiene',
              type_15_TEXT = NA,
              type_other = NA,
              type_hygiene ="Other Areas Hygiene Measures Applied",
              type_hygiene_15_TEXT = "taxis")

# hygiene, other areas - hotels
qualtrics = qualtrics %>%
  mutate_cond(record_id %in% c(4767605),
              type = 'Hygiene',
              type_15_TEXT = NA,
              type_other = NA,
              type_hygiene ="Other Areas Hygiene Measures Applied",
              type_hygiene_15_TEXT = "hotels")

 
# hygiene, other areas - petrol stations
qualtrics = qualtrics %>%
  mutate_cond(record_id %in% c(1318798),
              type = 'Hygiene',
              type_15_TEXT = NA,
              type_other = NA,
              type_hygiene ="Other Areas Hygiene Measures Applied",
              type_hygiene_15_TEXT = "petrol stations")

 
# public awareness measure - gathering
qualtrics = qualtrics %>%
  mutate_cond( record_id %in% c(3483365,
                                8061245), 
               type = 'Public Awareness Measures',
               type_15_TEXT = NA,
               type_other = NA,
               type_pub_awareness = "Gathering information related to COVID-19 from the public")

# public awareness measure - disseminating
qualtrics = qualtrics %>%
  mutate_cond( record_id %in% c(4487498,
                                9623754), 
               type = 'Public Awareness Measures',
               type_15_TEXT = NA,
               type_other = NA,
               type_pub_awareness = "Disseminating information related to COVID-19 to the public that is reliable and factually accurate")


# anti-disinformation measures
qualtrics = qualtrics %>%
  mutate_cond( record_id %in% c(2999984,
                                1787817,
                                215981,
                                1954009,
                                2971618,
                                3710342,
                                3323150,
                                8859598), 
               type = 'Anti-Disinformation Measures',
               type_15_TEXT = NA,
               type_other = NA)



### HAVEN"T DONE YET
# 6712766 -- recode, multiple policies here
# 3857966 -- recode, multiple policies here
# 5740309 -- recode, multiple policies here
# 1546416; check to see if this whould be actually split into 2 policies
# 2544387 ; check to see if quarantine measure also coded ehre
# 5180729 might want to think about allowing hygiene to have a target: Russia introduces new procedures for disinfecting airplanes coming from China on February 6.\n











