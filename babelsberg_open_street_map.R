# Street Map Babelsberg

### load packages

library(osmplotr)
library(osmdata)
library(sf)

### load data babelsberg

available_features()
available_tags("addr")


q1 <- opq(bbox = c(13.0874, 52.3999, 13.0980, 52.3896) ) %>%
    add_osm_feature(key = "building" ) %>%
	osmdata_sf()

### plot babelsberg nord square

pdf_datei <- "your Path"
cairo_pdf(bg="grey20", pdf_datei, width = 5, height = 8)
par(mai = c(0, 0, 0, 0),
    omi = c(1, 0, 0, 0)
    las = 1)
sp::plot(q1$osm_polygons[1],
bg = "gray20",
col = "gray40",
main ="",
border = "gray40") 
mtext("Babelsberg", side = 1, line = -1.95, padj = 0, cex = 1.5, col = "grey40", outer = TRUE)
dev.off()


### load data potsdam  

bbox <- getbb("potsdam")

q2 <- opq(bbox = bbox, timeout=25*100 ) %>%
    add_osm_feature(key = "building" ) %>%
	add_osm_feature(key = 'addr:postcode') %>%
	osmdata_sf()



# choose by zip code - remove outer area from potsdam
zipcodes <- c(14467, 14469, 14471, 14473, 14476, 14478, 14480, 14482)
myrows     <- which(q3$osm_polygons$addr.postcode %in% zipcodes)
water <- q3$osm_polygons[myrows,]

### plot potsdam

pdf_datei <- "Your Path"
cairo_pdf(bg="grey20", pdf_datei, width = 5, height = 6)
par(mai = c(0, 0, 0, 0),
    omi = c(0.5, 0, 0, 0), family = "Lato Light",
    las = 1)
sp::plot(q2$osm_polygons[1],
bg = "grey5",
col = "grey100",
main ="",
border = "NA") 
mtext("Potsdam", side = 1, line =-2.5 ,adj = 0.75,  cex = 0.5, family = "Lato Bold", col = "grey80", outer = FALSE)
dev.off()

