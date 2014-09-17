######################################
# rGeo - create spatial grid
# created: 2014-09-17. JK-Lee
# about: create a spatial grid shapefile. Set center, extent, cell size, and projection.
# ref: http://r-sig-geo.2731867.n2.nabble.com/Create-a-simple-spatial-grid-td7586481.html
# ref: http://www.maths.lancs.ac.uk/~rowlings/Teaching/UseR2012/cheatsheet.html
######################################

# import libraries
require(rgdal)
require(raster)
require(gstat)
library(maptools)

# remove existing objects
rm(list=ls())

# --- make grid function --- #
makeGrid = function(projCRS, origXY, boundingBox, gridSize, cellValue, folderPath, fName){
  # --- get the projection of the spatial area --- #
  projCRS = paste("+init=epsg:",projCRS, sep="")
  gridCRS = CRS(projCRS)
  
  # --- lat long always in epsg:4326 --- #
  latlon = CRS("+init=epsg:4326")
  
  # --- set the origin of the grid --- #
  # In lat long coordinates - takes vector: c(X, Y)
  origin = SpatialPoints(cbind(origXY[1], origXY[2]),latlon) 
  # In local coordinates
  originCRS = spTransform(origin, gridCRS) 
  
  # --- set the extent of the grid --- #
  # boundingBox = c(xmin, xmax, ymin, ymax)
  e = extent(boundingBox[1],boundingBox[2],boundingBox[3],boundingBox[4])
  
  # --- make a raster of the gridded points --- #
  r = raster(e)
  
  # --- set resolution --- #
  res(r)=c(gridSize,gridSize)
  
  # --- set the cell value to 0 --- #
  r[] = cellValue
  
  # --- match the projection --- #
  projection(r)= gridCRS
  
  # --- Raster to SPDF --- #
  r = as(r, 'SpatialPolygonsDataFrame')
  
  # --- write out to shapefile --- #
  output = writeOGR(r, folderPath, fName, "ESRI Shapefile")
  return(output)
}

# --- test --- #
oFolder = "/Users/apple/Desktop/files/"
thing = makeGrid("26910",c(-123.082397,49.2451825), 
                 c(478238.09, 515653.51, 5422356.34, 5468103.49), 250, 0, oFolder, "grid250m")
