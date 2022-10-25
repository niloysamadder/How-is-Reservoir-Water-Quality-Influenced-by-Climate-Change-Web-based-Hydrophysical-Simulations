# clean up
rm(list=ls())
graphics.off()
cat("\14")


# load libraries
library(devtools)
library(rLakeAnalyzer)
library(GLMr)
library(glmtools)
library(OceanView)

# run the Model
run_glm()

# now plot the temperature and some more interesting variables using the tools provided
# in the glmtools library
plot_var("output/output.nc")
# extract the temperature from the nml file
temp <- get_temp("output/output.nc",z_out = 0:39,reference = "bottom")
# first column ist the time of measurement
time <- temp$DateTime
# for image2d the input data needs to be a matrix
temp_mat <- as.matrix(temp[,-1])
# plot the temperature using image2D
image2D(temp_mat,time,0:39,xlab = "Year", ylab = "water level (m)", clab = "Temperature(°C)",cex.lab=1.5,cex.axis=1.5,cex.sub=1.5)

## now we change the nml file and write it to the hard disk

# therefore we first need to read it in
nml_dat <- read_nml("glm3.nml")
# then we can change some of the values using set_nml()

nml_dat <- set_nml(glm_nml = nml_dat,arg_name = "at_factor",arg_val = 1.10)

# we also change the names of the output netcdf file
nml_dat <- set_nml(glm_nml = nml_dat,arg_name = "out_fn",arg_val = "output_scen")
# and the summary .cvs file
nml_dat <- set_nml(glm_nml = nml_dat,arg_name = "csv_lake_fname",arg_val = "lake_scen")
# the we write the new nml file to harddisk using write_nml() function. we use a different name
write_nml(nml_dat,"glm2_scen.nml")
# now we run GLM with the changed nml file
run_glm(system.args = "--nml glm2_scen.nml")

# we extract the temperature for the standard nml file
temp1 <- get_temp(file = "output/output.nc",reference = "bottom",z_out = 0:39)
# and for the one with changed variables
temp2 <- get_temp(file = "output/output_scen.nc",reference = "bottom",z_out = 0:39)

# we read in the summary csv file for the standart run
sum <- read.csv("output/lake.csv")
# we change the data type of time to POSIX
sum$time <- as.POSIXct(sum$time)
# we read in the summary csv file for the run with changed nml file
sum2 <- read.csv("output/lake_scen.csv")
# and also change the data type of time to POSIX
sum2$time <- as.POSIXct(sum2$time)


## now we can plot some stuff

# plot stuff from the summary file
plot(sum$time,sum$Evaporation,'l')
lines(sum2$time,sum2$Evaporation,col=2)
plot(sum$time,sum$Evaporation-sum2$Evaporation,'l')


# plot temperature in 1m above the bottom
plot(temp1$DateTime,temp1$temp.elv_1,'l', xlab = "Year", ylab = "Temperature (°C)")
lines(temp2$DateTime,temp2$temp.elv_1,col=2)
# plot temperature in 9m from the surface
plot(temp1$DateTime,temp1$temp.elv_30,'l', xlab = "Year", ylab = "Temperature (°C)")
lines(temp2$DateTime,temp2$temp.elv_30,col=2)
# plot as HovmÃ¶ller diagramm. remember image2D needs a matrix as input and the first column of temp
# is the time
image2D(as.matrix(temp2[,-1])-as.matrix(temp1[,-1]),temp1$DateTime,0:39, xlab = "Year", ylab = "water level (m)", clab = "Temperature(°C)", cex.lab = 1.5, cex.axis = 1.5, cex.sub = 1.5)


# depths for which temp to get
z <- 0:39
# we extract the temperature important to set the reference to surface!
temp2 <- get_temp(file = "output/output_scen.nc",reference = "surface",z_out = z)
# get the hypsographic curve
hyps <- get_hypsography(glm_nml = nml_dat)
# create an empty vector to store the calculated ST values in
ST <- numeric(length(temp2$DateTime))

# for loop to calculate the ST for every time step
for (i in 1:length(temp2$DateTime)) {
  # get temperature for this time step
  temp.i <- temp2[i,-1]
  # remove depths for which no (NA) temp is available
  z.i <- z[!is.na(temp.i)]
  # remove NAs from temperature
  temp.i <- temp.i[!is.na(temp.i)]
  # calculate ST for the current time step and store to vector
  ST[i] <- schmidt.stability(temp.i,z.i,hyps$areas,hyps$depths)
}

plot(temp2$DateTime,ST,'l', xlab = "", ylab = "Schmidt Stability (J/m²)", cex.lab = 0.7)

## Thermocline Depth

m.d = meta.depths(temp, hyps$depths, slope = 0.1, seasonal = TRUE)

# depths for which temp to get
z <- 0:39
# we extract the temperature important to set the reference to surface!
temp2 <- get_temp(file = "output/output_scen.nc",reference = "surface",z_out = z)

# get the hypsographic curve
hyps <- get_hypsography(glm_nml = nml_dat)

# create an empty vector to store the calculated ST values in
td <- numeric(length(temp2$DateTime))

# for loop to calculate the md for every time step
for (i in 1:length(temp2$DateTime)) {
  # get temperature for this time step
  td.i <- temp2[i, -1]
  # remove depths for which no (NA) temp is available
  z.i <- z[!is.na(temp.i)]
  # remove NAs from temperature
  td.i <- td.i[!is.na(td.i)]
  # calculate ST for the current time step and store to vector
  td[i] <- thermo.depth(td.i, hyps$depths, seasonal = TRUE, index = FALSE, mixed.cutoff = 1)
}
View(td[i])

