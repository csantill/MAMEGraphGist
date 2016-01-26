LOAD CSV WITH HEADERS FROM "file:/e:/DATA/mame/mamelist.csv" AS line
MERGE (G:Game{name:line.name})
FOREACH(ignoreMe IN CASE WHEN trim(line.cloneof) <> "" THEN [1] ELSE [] END | MERGE (C:Game{name:line.cloneof}) MERGE (G)-[:CLONEOF]->(C) )
FOREACH(ignoreMe IN CASE WHEN trim(line.cloneof) <> "" THEN [] ELSE [1] END | MERGE (M:Manufacturer{name:line.manufacturer}) MERGE (M)-[:MANUFACTURED]->(G) MERGE (M)-[:MANUFACTURED]->(G) )
MERGE (Y:Year{name:line.year})
MERGE (S:Status{name:line.status})
MERGE (G)-[:PRODUCED]->(Y)
MERGE (G)-[:STATUS]->(S)

return S;