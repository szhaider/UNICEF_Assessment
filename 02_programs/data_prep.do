
// This do file cleans up the data files needed to calculate the on-track and off-track population weighted averages of ANC4 and SBA

// Data Clean up steps for various data files used in the analysis


*===============================================================================
// Reading on-track, off-track classification file
import excel using "${clone}/01_rawdata/On-track and off-track countries.xlsx", first clear

rename (ISO3Code OfficialName StatusU5MR) (ccode cname status)
des

tab status

// Defining 2 broader categories as needed
replace status = "On-track" if inlist(status, "Achieved", "On Track")
replace status = "Off-track" if status == "Acceleration Needed"

tab status   // 59 off-track countries

save "${clone}/03_output/status.dta", replace 

*===============================================================================
// Reading ANC4 and SBA data file retreived from UNICEF Data Warehouse as on 07/27/2025
import excel using "${clone}/01_rawdata/GLOBAL_DATAFLOW_2018-2022.xlsx", first clear 

rename *, lower
rename (geographicarea time_period obs_value data_source) (cname year val source)

keep cname indicator year val source  //sex - no gender disaggregation available in data
drop in 1325
unique cname   // 222 inclusing regional aggregates

destring year val, replace

tab indicator,m
replace indicator = "anc4" if indicator == "Antenatal care 4+ visits - percentage of women (aged 15-49 years) attended at least four times during pregnancy by any provider"
replace indicator = "sba" if indicator == "Skilled birth attendant - percentage of deliveries attended by skilled health personnel"

gsort cname indicator year

//Duplicates check
duplicates report cname indicator year // Duplicates exist in the data 
duplicates list cname indicator year  // Duplicates exist within regional estimates
duplicates tag cname indicator year, gen(x)
// dropping duplicates
tab x
drop if x != 0
drop x

// final duplicates check 
isid cname indicator year  // Okay

// Keeping the latest year for each country per indicator
bys cname indicator (year): egen x = max(year)
keep if year == x
drop x

// Brining in the iso3 codes to merge with the other 2 files using kountry package
// user_profile.do execution should install this package in the local machine if not already installed
kountry cname, from(other) stuck marker
rename _ISO3N_ cname_n
kountry cname_n, from(iso3n) to(iso3c)
drop cname_n

rename _ISO3C_ ccode
order ccode, after(cname)
drop if ccode == ""     
unique ccode 				// We are left with 145 countries

save "${clone}/03_output/indicators.dta", replace

*===============================================================================

// Reading the data file for projected births (2022) for weights
import excel using "${clone}/01_rawdata/WPP2022_GEN_F01_DEMOGRAPHIC_INDICATORS_COMPACT_REV1.xlsx", ///
					 sheet(Projections) cellrange(C17:X8237) first clear
					 
rename *, lower					 
keep regionsubregioncountryorar iso3alphacode type year birthsthousands
rename (regionsubregioncountryorar iso3alphacode birthsthousands) (cname ccode births)

destring births, replace force
keep if type == "Country/Area"    // Keeping only countries

// Keeping 2022 projected births for each country
sort ccode year
bys ccode (year): egen x = min(year)
keep if year == x
drop x

unique ccode   		// We are left with 72 countries

save "${clone}/03_output/births.dta", replace

*===============================================================================

// Merging 3 prepared datasets 

use "${clone}/03_output/indicators.dta", clear                        // Indicators data
merge m:1 ccode using "${clone}/03_output/births.dta", keep(3) nogen  // 2022 Births (000s) data for weights
merge m:1 ccode using "${clone}/03_output/status.dta", keep(3) nogen  // Status data 

drop source
unique ccode   		// finally, we are left with 50 countries

// Calculate population-weighted coverage for each group (on-track and off-track), calculate population-weighted averages for ANC4 and SBA
// Using projected births for 2022 as weights 

collapse (mean) val [pw=births], by(indicator status)

save "${clone}/03_output/weighted_coverge.dta", replace					

*===============================================================================				