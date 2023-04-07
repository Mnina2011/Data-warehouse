CREATE TABLE Countries (
  id SERIAL PRIMARY KEY,
  name TEXT NOT NULL UNIQUE
);

CREATE TABLE Cities (
  id SERIAL PRIMARY KEY,
  name TEXT NOT NULL,
  country_id INTEGER NOT NULL REFERENCES Countries(id)
);

CREATE TABLE Hotels (
  id SERIAL PRIMARY KEY,
  name TEXT NOT NULL,
  category INTEGER NOT NULL,
  city_id INTEGER NOT NULL REFERENCES Cities(id)
);

CREATE TABLE RoomFeatures (
  id SERIAL PRIMARY KEY,
  name TEXT NOT NULL UNIQUE
);

CREATE TABLE Rooms (
  id SERIAL PRIMARY KEY,
  number INTEGER NOT NULL,
  hotel_id INTEGER NOT NULL REFERENCES Hotels(id),
  feature_id INTEGER NOT NULL REFERENCES RoomFeatures(id),
  status TEXT NOT NULL
);

CREATE TABLE Reservations (
  id SERIAL PRIMARY KEY,
  room_id INTEGER NOT NULL REFERENCES Rooms(id),
  guest_name TEXT NOT NULL,
  check_in DATE NOT NULL,
  check_out DATE NOT NULL
);

CREATE TABLE Revenue (
  id SERIAL PRIMARY KEY,
  hotel_id INTEGER NOT NULL REFERENCES Hotels(id),
  date DATE NOT NULL,
  room_feature_id INTEGER NOT NULL REFERENCES RoomFeatures(id),
  revenue NUMERIC(10,2) NOT NULL
);