# Danger Tree Assessment
###Saving BC's Wildfire Firefighters and First Responders 
Abbey Jackson (@earthabbey) & Alain Kahwaji (@codinglegend)

#####* In Progress: Development began June 15, 2015 *

![Screengrab](DangerTreeAssessment/DTAscreengrab.gif) 

###The Problem:
When there's a wildfire, firefighters work hard to contain the fire. Nonetheless, there are still hazards that exist all around the perimeter of the fire. The danger assessors assess these hazard, and determine which trees are dangerous and pose a threat to on-site workers. However, this assessment process is currently being done by paper where hundreds of paper reports must be processed each day. This process can take days on a larger fire -- putting all on-site workers at risk. Our app digitizes the data collection and sharing process and speeds it up significantly by 1) collecting data easily and intuitively and 2) exporting that data in a spreadsheet instead of shuffling through hundreds of papers. 


###The Innovation:
We are developing a mobile app which will significantly accelerate the process of mapping dangerous areas by collecting and delivering the data digitally. In addition, Danger Tree Assessors currently focus on areas as a whole as opposed to marking individual trees -- leaving a significant margin of error. By utilizing the GPS technology on a mobile device, we will be able to accurately capture information for each tree within an area. This information will be transferred in a spreadsheet to the data centre at the end of the day (or earlier if wifi/data is available). The Geographic Information Specialists will easily convert our data into a map, reduce human error and accelerate the process in order to ensure a safe working environment. We will create a map that will be shared via AirDrop in-field, revolutionizing the current process by allowing for updates of  hazards and danger zones in real-time.


###The Details and Attributions:
Using REALM as a backend the Danger Tree Assessment app allows for on-site digital capture of everything that is currently being captured on paper, sticking to the step by step process currently in use. Additionally GPS is captured for each individual trees, allowing maps to be more accurate (in the current system GPS is captured only for the overall site location). This data is then exported via a CVS file using CHCVSParser. Icon assets are provided by icons8.com. Assessment information Copyright BCWildfires and is being used only for demonstration purposes.

Logic checks are done to ensure trees are added to the correct site, new trees are not added without an associated site, and new sites are not created by accident when a site is already open. A user can leave their site reports open to submit later or can submit whilst in field and the email will be sent when their device finds a wifi or data connection.
