/* Database schema to keep the structure of entire database. */

CREATE TABLE animals (
    id INTEGER PRIMARY KEY,
    name TEXT NOT NULL,
    date_of_birth DATETIME,
    escape_attempts INTEGER,
    neutered TEXT,
    weight_kg DECIMAL,
    species TEXT,
);