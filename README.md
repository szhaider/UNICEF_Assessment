# UNICEF Assessment

This repository contains the assessment for UNICEF D&A Education in UNICEF’s Chief Statistician’s Office

### Instructions on reproducing the project

-   User needs to execute the profile setting do file [user_profile.do] in the root folder
-   Once the dialogue box appears, select the project running do file [run_project] to complete the process
-   Next, user can run the run_project do file to execute the project end-to-end
-   These steps prepare the clean data and store the files in the output folder
-   Finally, user can initiate the R project [UNICEF_Assessment] in the root folder
-   Then open the R-script [02_programs/Population_weighted_coverage.R]
-   Executing the R-script will prepare the output (Final_Output.HTML) file with chart and short explanation

### 📁 The code is organized in the following manner

#### 01_data 📁

-   Contains the following raw data files used in the project containing tracking status, ANC4 & SBA indicator data and weights data respectively
    -   On-track and off-track countries.xlsx
    -   GLOBAL_DATAFLOW_2018-2022.xlsx
    -   WPP2022_GEN_F01_DEMOGRAPHIC_INDICATORS_COMPACT_REV1.xlsx

#### 02_programs 📁

-   Contains all the code (do file and R script) used in the project
    -   data_prep.do [cleans up and merges data from 3 input files and calculates the population weighted averages]
    -   Population_weighted_coverage.Rmd [Reads the prepared population weighted averages and produces output file with a chart]

#### 03_output 📁

-   Contains all the clean data and output file produced by the project:
    -   status.dta [cleaned data for Off-Track and On-Track countries]
    -   indicators.dta [cleaned data for ANC4 & SBA indicators in long format UNICEF Global Data Repository]
    -   births.dta [cleaned projected births (000s) data from the UN World Population Prospects, 2022]
    -   Final_Report.HTML [Final output document with the chart and a short explanation]

#### 04_figures 📁

-   📊 Contains the charts made for the assessment

#### 05_logs 📁

-   📝 Contains the log file for the entire Stata code

#### Positions applied for:

```         
-   Microdata Harmonization Consultant – Req. #581699

-   Learning and Skills Data Analyst Consultant – Req. #581598

-   Household Survey Data Analyst Consultant – Req. #581656
```
