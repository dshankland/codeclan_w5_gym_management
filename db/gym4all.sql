DROP TABLE bookings;
DROP TABLE members;
DROP TABLE gymclasses;

CREATE TABLE members(
  id SERIAL PRIMARY KEY,
  name VARCHAR,
  premium BOOLEAN
);

CREATE TABLE gymclasses(
  id SERIAL PRIMARY KEY,
  name VARCHAR,
  time TIMESTAMP WITH TIME ZONE,
  spaces INT
);

CREATE TABLE bookings(
  id SERIAL PRIMARY KEY,
  member_id INT REFERENCES members(id) ON DELETE CASCADE,
  gymclass_id INT REFERENCES gymclasses(id) ON DELETE CASCADE
);