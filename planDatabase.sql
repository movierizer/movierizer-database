 ----------------Movies tables---------------

CREATE TABLE movies (
    id INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(255) NOT NULL,
    overview TEXT,
    original_title VARCHAR(255),
    release_date date,
    poster_path TEXT,
    backdrop_path TEXT,
    budget INT,
    revenue INT,
    runtime INT,
    country VARCHAR(20),
    url_trailer TEXT,
);

----------------User tables---------------

CREATE TABLE users (
    id UUID PRIMARY KEY,
    username VARCHAR(50) UNIQUE NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    user_language VARCHAR(20),
    profile_picture TEXT DEFAULT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    tokenTMDB TEXT
);

----------------User-ratings tables---------------

CREATE TABLE user_ratings (
    user_id INT REFERENCES users(id) ON DELETE CASCADE,
    movie_id INT REFERENCES movies(id) ON DELETE CASCADE,
    rating FLOAT ,
    comment TEXT,
    favorite BOOLEAN,
    viewing_date DATE,
    movie_status VARCHAR(10) CHECK (movieStatus IN ('watched', 'to watch', 'in progress')),
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
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    birth_date DATE,
    nationality VARCHAR(100)
);

----------------movies-actors tables---------------

CREATE TABLE movie_actors (
    movie_id INT REFERENCES movies(id) ON DELETE CASCADE,
    person_id INT REFERENCES people(id) ON DELETE CASCADE,
    actor_role VARCHAR(100),
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
    award_date DATE,
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
    list_description TEXT,
    profile_pictureList TEXT,
    nb_film_list INT DEFAULT 0
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
    creation_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    is_private BOOLEAN DEFAULT true,
    PRIMARY KEY (user_id, list_id)
);

----------------user-movie tabel---------------

CREATE TABLE user_movies (
    id_user_movie BIGINT PRIMARY KEY AUTO_INCREMENT,
    user_id INT REFERENCES users(id) ON DELETE CASCADE,
    movie_id INT REFERENCES movies(id) ON DELETE CASCADE,
    watchlist VARCHAR(30) DEFAULT 'none',
    grade INT DEFAULT NULL CHECK (if grade != NULL, grade >= 0 AND grade <= 100),
    PRIMARY KEY (user_id, movie_id)
)

-------------tag table----------------------

CREATE TABLE tags (
    id SERIAL PRIMARY KEY,
    name VARCHAR(70) UNIQUE NOT NULL
);

-------------movie-tags table----------------------

CREATE TABLE movie_tags (
    movie_id INT REFERENCES movies(id) ON DELETE CASCADE,
    tag_id INT REFERENCES tags(id) ON DELETE CASCADE,
    PRIMARY KEY (movie_id, tag_id)
)   PRIMARY KEY (movie_id, tag_id)
