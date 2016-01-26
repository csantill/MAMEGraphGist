// Create Constraints
//CREATE CONSTRAINT ON (G:Game) ASSERT G.name IS UNIQUE
//CREATE CONSTRAINT ON (C:Clone) ASSERT C.name IS UNIQUE
//CREATE CONSTRAINT ON (Y:Year) ASSERT Y.name IS UNIQUE
//CREATE CONSTRAINT ON (S:Status) ASSERT S.name IS UNIQUE
//CREATE CONSTRAINT ON (M:Manufacturer) ASSERT M.name IS UNIQUE

LOAD CSV WITH HEADERS FROM "https://raw.githubusercontent.com/csantill/MAMEGraphGist/master/mamelist.csv" AS line

FOREACH(ignoreMe IN CASE WHEN trim(line.cloneof) = "" THEN [1] ELSE [] END |  // If game is not a clone 
	MERGE (G:Game{name:line.name})
	MERGE (M:Manufacturer{name:line.manufacturer}) MERGE (M)-[:MANUFACTURED]->(G) MERGE (M)-[:MANUFACTURED]->(G)
	MERGE (Y:Year{name:line.year})
	MERGE (S:Status{name:line.status})
	MERGE (G)-[:PRODUCED]->(Y)
	MERGE (G)-[:STATUS]->(S)
)


FOREACH(ignoreMe IN CASE WHEN trim(line.cloneof) <> "" THEN [1] ELSE [] END |  // If a game is a clone of another Game
	MERGE (C:Clone{name:line.name}) 
	MERGE (G:Game{name:line.cloneof}) 
	MERGE (C)-[:CLONEOF]->(G) 
)
