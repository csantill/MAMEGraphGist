// PacMan is a clone of Puckman

match (C:Game {name:'pacman'})-[:CLONEOF]-(G:Game) 
match (M:Manufacturer)-[:MANUFACTURED]-(G)
match (Y:Year) -[:PRODUCED]-(G)
return C,G,M,Y;