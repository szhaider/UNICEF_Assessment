/**************************************************************************************************************************************************************
-----------------------------------------------------------
Name: 					Master.do
Description: 			Master file for the UNICEF D&A test. 
						The Master file will set up the working directory and paths. Also call other do files that will excecute the code for various analytical exercises.  

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

*-------------------------------------------------------------------------------
*A.1. SETTINGS AND VERSION CONTROL	
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

*	A.2. Set the user and main paths:  (Plz adjust the working directory root path according to your machine settings). All other paths are relative
	
	global root 	"D:\UNICEF\UNICEF_Assessment"
	global data 	"$root/01_rawdata"  
	global programs "$root/02_programs"
	global output 	"$root/03_output"
	global figures	"$root/04_figures"
	global logs 	"$root/05_logs"

*-----------------
	dir "${root}"
	dir "${data}"
	dir "${output}"
	dir "${figures}"
*-------------------------------------------------------------------------------
*	A.3. Packages used in the project

	* Loop over all the commands to test if they are already installed, if not, then install
	
  local user_commands unique kountry

  foreach command of local user_commands {
    cap which `command'
    if _rc == 111 ssc install `command'
  }

  //Theme for the charts
	set scheme white_tableau
	graph set window fontface "Arial Narrow"
*-------------------------------------------------------------------------------
*-------------------------------------------------------------------------------
cap log close
log using "$logs/logs.smcl", replace
*-------------------------------------------------------------------------------

* Executing do files

*  (***Task 1***)
		//do 						$programs/Part_1.do  

*   (***Task 2***)	
	//	do                          $programs/Part_2.do 
		
*   (***Task 3***)	
	//	do 							$programs/Part_3.do

*-------------------------------------------------------------------------------		
		
log close
*-------------------------------------------------------------------------------
