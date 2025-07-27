/**************************************************************************************************************************************************************
-----------------------------------------------------------
Name: 					user_profile.do
Description: 			Master file for the UNICEF D&A test. 
						The user_profile file will set up the working directory and paths. Also call other do files that will excecute the code for various analytical exercises.  

Purpose: 				UNICEF D&A TEST				

Date last modified:		July 27, 2025


*********************************************************************************/

/*
********************Folder structure for the test*******************************

Follwing folder structure has been followed for the whole project

-*root
--*root/01_data/
--*root/02_programs
--*root/03_output
--*root/04_figures 
--*root/05_logs

Project can be cloned from following Git repo
https://github.com/szhaider/UNICEF_Assessment.git

*/

/*
----------------------------General Comments------------------------------------

*/

*! PROFILE: Required step before running any do-files in this project
*==============================================================================*

*-------------------------------------------------------------------------------
*	1. SETTINGS AND VERSION CONTROL	
clear all							
version 16 							
set more off 						
set linesize 120					
macro drop all 	
mat drop _all
cls
pause off
set maxvar 120000
*-------------------------------------------------------------------------------

*-----------------------------------------------------------------------------
  * 2. Define user-dependant path for local clone repo
*-----------------------------------------------------------------------------
* Change here only if this repo is renamed
local this_repo     "UNICEF_Assessment"
* Change here only if this master run do-file is renamed
local this_run_do   "run_project.do"

* Dialog box to select file manually
capture window fopen path_and_run_do "Select the user_profile do-file for this project (`this_run_do'), expected to be inside any path/`this_repo'/" "Do Files (*.do)|*.do|All Files (*.*)|*.*" do
	
* Pretend user chose what was expected in terms of string lenght to parse
local user_chosen_do   = substr("$path_and_run_do",   - strlen("`this_run_do'"),     strlen("`this_run_do'") )
local user_chosen_path = substr("$path_and_run_do", 1 , strlen("$path_and_run_do") - strlen("`this_run_do'") - 1 )

* Replace backward slash with forward slash (Windows & Mac issue)
local user_chosen_path = subinstr("`user_chosen_path'", "\", "/", .)

* Check if master do-file chosen by the user is master_run_do as expected
* If yes, attributes the path chosen by user to the clone, if not, exit
if "`user_chosen_do'" == "`this_run_do'"  global clone "`user_chosen_path'"
else {
      noi disp as error _newline "{phang}You selected $path_and_run_do as the master do file. This does not match what was expected (any path/`this_repo'/`this_run_do'). Code aborted.{p_end}"
      error 2222
      }		
*===============================================================================	
* Packages used in the project

* Loop over all the commands to test if they are already installed, if not, then install
	
local user_commands unique kountry

foreach command of local user_commands {
    cap which `command'
    if _rc == 111 ssc install `command'
  }
*===============================================================================	
	
*-----------------------------------------------------------------------------
  * 3. Make sure that profile has been loaded
*-----------------------------------------------------------------------------
noi disp as result _n `"{phang}`this_repo' clone sucessfully set up (${clone}).{p_end}"'
global profile_is_loaded = 1
  *-----------------------------------------------------------------------------	

