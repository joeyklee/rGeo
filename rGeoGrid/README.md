# rGeoGrid
## About
R based function that allows you to create a spatial grid shapefile. Set center, extent, cell size, and projection.

## Input Parameters
makeGrid = function(**projCRS**, **origXY**, **boundingBox**, **gridSize**, **cellValue**, **folderPath**, **fName**)

* projCRS: 
	* the EPSG code for the local projection (e.g. the epsg code for utm zone 10N is: 26910) The input should be in quotes " " (e.g. "26910")
* origXY:
	* the lat long coordinates in decimal degrees of the center. the function expects a **vector**,so if your center is: -123.082397,49.2451825, then just wrap it in the R combine function like this: c(-123.082397,49.2451825)
* boundingBox:
	* the bounding box of your study area in the **local** coordinate system. The function expects a **vector**.
	* if you're using the utm zone 10N, for example, then you would use meters (e.g. c(478238.09, 515653.51, 5422356.34, 5468103.49) ). Don't forget to wrap it in the Combine function
	* useful tool: http://epsg.io/26910/map
* gridSize:
	* this is the grid resolution (e.g. 50 or 100). This takes the spatial units of your **projCRS** so if you're using meters, then input meters, if its kilometers, then the resolution will reflect km.
* cellValue:
	* a value will be generated for each grid cell. It can be whatever you like. 
* folderPath:
	* Specify where you want the shapefile to go. 
* fName:
	* a name for the shapefile. **do not append .shp** or anything fancy at the end. just the name in " " will do. (e.g. "grid50m")

