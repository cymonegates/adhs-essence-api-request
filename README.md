# ESSENCE Data Pull

# Overview
If you are an authorized BioSense Platform user, you can use this R script to connect to the Platform and pull down your query results into R for automated extracts or analysis. 

Context: Syndromic surveillance is a public health strategy used to, in near- real time, detect and monitor health events in a community using healthcare facility visit data. In partnership with local and state jurisdictions, the Centers for Disease Control and Prevention (CDC) have made syndromic surveillance data available through a program called the National Syndromic Surveillance Program (NSSP). The NSSP hosts the cloud-based BioSense Platform, a secure integrated electronic health information system with analytic tools including the Electronic Surveillance System for the Early Notification of Community-Based Epidemics (ESSENCE). These tools enable users to rapidly collect, evaluate, share, and store syndromic surveillance data. Access is restricted to those public health and partner organizations that require access to perform their job duties.

# Basic Instructions
1. In ESSENCE, use the Query Portal to select the visits you want to see
2. Select the results type you'd like (e.g. Table Builder, Data Details, Time Series, etc.)
3. Click the arrow next to Query options and select "API URLs"
4. Copy the URL in the CSV text box. You may see two options (CSV with raw values and CSV with reference values). If so, select the raw values option.
5. Download the R Script and open in your R Desktop or in the NSSP online R Studio Workbench
6. Set up or point to your Rnssp package myProfile credentials (instructions in the script or visit https://cdcgov.github.io/Rnssp/articles/Rnssp_intro.html to learn how to)
7. Paste the URl you copied in between the quotation marks on line 75
8. Run line 85 to bring the API results into the api_data data frame

# Notes and Considerations
If you change your BioSense Platform password, you'll need to rerun lines 60 & 62

# Issues or Questions
Email syndromicsurveillance@azdhs.gov

# License Standard Notice
The repository utilizes code licensed under the terms of the Apache Software License and therefore is licensed under ASL v2 or later.

This source code in this repository is free: you can redistribute it and/or modify it under the terms of the Apache Software License version 2, or (at your option) any later version.

This source code in this repository is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the Apache Software License for more details.

You should have received a copy of the Apache Software License along with this program. If not, see http://www.apache.org/licenses/LICENSE-2.0.html

The source code forked from other open source projects will inherit its license.

# Privacy Standard Notice
This repository contains only non-sensitive, publicly available data and information.

