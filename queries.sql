/*Queries that provide answers to the questions from all projects.*/

-- Find all animals whose name ends in "mon"
SELECT *
FROM animals
WHERE name LIKE '%mon';

-- List the name of all animals born between 2016 and 2019.
SELECT name
FROM animals
WHERE date_of_birth BETWEEN '2016%' AND '2019%'

-- List the name of all animals that are neutered and have less than 3 escape attempts.
SELECT name
FROM animals
WHERE neutered = 'true' AND escape_attempts <= 3;

-- List date of birth of all animals named either "Agumon" or "Pikachu".
SELECT date_of_birth
FROM animals
WHERE name IN ('Agumon', 'Pikachu');

-- List name and escape attempts of animals that weigh more than 10.5kg
SELECT name, escape_attempts
FROM animals
WHERE weight_kg >  10.5

-- Find all animals that are neutered.
SELECT *
FROM animals
WHERE neutered = 'true'

-- Find all animals not named Gabumon.
SELECT *
FROM animals
WHERE name <> 'Gabumon'

-- Find all animals with a weight between 10.4kg and 17.3kg (including the animals with the weights that equals precisely 10.4kg or 17.3kg)
SELECT *
FROM animals
WHERE weight_kg BETWEEN 10.4 AND 17.3

-- How many animals are there?
SELECT COUNT(*)
FROM animals

-- How many animals have never tried to escape?
SELECT COUNT(*)
FROM animals
WHERE escape_attempts = 0

-- What is the average weight of animals?
SELECT AVG(weight_kg)
FROM animals

-- Who escapes the most, neutered or not neutered animals?
SELECT neutered
FROM animals
GROUP BY neutered
ORDER BY COUNT(neutered) DESC
LIMIT 1

-- What is the minimum and maximum weight of each type of animal?
SELECT species, MIN(weight_kg), MAX(weight_kg)
FROM animals
GROUP BY species

-- What is the average number of escape attempts per animal type of those born between 1990 and 2000?
SELECT species, AVG(escape_attempts)
FROM animals
WHERE date_of_birth BETWEEN '1990%' AND '2000%'
GROUP BY species

-- What animals belong to Melody Pond?
SELECT a.name
FROM animals a
INNER JOIN owners o
	ON a.owner_id = o.owner_id
WHERE o.full_name = 'Melody Pond';

-- List of all animals that are pokemon (their type is Pokemon).
SELECT a.name
FROM animals a
INNER JOIN species s
	ON s.specie_id = a.specie_id
WHERE s.name = 'Pokemon';

-- List all owners and their animals, remember to include those that don't own any animal.
SELECT o.full_name, a.name
FROM animals a
INNER JOIN owners o
	ON o.owner_id = a.owner_id;

-- How many animals are there per species?
SELECT s.name, COUNT(*)
FROM animals a
INNER JOIN species s
	ON s.specie_id = a.specie_id
GROUP BY s.name;

-- List all Digimon owned by Jennifer Orwell.
SELECT a.name
FROM animals a
INNER JOIN species s
	ON s.specie_id = a.specie_id
INNER JOIN owners o
	ON o.owner_id = a.owner_id
WHERE o.full_name = 'Jennifer Orwell'

-- List all animals owned by Dean Winchester that haven't tried to escape.
SELECT *
FROM animals a
INNER JOIN species s
	ON s.specie_id = a.specie_id
INNER JOIN owners o
	ON o.owner_id = a.owner_id
WHERE o.full_name = 'Dean Winchester' AND escape_attempts = 0;

-- Who owns the most animals?
SELECT o.full_name
FROM animals a
INNER JOIN owners o
	ON o.owner_id = a.owner_id
GROUP BY o.owner_id
ORDER BY COUNT(*) DESC
LIMIT 1;

-- Who was the last animal seen by William Tatcher?
SELECT a.name
FROM animals a
INNER JOIN visits vi
	ON vi.animal_id = a.animal_id
INNER JOIN vets ve
	ON vi.vet_id = ve.vet_id
WHERE vet_name = 'William Tatcher'
ORDER BY date_of_visit DESC
LIMIT 1;

-- How many different animals did Stephanie Mendez see?
SELECT COUNT(*)
FROM animals a
INNER JOIN visits vi
	ON vi.animal_id = a.animal_id
INNER JOIN vets ve
	ON vi.vet_id = ve.vet_id
WHERE vet_name = 'Stephanie Mendez';

-- List all vets and their specialties, including vets with no specialties.
SELECT ve.vet_name, sp.specie_name
FROM vets ve
INNER JOIN specialization spz
	ON spz.vet_id = ve.vet_id
INNER JOIN species sp
	ON sp.specie_id = spz.specie_id

-- List all animals that visited Stephanie Mendez between April 1st and August 30th, 2020.
SELECT a.name, vi.date_of_visit
FROM animals a
INNER JOIN visits vi
	ON vi.animal_id = a.animal_id
INNER JOIN vets ve
	ON vi.vet_id = ve.vet_id
WHERE vet_name = 'Stephanie Mendez' 
	AND date_of_visit BETWEEN '2020-04-01' AND '2020-08-30';

-- What animal has the most visits to vets?
SELECT a.name, COUNT(*) AS total_visits
FROM animals a
INNER JOIN visits vi
	ON vi.animal_id = a.animal_id
INNER JOIN vets ve
	ON vi.vet_id = ve.vet_id
GROUP BY a.name
ORDER BY total_visits DESC
LIMIT 1;

-- Who was Maisy Smith's first visit?
SELECT a.name
FROM animals a
INNER JOIN visits vi
	ON vi.animal_id = a.animal_id
INNER JOIN vets ve
	ON vi.vet_id = ve.vet_id
WHERE vet_name = 'Maisy Smith'
ORDER BY date_of_visit ASC
LIMIT 1;

-- Details for most recent visit: animal information, vet information, and date of visit.
SELECT a.name, a.date_of_birth, a.escape_attempts, a.neutered, a.weight_kg, ve.vet_name, ve.age, vi.date_of_visit
FROM animals a
INNER JOIN visits vi
	ON vi.animal_id = a.animal_id
INNER JOIN vets ve
	ON vi.vet_id = ve.vet_id
ORDER BY date_of_visit DESC;
LIMIT 1;

-- How many visits were with a vet that did not specialize in that animal's species?
SELECT COUNT(*)
FROM animals a
INNER JOIN visits vi
	ON vi.animal_id = a.animal_id
INNER JOIN vets ve
	ON vi.vet_id = ve.vet_id
WHERE vet_name = 'Maisy Smith';

-- What specialty should Maisy Smith consider getting? Look for the species she gets the most.
SELECT specie_name
FROM animals a
INNER JOIN visits vi
	ON vi.animal_id = a.animal_id
INNER JOIN vets ve
	ON vi.vet_id = ve.vet_id
INNER JOIN species spe
	ON a.specie_id = spe.specie_id
WHERE vet_name = 'Maisy Smith'
GROUP BY spe.specie_name
ORDER BY most_visits DESC
LIMIT 1;