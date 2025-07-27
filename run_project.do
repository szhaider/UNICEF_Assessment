
*==============================================================================*
* UNICEF Assessment

*! MASTER RUN: Executes all tasks sequentially
*==============================================================================*

* Check that project profile was loaded, otherwise stops code
cap assert ${profile_is_loaded} == 1
if _rc {
  noi disp as error "Please execute the user_profile do in the root of this project again."
  exit 601
}

*-------------------------------------------------------------------------------
* Run all tasks in this project
*-------------------------------------------------------------------------------
* TASK : This do file cleans up the data files and calculates the population-weighted averages as needed

cap log close

log using "${clone}/05_logs/logs.smcl", replace

do "${clone}/02_programs/data_prep.do"  

log close

*-------------------------------------------------------------------------------