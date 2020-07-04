# Geospatial Visualization in R
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
rm(list=ls())
install.packages(c("maptools", 
                   "rgdal",
                   "ggplot2"))

library(maptools)
library(rgdal)
library(ggplot2)

# unzip county_census file 
# run this command and navigate to county_census/County_2010Census_DP1.shp when prompted 
counties <- readShapeSpatial(file.choose(), proj4string = CRS("+proj=longlat +datum=WGS84"))
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Create Florida Template 

# create template in the shape of Florida
florida <- counties[substring(counties$GEOID10, 1, 2) == "22", ]

# check that the Florida template was created successfully: 
plot(florida)

# "GEOID10" refers to the 2010 Geographic Data from the Census. 
# You do NOT need to worry about changing this if you change the state. 
fl_shapes <- fortify(florida, region = "GEOID10")

# Graph Florida && Median Age ~~~~~~~~~~~~~~~~~~~~~~~~~~~#

# color in as a gradient based on "fill" option
# blues and greens 
  ggplot()  + 
  geom_map(data = as.data.frame(florida), 
                 aes(map_id = GEOID10, fill = DP0020001), 
                 map = fl_shapes) + expand_limits(x = fl_shapes$long, y = fl_shapes$lat)  + 
  scale_fill_gradient2(low = "darkseagreen1", mid = "darkturquoise", high = "darkslateblue",
                       labs(fill="Median Age"), midpoint = 37, limits = c(27, 43)) + 
                       xlab("") + ylab("") +  
  coord_map(projection = "mercator") + 
  theme(axis.text = element_blank(), 
         panel.background = element_blank(),
         axis.ticks = element_blank())

# pinks and creams 
  ggplot() + 
  geom_map(data = as.data.frame(florida), 
             aes(map_id = GEOID10, fill = DP0020001), 
             map = fl_shapes)  + 
  expand_limits(x = fl_shapes$long, y = fl_shapes$lat) + 
  scale_fill_gradient2(low = "lightgoldenrodyellow", mid = "lightpink", high = "lightcoral",
                       labs(fill="Median Age"), midpoint = 47, limits = c(29, 65)) + 
                       xlab("") + ylab("") +  
  coord_map(projection = "mercator") + 
  theme(axis.text = element_blank(), 
        panel.background = element_blank(),
        axis.ticks = element_blank())
  
  
# Graph II | Louisiana && Avg. Household Size ~~~~~~~~~~~~~~~~~~~~~~~~~~~#
# DP0160001 == Average Household Size (includes decimals)
 
# create template in the shape of Louisiana
louisiana <- counties[substring(counties$GEOID10, 1, 2) == "22", ]
  
# check that the template was created successfully: 
plot(louisiana)
  
# "GEOID10" refers to the 2010 Geographic Data from the Census. 
# You do NOT need to worry about changing this if you change the state. 
la_shapes <- fortify(louisiana, region = "GEOID10")

# camo (just for fun!)
ggplot() + 
  geom_map(data = as.data.frame(louisiana), 
           aes(map_id = GEOID10, fill = DP0160001), 
           map = la_shapes)  + 
  expand_limits(x = la_shapes$long, y = la_shapes$lat) + 
  scale_fill_gradient2(low = "goldenrod4", mid = "darkolivegreen3", high = "darkolivegreen",
                       labs(fill="Average Household Size"), midpoint = 2.62, limits = c(2.3, 2.9)) + 
                       xlab("") + ylab("") +  
  coord_map(projection = "mercator") + 
  theme(axis.text = element_blank(), 
        panel.background = element_blank(),
        axis.ticks = element_blank())

# red, white, & blue popsicle colors
ggplot() + 
  geom_map(data = as.data.frame(louisiana), 
           aes(map_id = GEOID10, fill =   DP0160001), 
           map = la_shapes)  + 
  expand_limits(x = la_shapes$long, y = la_shapes$lat) + 
  scale_fill_gradient2(low = "firebrick", mid = "ghostwhite", high = "dodgerblue4",
                       labs(fill="Average Household Size"), midpoint = 2.62, limits = c(2.3, 2.9)) + 
                       xlab("") + ylab("") +  
  coord_map(projection = "mercator") + 
  theme(axis.text = element_blank(), 
        panel.background = element_blank(),
        axis.ticks = element_blank())

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~