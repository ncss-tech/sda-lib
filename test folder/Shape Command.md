## Shape Command
Below is a simple sample Shape command that returns map unit symbol, map unit name, component name and corresponding representative percent composition for all components for all map units for the Hall County Nebraska SSURGO survey area.

### Example Code 
``` SQL
SHAPE {
SELECT musym, muname, mukey
FROM legend l
INNER JOIN mapunit mu ON l.lkey = mu.lkey
WHERE areasymbol = **'NE079' **
ORDER BY museq}
APPEND ({
SELECT mu.mukey, comppct_r, compname
FROM legend l
INNER JOIN mapunit mu ON l.lkey = mu.lkey
LEFT OUTER JOIN component c ON mu.mukey = c.mukey
WHERE areasymbol = **'NE079'**
ORDER BY comppct_r DESC, compname}
AS component RELATE mukey TO mukey)
```

### Example Table format

![alt.text](/TableImages/ShapeCommandT1.png)

![alt.text](/TableImages/ShapeCommandT2.png)


### Additonal Information
Constructing and using Shape commands, please see a current text on Active X Data Objects (ADO), or search the web using the key phrase "ADO shape command". At the time this was written, an introduction to Shape command syntax was available as an article in the Microsoft Knowledge Base at the following 

URL: http://support.microsoft.com/kb/189657/en-us

A couple sample Shape commands are also included in the sample query document titled "Using an ADO Shape Command", available at the following 

URL: https://sdmdataaccess.sc.egov.usda.gov/queryhelp.aspx