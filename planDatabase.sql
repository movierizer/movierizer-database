----------------Movies tables---------------

CREATE TABLE movies (
    id int PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    originalTitle VARCHAR(255),
    duration INTERVAL,
    country VARCHAR(20),
    budget BIGINT,
    boxOffice BIGINT, 
    urlTrailer TEXT,
    urlPoster TEXT,
    screenplay TEXT,
    releaseDate date,
    averageRating float CHECK (averageRating >= 0 AND averageRating <= 100),
    ratingsCount INT DEFAULT 0
);

----------------User tables---------------

CREATE TABLE users (
    id UUID PRIMARY KEY,
    username VARCHAR(50) UNIQUE NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    userLanguage VARCHAR(20),
    profilePicture TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

----------------User-ratings tables---------------

CREATE TABLE user_ratings (
    user_id INT REFERENCES users(id) ON DELETE CASCADE,
    movie_id INT REFERENCES movies(id) ON DELETE CASCADE,
    rating FLOAT CHECK (rating >= 0 AND rating <= 100),
    comment TEXT,
    favorite BOOLEAN,
    viewingDate DATE,
    movieStatus VARCHAR(10) CHECK (movieStatus IN ('watched', 'to watch', 'in progress')),
    rated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (user_id, movie_id)
);

----------------genres tables---------------

CREATE TABLE genres (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) UNIQUE NOT NULL
);

----------------genres-movies tables---------------

CREATE TABLE movie_genres (
    movie_id INT REFERENCES movies(id) ON DELETE CASCADE,
    genre_id INT REFERENCES genres(id) ON DELETE CASCADE,
    PRIMARY KEY (movie_id, genre_id)
);

----------------people tables---------------

CREATE TABLE people (
    id SERIAL PRIMARY KEY,
    firstName VARCHAR(100) NOT NULL,
    lastName VARCHAR(100) NOT NULL,
    birthdate DATE,
    nationality VARCHAR(100)
);

----------------movies-actors tables---------------

CREATE TABLE movie_actors (
    movie_id INT REFERENCES movies(id) ON DELETE CASCADE,
    person_id INT REFERENCES people(id) ON DELETE CASCADE,
    actorRole VARCHAR(100),
    PRIMARY KEY (movie_id, person_id)
);

----------------movies-directors tables---------------

CREATE TABLE movie_directors (
    movie_id INT REFERENCES movies(id) ON DELETE CASCADE,
    person_id INT REFERENCES people(id) ON DELETE CASCADE,
    PRIMARY KEY (movie_id, person_id)
);

----------------awards tables---------------

CREATE TABLE awards (
    id SERIAL PRIMARY KEY,
    name VARCHAR(200) UNIQUE NOT NULL
);

----------------awards-movies tables---------------

CREATE TABLE movie_awards (
    movie_id INT REFERENCES movies(id) ON DELETE CASCADE,
    award_id INT REFERENCES awards(id) ON DELETE CASCADE,
    awardDate DATE,
    PRIMARY KEY (movie_id, award_id)
);

----------------streaming platform tables---------------

CREATE TABLE streamingPlatforms (
    id SERIAL PRIMARY KEY,
    price int,
    name VARCHAR(200) UNIQUE NOT NULL
);

----------------streaming platform-movies tables---------------

CREATE TABLE movie_platforms (
    movie_id INT REFERENCES movies(id) ON DELETE CASCADE,
    platform_id INT REFERENCES streamingPlatforms(id) ON DELETE CASCADE,
    PRIMARY KEY (movie_id, platform_id)
);

----------------list tables---------------

CREATE TABLE lists (
    id SERIAL PRIMARY KEY,
    listName VARCHAR(200) NOT NULL,
    listDescription TEXT,
    profilePictureList TEXT,
    nbFilmList INT DEFAULT 0
);

----------------lists-movies tables---------------

CREATE TABLE movie_lists (
    movie_id INT REFERENCES movies(id) ON DELETE CASCADE,
    list_id INT REFERENCES lists(id) ON DELETE CASCADE,
    PRIMARY KEY (movie_id, list_id)
);

----------------lists-user tables---------------

CREATE TABLE users_lists (
    user_id INT REFERENCES users(id) ON DELETE CASCADE,
    list_id INT REFERENCES lists(id) ON DELETE CASCADE,
    creationDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    isPrivate BOOLEAN DEFAULT true,
    PRIMARY KEY (user_id, list_id)
);