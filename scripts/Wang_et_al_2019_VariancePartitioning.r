################################################################################################################
################################################################################################################
######################## Shaopeng Wang et al. 2019 - Variance partitioning method ##############################
################################################################################################################
################################################################################################################

###### here is the function for calculating all metrics defined in Wang et al. (2019 Ecography)
var.partition <- function(metacomm_tsdata){   # metacomm_tsdata = arrayx

  ## The function "var.partition" performs the partitioning of variability
  ## across hierarchical levesl within a metacommunity.
  ## The input array "metacomm_tsdata" is an N*T*M array. The first dimension represents N species,
  ## the second represents time-series observations of length T, and the third represents M local communities.
  ## The output includes four variability and four synchrony metrics as defined in the main text.
  ## Note that, to be able to handle large metacommunities, this code has avoided calculating all covariance.

  ## Two alternative ways exist for scaling up
  ## variability from local species (bottom-left corner; CV_S_L) to metacommunities (top-right corner; CV_C_R). The first is to aggregate populations
  ## within each local community (top-left corner; CV_C_L) first and then aggregate local communities to metacommunities. The second is to
  ## aggregate populations within each species (bottom-right corner; CV_S_R) first and then aggregate metapopulations to metacommunities.

  # sum
  ts_metacom <- apply(metacomm_tsdata,2,sum)
  ts_patch <- apply(metacomm_tsdata,c(2,3),sum)
  ts_species <- apply(metacomm_tsdata,c(1,2),sum)

  # sd
  sd_metacom <- sd(ts_metacom)
  sd_patch_k <- apply(ts_patch,2,sd)
  sd_species_i <- apply(ts_species,1,sd)
  sd_species_patch_ik <- apply(metacomm_tsdata,c(1,3),sd)
  sd_com <- sum(sd_patch_k) # temporal sd

  # mean
  mean_metacom <- mean(ts_metacom) # temporal mean

  # stability
  CV_S_L <- sum(sd_species_patch_ik)/mean_metacom  # spp_var also called pop_var (Local-scale, community average species variability)
  CV_C_L <- sum(sd_patch_k)/mean_metacom  # alpha_var also called community_var (Local-scale, community average community variability)
  CV_S_R <- sum(sd_species_i)/mean_metacom # metapop_var (Regional-scale, metacommunity average population variability, same species among communities)
  CV_C_R <- sd_metacom/mean_metacom  # gamma_var (Regional-scale, metacommunity average variability)

  # asynchrony
  phi_S_L2R <- CV_S_R/CV_S_L # pop_synch also called species-level spatial asynchrony (same species among communities) (Average species-level spatial synchrony)
  phi_C_L2R <- CV_C_R/CV_C_L # spatial_synch also called community-level spatial asynchrony (among communities) (Community-level spatial synchrony)
  phi_S2C_L <- CV_C_L/CV_S_L # spp_synch (among species within communities) (Average local-scale species synchrony)
  phi_S2C_R <- CV_C_R/CV_S_R # metapop_sync also called regional-scale species synchrony (Regional-scale species synchrony)

  # alpha diversity, see https://jonlefcheck.net/2012/10/23/diversity-as-effective-numbers/
  richness <- apply(metacomm_tsdata,c(2,3),specnumber) # number of species
  simpsons <- apply(metacomm_tsdata,c(2,3),diversity,index='simpson') # simpson (1-simpson)
  invsimpsons <- apply(metacomm_tsdata,c(2,3),diversity, index='invsimpson') # EN simpson, inverse of simpson diversity index, also known as effective species number ESN.
  shannons <- exp(apply(metacomm_tsdata,c(2,3),diversity)) # EN shannon
  evenness <- log(shannons)/log(richness) # shannon evenness independent of richness Jost 2010 Diversity or also called Pielou evenness

  # mean alpha diversity
  avg_richness <- mean(richness, na.rm = T) # mean number of species
  avg_simpsons <- mean(simpsons, na.rm = T) # mean simpson (1-simspon)
  avg_invsimpsons <- mean(invsimpsons, na.rm = T) # mean EN simpson (1/simspon)
  avg_shannons <- mean(shannons, na.rm = T) # mean EN shannon
  avg_evenness <- mean(evenness, na.rm = T) # mean independent shannon evenness

  # gamma diversity
  gamma_richness <- mean(apply(apply(metacomm_tsdata,c(1,2),sum, na.rm = T),2,specnumber))
  gamma_simpsons <- mean(apply(apply(metacomm_tsdata,c(1,2),sum),2,diversity,index='simpson'))
  gamma_invsimpsons <- mean(apply(apply(metacomm_tsdata,c(1,2),sum),2,diversity,index='invsimpson')) # EN gamma simpson
  gamma_shannons <- exp(mean(apply(apply(metacomm_tsdata,c(1,2),sum),2,diversity,index='shannon'))) # EN gamma shannon

  # beta diversity we define beta diversity (bD) in a multiplicative way, i.e. as the ratio of gamma diversity to alpha diversity
  beta <- mean(gamma_richness/avg_richness) # beta - richness-based
  beta_invsimpsons <- mean(gamma_invsimpsons/avg_invsimpsons) # EN beta - dominance-based

  # put the data together and print
  partition_3level <- c(CV_S_L=CV_S_L, CV_C_L=CV_C_L, CV_S_R=CV_S_R, CV_C_R=CV_C_R,
                        phi_S_L2R=phi_S_L2R, phi_C_L2R=phi_C_L2R, phi_S2C_L=phi_S2C_L, phi_S2C_R=phi_S2C_R,
                        avg_richness=avg_richness, avg_simpsons=avg_simpsons, avg_invsimpsons=avg_invsimpsons, avg_shannons=avg_shannons, avg_evenness=avg_evenness,
                        beta=beta, beta_invsimpsons=beta_invsimpsons,
                        temp_mean=mean_metacom, temp_sd=sd_com)
  return(partition_3level)
}

var.partition_prod <- function(metacomm_tsdata){   # metacomm_tsdata = arrayx

  # sum
  ts_metacom <- apply(metacomm_tsdata,1,sum)
  ts_patch <- metacomm_tsdata

  # sd
  sd_metacom <- sd(ts_metacom)
  sd_patch_k <- apply(ts_patch,2,sd)

  # mean
  mean_metacom <- mean(ts_metacom) # temporal mean

  # stability
  CV_C_L <- sum(sd_patch_k)/mean_metacom  # alpha_var
  CV_C_R <- sd_metacom/mean_metacom  # gamma_var

  # asynchrony
  phi_C_L2R <- CV_C_R/CV_C_L # spatial synch

#  beta_simpsons <- gamma_simpsons/avg_simpsons
#  beta_invsimpsons <- gamma_invsimpsons/avg_invsimpsons
#  beta_shannons <- gamma_shannons/avg_shannons

  # put the data together and print
  partition_3level <- c(CV_C_L=CV_C_L, CV_C_R=CV_C_R, phi_C_L2R=phi_C_L2R)
  return(partition_3level)
}

beta_cal <- function(metacomm_tsdata){   # metacomm_tsdata = datay

  vegdist_bray <- vegdist(metacomm_tsdata[,8:ncol(metacomm_tsdata)]) # default is , method="bray"
  vegdist_horn <- vegdist(metacomm_tsdata[,8:ncol(metacomm_tsdata)], method="horn")
  betadisper_bray <- betadisper(vegdist_bray, metacomm_tsdata$block, type = "centroid")
  betadisper_horn <- betadisper(vegdist_horn, metacomm_tsdata$block, type = "centroid")
  bray <- 1-mean(betadisper_bray$distances) # bray dissimilarity index ranges between 0 and 1, where 0 means completely similar species and 1 completely unique species. So the complement to bray gives the inverse
  horn <- 1-mean(betadisper_horn$distances)

  beta_cal_table <- c(bray=bray, horn=horn)
  return(beta_cal_table)
}

