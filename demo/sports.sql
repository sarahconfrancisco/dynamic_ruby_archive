
CREATE TABLE owners (
  id INTEGER PRIMARY KEY,
  name VARCHAR(255) NOT NULL,
  net_worth BIGINT NOT NULL
);

CREATE TABLE teams (
  id INTEGER PRIMARY KEY,
  city VARCHAR(255) NOT NULL,
  name VARCHAR(255) NOT NULL,
  mascot VARCHAR(255),
  owner_id INTEGER NOT NULL UNIQUE,
  FOREIGN KEY (owner_id) REFERENCES owners(id)
);

CREATE TABLE players (
  id INTEGER PRIMARY KEY,
  name VARCHAR(255) NOT NULL,
  skill_level INTEGER NOT NULL,
  team_id INTEGER,
  FOREIGN KEY (team_id) REFERENCES teams(id)
);


INSERT INTO
  owners (id, name, net_worth)
VALUES
  (1, "Spencer Hastings", 6500000),
  (2, "Mona Vanderwaal", 7100000 ),
  (3, "Aria Montgomery", 5200000 ),
  (4, "Emily Fields", 4300000),
  (5, "Hanna Marin", 2200000),
  (6, "Alison DiLaurentis", 7500000);

INSERT INTO
  teams (id, city, name, mascot, owner_id)
VALUES
  (1, "Madrid", "The Preppers", NULL, 1),
  (2, "Paris", "The Radlers", "Black Hoodie", 2),
  (3, "Boston", "The Piggers", "Pigtunia", 3),
  (4, "San Diego", "The Fish", NULL, 4),
  (5, "New York", "The Queens", NULL, 5),
  (6, "Rosewood", "Red Coats", "Vivian Darkbloom", 6);

INSERT INTO
  players (id, name, skill_level, team_id)
VALUES
  (1, "Toby Cavanaugh", 45, 1),
  (2, "Eddie Lamb", 35, 1),
  (3, "Wren Kingston", 33, 1),
  (4, "Marco Furey", 46, 1),
  (5, "Andrew Campbell", 40, 1),
  (6, "Jenna Marshall", 48, 2),
  (7, "Sara Harvey", 30, 2),
  (8, "Sydney Driscoll", 35, 2),
  (9, "Noel Kahn", 49, 2),
  (10, "Mike Montgomery", 44, 2),
  (11, "Caleb Rivers", 47, 5),
  (12, "Lucas Gottesman", 25, 5),
  (13, "Sean Ackard", 30, 5),
  (14, "Travis Hobbs", 33, 5),
  (15, "Anne Sullivan", 38, 5),
  (16, "Ezra Fitz", 22, 3),
  (17, "Holden Strauss", 40, 3),
  (18, "Jackie Molina", 38, 3),
  (19, "Clark Wilkins", 39, 3),
  (20, "Jake Guzman", 44, 3),
  (21, "Samara Cook", 33, 4),
  (22, "Paige McCullers", 30, 4),
  (23, "Sabrina Brud", 39, 4),
  (24, "Maya St. Germain", 30, 4),
  (25, "Wayne Fields", 42, 4),
  (26, "Cindy Moreno", 40, 6),
  (27, "Mindy Moreno", 40, 6),
  (28, "Barry Maples", 46, 6),
  (29, "Jason DiLaurentis", 31, 6),
  (30, "Archer Dunhill", 30, 6);
