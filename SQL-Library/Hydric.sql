 SELECT 
 areasymbol, 
 musym, 
 muname,
 mu.mukey/1  AS mukey,
 (SELECT TOP 1 COUNT_BIG(*)
 FROM mapunit
 INNER JOIN component ON component.mukey=mapunit.mukey AND mapunit.mukey = mu.mukey) AS comp_count,
 (SELECT TOP 1 COUNT_BIG(*)
 FROM mapunit
 INNER JOIN component ON component.mukey=mapunit.mukey AND mapunit.mukey = mu.mukey
 AND majcompflag = 'Yes') AS count_maj_comp,
 (SELECT TOP 1 COUNT_BIG(*)
 FROM mapunit
 INNER JOIN component ON component.mukey=mapunit.mukey AND mapunit.mukey = mu.mukey
 AND hydricrating = 'Yes' ) AS all_hydric,
 (SELECT TOP 1 COUNT_BIG(*)
 FROM mapunit
 INNER JOIN component ON component.mukey=mapunit.mukey AND mapunit.mukey = mu.mukey
 AND majcompflag = 'Yes' AND hydricrating = 'Yes') AS maj_hydric,
 (SELECT TOP 1 COUNT_BIG(*)
 FROM mapunit
 INNER JOIN component ON component.mukey=mapunit.mukey AND mapunit.mukey = mu.mukey
 AND majcompflag = 'Yes' AND hydricrating != 'Yes') AS maj_not_hydric,
  (SELECT TOP 1 COUNT_BIG(*)
 FROM mapunit
 INNER JOIN component ON component.mukey=mapunit.mukey AND mapunit.mukey = mu.mukey
 AND majcompflag != 'Yes' AND hydricrating  = 'Yes' ) AS hydric_inclusions,
 (SELECT TOP 1 COUNT_BIG(*)
 FROM mapunit
 INNER JOIN component ON component.mukey=mapunit.mukey AND mapunit.mukey = mu.mukey
 AND hydricrating  != 'Yes') AS all_not_hydric, 
  (SELECT TOP 1 COUNT_BIG(*)
 FROM mapunit
 INNER JOIN component ON component.mukey=mapunit.mukey AND mapunit.mukey = mu.mukey
 AND hydricrating  IS NULL ) AS hydric_null 
 INTO #main_query
 FROM legend  AS l
 INNER JOIN  mapunit AS mu ON mu.lkey = l.lkey AND  l.areasymbol LIKE 'WI001'
 
 
SELECT  areasymbol, musym, 
 muname,
 mu.mukey/1  AS mukey,
CASE WHEN comp_count = all_not_hydric + hydric_null THEN  'Nonhydric' 
WHEN comp_count = all_hydric  THEN 'Hydric' 
WHEN comp_count != all_hydric AND count_maj_comp = maj_hydric THEN 'Predominantly Hydric' 
WHEN hydric_inclusions >= 0.5 AND  maj_hydric < 0.5 THEN  'Predominantly Nonydric' 
WHEN maj_not_hydric >= 0.5  AND  maj_hydric >= 0.5 THEN 'Partially Hydric' ELSE 'Error' END AS hydric_rating
FROM #main_query

 
 
 

 