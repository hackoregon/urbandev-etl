# 
# Match census blocks to their neighborhoods
#
# Output is CSV. To save output redirect to file. To sort by neighborhood-id, 
# use: python map-blocks-to-hoods.py | sort -t, -k2 -n
#

# Import GIS libs
import fiona
from shapely import speedups
speedups.enable()

from shapely.geometry import shape
import rtree


def buildNeighborhoodIndex():
   '''Load the neighborhood shapefile & build and return a spatial index. Each
   shape is attached to the corresponding spatial index record'''
   spIndex = rtree.index.Index()
   
   with fiona.open('./nbo/nbo_hood.shp', 'r') as nfile:
      for npolyFeat in nfile:
         npolyShape = shape(npolyFeat['geometry'])
         spIndex.insert(int(npolyFeat['properties']['NEWID']), npolyShape.bounds, obj=npolyShape) 

   return spIndex


def calcPolyOverlap(plyShapefile, spIndex):
   '''Load the census tract shapefile for the given year & test for overlap between each
   census tract polygon and the nearby neighborhood polygons. For each overlap, print
   a CSV row to stdout'''
   
   # Write CSV header to stdout
   print("year,neighborhood_id,gisjoin,pct_overlap")
   
   with fiona.open(plyShapefile, 'r') as tfile:
      # For each tract polygon check against the spatial index of neighborhoods
      # to see if we might overlap
      for nPolyFeat in tfile:
         ps = shape(nPolyFeat['geometry'])

         for item in spIndex.intersection(ps.bounds, objects=True):
            
            # Now check for a real intersection between the 2 candidate polygons
            overlapPoly = item.object.intersection(ps)
            if not overlapPoly.is_empty:
               overlapPct = "{0:.3f}".format(overlapPoly.area / ps.area * 100)
               print('2010', item.id, nPolyFeat['properties']['GISJOIN'], overlapPct, sep=',')
    

def main():
   blkGroups = 'tract1990.shp'
   spIndex = buildNeighborhoodIndex()
   calcPolyOverlap(blkGroups, spIndex)


main()
