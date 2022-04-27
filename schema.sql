-- These scripts will delete the tables if it's already there
DROP TABLE IF EXISTS owners;
DROP TABLE IF EXISTS species;
DROP TABLE IF EXISTS animals;

-- Create owners table
CREATE TABLE owners
(
	owner_id INTEGER PRIMARY KEY,
	full_name TEXT NOT NULL,
	age INTEGER
);

-- Create species table
CREATE TABLE species
(
    specie_id INTEGER PRIMARY KEY,
    name TEXT
);

-- Create animal table
CREATE TABLE animals
(
    animal_id INTEGER PRIMARY KEY,
    name TEXT NOT NULL,
    date_of_birth DATETIME,
    escape_attempts INTEGER,
    neutered TEXT,
    weight_kg DECIMAL,
    owner_id INTEGER,
	specie_id INTEGER,
    FOREIGN KEY(specie_id) REFERENCES species(specie_id),
	FOREIGN KEY(owner_id) REFERENCES owners(owner_id)
);