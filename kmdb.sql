-- In this assignment, you'll be building the domain model, database 
-- structure, and data for "KMDB" (the Kellogg Movie Database).
-- The end product will be a report that prints the movies and the 
-- top-billed cast for each movie in the database.

-- Requirements/assumptions
--
-- - The database will have three movies in it to start – the three films
--   that make up Christopher Nolan's Batman trilogy.
-- - Movie data includes the movie title, year released, MPAA rating,
--   and studio.
-- - There are many studios, and each studio produces many movies, but
--   a movie belongs to a single studio.
-- - An actor can be in multiple movies.
-- - An actor is represented by an agent.
-- - Everything you need to do in this assignment is marked with TODO!
-- * Note rubric explanation for appropriate use of external resources.

-- User stories
--
-- - As a guest, I want to see a list of movies with the title, year released,
--   MPAA rating, and studio information.
-- - As a guest, I want to see the movies which a single studio has produced.
-- - As a guest, I want to see each movie's cast including each actor's
--   name and the name of the character they portray.
-- - As a guest, I want to see the movies which a single actor has acted in.
-- - As an agent, I want to assign myself as representing an actor.
-- - As an agent, I want to see only the list of actors I represent.
-- * Note: The "guest" user role represents the experience prior to logging-in
--   to an app and typically does not have a corresponding database table.

-- Deliverables
-- 
-- There are five deliverables for this assignment, all delivered as part of
-- this repository and submitted via GitHub and Canvas:
--
-- - An ERD (entity relationship diagram) illustrating the entities and
--   relationships in this data model.
-- - Implementation of the ERD via CREATE TABLE statements for each
--   model/table. Include DROP TABLE IF EXISTS statements for each
--   table, so that each run of this script starts with a blank database.
-- - Insertion of initial sample data into tables.
-- - Selection of data, so that something similar to the sample "report"
--   below can be achieved.

-- Rubric
--
-- 1. Domain model / ERD - 6 points
-- - Draw an ERD (entity relationship diagram) with and add it as a file
--   named "erd" (any image file extension type is acceptable).
-- - Think about how the domain model needs to reflect the
--   "real world" entities and the relationships with each other. 
--   Hint #1: It's not just a single table that contains everything in the 
--   expected output. There are multiple real world entities and
--   relationships including at least one many-to-many relationship.
--   Hint #2: Do NOT name one of your models/tables “cast” or “casts”; this 
--   is a reserved word in sqlite and will break your database! Instead, 
--   think of a better word to describe this concept; i.e. the relationship 
--   between an actor and the movie in which they act.
-- 2. Execution of the domain model (CREATE TABLE) - 4 points
-- - Follow best practices for table and column names
-- - Use correct data column types (i.e. TEXT/INTEGER)
-- - Use of the `model_id` naming convention for foreign key columns
-- 3. Insertion of data (INSERT statements) - 4 points
-- - Insert data into all the tables you've created.
-- 4. Modification of existing data (UPDATE statements) - 2 points
-- - Assign an agent as the representative of a single actor.
-- 5. "The report" (SELECT statements) - 4 points
-- - Write 3 `SELECT` statements to produce (a) list of movies with their studio,
--   (b) list of cast for each movie, and (c) list of actors the "agent" (i.e. user)
--   is assigned to represent. See the "TODO" sections below and the sample output.
--   You will need to read data from multiple tables in each `SELECT` statement.
--   Formatting does not matter.
-- 6. Using external resources for help with the assignment (including colleagues, AI, internet search, etc):
-- - Engineers look to colleagues and the internet all the time when building software.
--   You are welcome to do the same. However, the solution you submit must utilize
--   the skills and strategies covered in class. Alternate solutions which do not demonstrate
--   an understanding of the approaches used in class will receive significant deductions.
--   Any concern should be raised with faculty prior to assignment due date.

-- Submission
-- 
-- - "Use this template" to create a brand-new "hw1" repository in your
--   personal GitHub account, e.g. https://github.com/<USERNAME>/hw1
-- - Do the assignment, committing and syncing often
-- - When done, commit and sync a final time, before submitting the GitHub
--   URL for the finished "hw1" repository as the "Website URL" for the 
--   Homework 1 assignment in Canvas

-- Successful sample output is as shown:

-- Turns column mode on but headers off
.mode column
.headers off

-- Drop existing tables, so you'll start fresh each time this script is run. 
DROP TABLE IF EXISTS studio;
DROP TABLE IF EXISTS movie;
DROP TABLE IF EXISTS topcast;
DROP TABLE IF EXISTS agent;
DROP TABLE IF EXISTS character;

-- TODO!

-- Create new tables, according to your domain model

CREATE TABLE studio (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT
);

CREATE TABLE agent (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT
);

CREATE TABLE movie (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    title TEXT,
    year INTEGER,
    mpaa TEXT,
    studio_id INTEGER,
    FOREIGN KEY (studio_id) REFERENCES studio(id)
);

CREATE TABLE topcast (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT,
    agent_id INTEGER,
    FOREIGN KEY (agent_id) REFERENCES agent(id)
);

CREATE TABLE character (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    charactername TEXT,
    movie_id INTEGER,
    topcast_id INTEGER,
    FOREIGN KEY (movie_id) REFERENCES movie(id),
    FOREIGN KEY (topcast_id) REFERENCES topcast(id)
);


-- TODO!

-- Insert data into your database that reflects the sample data shown above
-- Use hard-coded foreign key IDs when necessary

-- insert studio
INSERT INTO studio (id, name) VALUES (1, 'Warner Bros.');

-- insert agent
INSERT INTO agent (id, name) VALUES (1, 'William Morris Endeavor');
INSERT INTO agent (id, name) VALUES (2, 'Creative Artists Agency');
INSERT INTO agent (id, name) VALUES (3, 'United Talent Agency');

-- insert movie
INSERT INTO movie (id, title, year, mpaa, studio_id) VALUES (1, 'Batman Begins', 2005, 'PG-13', 1);
INSERT INTO movie (id, title, year, mpaa, studio_id) VALUES (2, 'The Dark Knight', 2008, 'PG-13', 1);
INSERT INTO movie (id, title, year, mpaa, studio_id) VALUES (3, 'The Dark Knight Rises', 2012, 'PG-13', 1);

-- insert topcast
INSERT INTO topcast (id, name, agent_id) VALUES (1, 'Christian Bale', 2);
INSERT INTO topcast (id, name, agent_id) VALUES (2, 'Michael Caine', 3);
INSERT INTO topcast (id, name, agent_id) VALUES (3, 'Liam Neeson', 2);
INSERT INTO topcast (id, name, agent_id) VALUES (4, 'Katie Holmes', 3);
INSERT INTO topcast (id, name, agent_id) VALUES (5, 'Gary Oldman', 3);
INSERT INTO topcast (id, name, agent_id) VALUES (6, 'Heath Ledger', 2);
INSERT INTO topcast (id, name, agent_id) VALUES (7, 'Aaron Eckhart', 2);
INSERT INTO topcast (id, name, agent_id) VALUES (8, 'Maggie Gyllenhaal', 2);
INSERT INTO topcast (id, name, agent_id) VALUES (9, 'Tom Hardy', 2);
INSERT INTO topcast (id, name, agent_id) VALUES (10, 'Joseph Gordon-Levitt', 2);
INSERT INTO topcast (id, name, agent_id) VALUES (11, 'Anne Hathaway', 2);

-- insert character
-- Batman Begins
INSERT INTO character (charactername, movie_id, topcast_id) VALUES ('Bruce Wayne', 1, 1);
INSERT INTO character (charactername, movie_id, topcast_id) VALUES ('Alfred', 1, 2);
INSERT INTO character (charactername, movie_id, topcast_id) VALUES ('Ra''s Al Ghul', 1, 3);
INSERT INTO character (charactername, movie_id, topcast_id) VALUES ('Rachel Dawes', 1, 4);
INSERT INTO character (charactername, movie_id, topcast_id) VALUES ('Commissioner Gordon', 1, 5);
-- The Dark Knight
INSERT INTO character (charactername, movie_id, topcast_id) VALUES ('Bruce Wayne', 2, 1);
INSERT INTO character (charactername, movie_id, topcast_id) VALUES ('Joker', 2, 6);
INSERT INTO character (charactername, movie_id, topcast_id) VALUES ('Harvey Dent', 2, 7);
INSERT INTO character (charactername, movie_id, topcast_id) VALUES ('Alfred', 2, 2);
INSERT INTO character (charactername, movie_id, topcast_id) VALUES ('Rachel Dawes', 2, 8);
-- The Dark Knight Rises
INSERT INTO character (charactername, movie_id, topcast_id) VALUES ('Bruce Wayne', 3, 1);
INSERT INTO character (charactername, movie_id, topcast_id) VALUES ('Commissioner Gordon', 3, 5);
INSERT INTO character (charactername, movie_id, topcast_id) VALUES ('Bane', 3, 9);
INSERT INTO character (charactername, movie_id, topcast_id) VALUES ('John Blake', 3, 10);
INSERT INTO character (charactername, movie_id, topcast_id) VALUES ('Selina Kyle', 3, 11);


-- update agent
UPDATE topcast
SET agent_id = 1
WHERE id = 1;


-- TODO!

-- Prints a header for the movies output
.print "Movies"
.print "======"
.print ""

-- ***TODO!***
-- The SQL statement for the movies output goes here.

SELECT  
    movie.title, 
    movie.year, 
    movie.mpaa, 
    studio.name
FROM movie
JOIN studio ON movie.studio_id = studio.id;

-- Example output:
-- Movies
-- ======
-- Batman Begins          2005           PG-13  Warner Bros.
-- The Dark Knight        2008           PG-13  Warner Bros.
-- The Dark Knight Rises  2012           PG-13  Warner Bros.

-- Prints a header for the cast output
.print ""
.print "Top Cast"
.print "========"
.print ""

-- ***TODO!***
-- The SQL statement for the cast output goes here.

SELECT 
    movie.title, 
    topcast.name, 
    character.charactername
FROM character
JOIN movie ON character.movie_id = movie.id
JOIN topcast ON character.topcast_id = topcast.id;

-- Example output:
-- Top Cast
-- ========
-- Batman Begins          Christian Bale        Bruce Wayne
-- Batman Begins          Michael Caine         Alfred
-- Batman Begins          Liam Neeson           Ra's Al Ghul
-- Batman Begins          Katie Holmes          Rachel Dawes
-- Batman Begins          Gary Oldman           Commissioner Gordon
-- The Dark Knight        Christian Bale        Bruce Wayne
-- The Dark Knight        Heath Ledger          Joker
-- The Dark Knight        Aaron Eckhart         Harvey Dent
-- The Dark Knight        Michael Caine         Alfred
-- The Dark Knight        Maggie Gyllenhaal     Rachel Dawes
-- The Dark Knight Rises  Christian Bale        Bruce Wayne
-- The Dark Knight Rises  Gary Oldman           Commissioner Gordon
-- The Dark Knight Rises  Tom Hardy             Bane
-- The Dark Knight Rises  Joseph Gordon-Levitt  John Blake
-- The Dark Knight Rises  Anne Hathaway         Selina Kyle

-- Prints a header for the agent's list of represented actors
.print ""
.print "Represented by agent"
.print "===================="
.print ""

-- ***TODO!***
-- The SQL statement for the represented actor(s) output goes here.

SELECT topcast.name
FROM topcast
JOIN agent ON topcast.agent_id = agent.id
WHERE agent.id = 1;
-- Example output:
-- Represented by agent
-- ====================
-- Christian Bale
