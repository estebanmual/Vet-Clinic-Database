-- These scripts will delete the tables if it's already there
DROP TABLE IF EXISTS owners;
DROP TABLE IF EXISTS species;
DROP TABLE IF EXISTS animals;
DROP TABLE IF EXISTS specialization;
DROP TABLE IF EXISTS vets;
DROP TABLE IF EXISTS visits;

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
    specie_name TEXT
);

-- Create animal table
CREATE TABLE animals
(
    animal_id INTEGER PRIMARY KEY,
    name TEXT NOT NULL,
    date_of_birth DATE,
    escape_attempts INTEGER,
    neutered TEXT,
    weight_kg DECIMAL,
    owner_id INTEGER,
	specie_id INTEGER,
    FOREIGN KEY(specie_id) REFERENCES species(specie_id),
	FOREIGN KEY(owner_id) REFERENCES owners(owner_id)
);

--Create vets table
CREATE TABLE vets
(
    vet_id INTEGER PRIMARY KEY,
    vet_name TEXT,
    age INTEGER,
    date_of_graduation DATE
);

--Create join table between species and vets
CREATE TABLE specialization
(
    specialization_id INTEGER PRIMARY KEY,
    specie_id INTEGER,
    vet_id INTEGER,
    FOREIGN KEY(specie_id) REFERENCES species(specie_id),
    FOREIGN KEY(vet_id) REFERENCES vets(vet_id)
);

--Create join table between animals and vets
CREATE TABLE visits
(
    visit_id INTEGER PRIMARY KEY,
    animal_id INTEGER,
    vet_id INTEGER,
    date_of_visit DATE,
    FOREIGN KEY(animal_id) REFERENCES animals(animal_id),
    FOREIGN KEY(vet_id) REFERENCES vets(vet_id)
);