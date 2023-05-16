
library(sf)
library(magrittr)
library(geojsonR)
library(geojsonsf)
library(wdpar)
library(spatialEco)

#Canada <-  geojsonsf::geojson_sf("https://geoportal.gov.mb.ca/datasets/manitoba::canada-provinical-boundaries.geojson?outSR=%7B%22latestWkid%22%3A3857%2C%22wkid%22%3A102100%7D")%>%
# st_transform(crs = "+proj=longlat +datum=WGS84")%>%
# st_cast("POLYGON")
  

Canada <- st_read("C:/ParksCan_GEOBON/Data_inputs/GeopoliticalAreas_p_nolakes.shp")%>%
  st_transform(crs = "+proj=longlat +datum=WGS84")

provinces_study <- Canada[Canada$juri_en %in% c("Manitoba","Ontario","Quebec"), ]

#treaties <- geojsonsf::geojson_sf("https://native-land.ca/wp-content/themes/NLD-2021/files/indigenousTreaties.json")%>%
#  st_transform(crs = "+proj=longlat +datum=WGS84")

#ecoregions <- st_read("C:/ParksCan_GEOBON/Data_inputs/Ecoregion_Canada_clip.shp")%>%
#  st_transform(crs = "+proj=longlat +datum=WGS84")


ecozones_can <- geojsonsf::geojson_sf("https://agriculture.canada.ca/atlas/data_donnees/nationalEcologicalFramework/data_donnees/geoJSON/ez/nef_ca_ter_ecozone_v2_2.geojson")


study_area <- ecozones_can[ecozones_can$ECOZONE_NAME_EN == "Hudson Plains", ]%>%
  st_transform(crs = "+proj=longlat +datum=WGS84")


#territories <- geojsonsf::geojson_sf("https://native-land.ca/wp-content/themes/NLD-2021/files/indigenousTerritories.json")%>%
 # st_zm(drop = T)%>%
 # st_transform(crs = "+proj=longlat +datum=WGS84")

#st_write(territories, "C:/ParksCan_GEOBON/Data_inputs/territories.shp")

territories_area <- st_read("C:/ParksCan_GEOBON/Data_inputs/territories_selected.shp")%>%
  st_transform(crs = "+proj=longlat +datum=WGS84")


#municipalities <- geojsonsf::geojson_sf("https://ws.mapserver.transports.gouv.qc.ca/swtq?service=wfs&version=2.0.0&request=getfeature&typename=ms:lieuhabite&outfile=LieuHabite&srsname=EPSG:4326&outputformat=geojson")%>%
#  st_transform(crs = "+proj=longlat +datum=WGS84")
  

#ON_cities <- geojsonsf::geojson_sf("https://open.canada.ca/data/api/action/package_show?id=2bee144c-4c52-4ce3-bd9a-e7c1166f2402")%>%
  #                                 st_transform(crs = "+proj=longlat +datum=WGS84")
                                   
municipalities <- st_read("C:/ParksCan_GEOBON/Data_inputs/towns_selected2.shp")%>%
  st_transform(crs = "+proj=longlat +datum=WGS84")

municipalities_area <- municipalities[municipalities$CATEGORY %in% "Populated Place", ]



#municipalities_area_prov <- municipalities_area[municipalities_area$PROV_TERR %in% c("Manitoba","Ontario","Quebec"), ]


# Protected areas
  #Protected_areas <- wdpa_fetch("Canada",
     #                           wait = TRUE,
     #                           download_dir = rappdirs::user_data_dir("wdpar"),
     #                           force_download = F)%>%
    #st_transform(crs = "+proj=longlat +datum=WGS84")%>%
    #wdpa_clean()
protected_areas <- st_read("C:/ParksCan_GEOBON/Data_inputs/pas_selected2.shp")%>%
  st_transform(crs = "+proj=longlat +datum=WGS84")
  
#protected_areas_prov <- protected_areas[protected_areas$SUB_LOC %in% c("CA-ON", "CA-QC", "CA-MB"), ]

protected_areas_prov <- protected_areas[protected_areas$STATUS %in% "Designated", ]

