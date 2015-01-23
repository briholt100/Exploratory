---
title: "Explore project 2"
author: "Brian Holt"
date: "Friday, January 23, 2015"
output: html_document
---

###Description of Variables:
The NEI Point data category contains emissions estimates for sources that are individually inventoried and usually located at a fixed, stationary location, although portable sources such as some asphalt or rock crushing operations are also included. Point sources include large industrial facilities and electric power plants, but also increasingly include many smaller industrial and commercial facilities, such as dry cleaners and gas stations, which had traditionally been included in Nonpoint sources. The choice of whether these smaller sources are estimated individually and included as point sources or inventoried as a Nonpoint source County or Tribal area aggregate is determined by the separate State, Local, or Tribal air agency.

The NEI Nonpoint data category contains emissions estimates for sources which individually are too small in magnitude or too numerous to inventory as individual point sources, and which can often be estimated more accurately as a single aggregate source for a County or Tribal area. Examples are residential heating and consumer solvent use.

The NEI Onroad and Nonroad data categories contain mobile sources which are estimated for the 2011 NEI v1 via the MOVES2010b and NONROAD models, respectively. NONROAD was run within the National Mobile Inventory Model (NMIM). Note that emissions data for aircraft, locomotives, and commercial marine vessels are not included in the Nonroad data category starting with the 2008 NEI. Aircraft engine emissions occurring during Landing and Takeoff operations and the Ground Support Equipment and Auxiliary Power Units associated with the aircraft are included in the point data category at individual airports. Emissions from locomotives that occur at rail yards are also included in the point data category. In-flight aircraft emissions, locomotive emissions outside of the rail yards, and commercial marine vessel emissions (both underway and port emissions) are included in the NonPoint data category.

The Events data category includes wildfires, wild land fire use and prescribed burns. Wild land fire use is controlling a wildfire to use as a prescribed burn. This web page provides emissions for this data category as county totals. Day-specific and fire-specific emissions are available on the Emissions Modeling Clearinghouse with the 2011 emissions platform data.

```{r}
summary(cars)
```

You can also embed plots, for example:

```{r, echo=FALSE}
plot(cars)
```

Note that the `echo = FALSE` parameter was added to the code chunk to prevent printing of the R code that generated the plot.
