DROP TABLE IF EXISTS music_album;
DROP TABLE IF EXISTS favourite_music;
DROP TABLE IF EXISTS favourite_album;
DROP TABLE IF EXISTS music_playlist;
DROP TABLE IF EXISTS album_artist;
DROP TABLE IF EXISTS music_history;
DROP TABLE IF EXISTS music;
DROP TABLE IF EXISTS genre;
DROP TABLE IF EXISTS album_producer;
DROP TABLE IF EXISTS producer;
DROP TABLE IF EXISTS album;
DROP TABLE IF EXISTS studio;
DROP TABLE IF EXISTS favourite_artist;
DROP TABLE IF EXISTS artist;
DROP TABLE IF EXISTS playlist;
DROP TABLE IF EXISTS user;
DROP TABLE IF EXISTS users;
DROP TABLE IF EXISTS country;

CREATE TABLE music (
	music_id INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
	name VARCHAR(50),
	duration TIME,
	year YEAR(4),
	explicit BOOLEAN,
	spotify_url VARCHAR(300),
	youtube_url VARCHAR(300),
	nr_searchs INTEGER UNSIGNED DEFAULT 0,
	country_id INTEGER UNSIGNED,
    genre_id INTEGER UNSIGNED,
    nr_likes INTEGER UNSIGNED DEFAULT 0,
    PRIMARY KEY (music_id)
);

CREATE TABLE genre(
	genre_id INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
    name VARCHAR(30),
    PRIMARY KEY (genre_id)
);

CREATE TABLE country(
    country_id INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
    name VARCHAR(30),
    PRIMARY KEY (country_id)
);

CREATE TABLE producer(
    producer_id INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
    name VARCHAR(30),
    PRIMARY KEY (producer_id)
);

CREATE TABLE album(
    album_id INTEGER UNSIGNED NOT NULL AUTO_INCREMENT, 
    name VARCHAR(100),
    year YEAR(4),
    nr_searchs INTEGER UNSIGNED DEFAULT 0,
    studio_id INTEGER UNSIGNED,
    nr_likes INTEGER UNSIGNED DEFAULT 0,
    PRIMARY KEY (album_id)
);

CREATE TABLE album_producer(
    album_id INTEGER UNSIGNED,
    producer_id INTEGER UNSIGNED
);
ALTER TABLE album_producer ADD CONSTRAINT PK_album_producer PRIMARY KEY (album_id, producer_id);

CREATE TABLE music_album(
    music_id INTEGER UNSIGNED,
    album_id INTEGER UNSIGNED
);
ALTER TABLE music_album ADD CONSTRAINT PK_music_album PRIMARY KEY (music_id, album_id);

CREATE TABLE playlist(
    playlist_id INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
    name VARCHAR(50),
    user_id INTEGER UNSIGNED,
    PRIMARY KEY (playlist_id)
);

CREATE TABLE music_playlist(
    music_id INTEGER UNSIGNED,
    playlist_id INTEGER UNSIGNED
);
ALTER TABLE music_playlist ADD CONSTRAINT PK_music_playlist PRIMARY KEY (music_id, playlist_id);

CREATE TABLE studio(
    studio_id INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
    name VARCHAR(30),
    city VARCHAR(30),
    country_id INTEGER UNSIGNED,
    PRIMARY KEY (studio_id)
);

CREATE TABLE artist(
    artist_id INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
    name VARCHAR(30),
    country_id INTEGER UNSIGNED,
    description VARCHAR(2000),
    nr_searchs INTEGER UNSIGNED DEFAULT 0,
    nr_followers INTEGER UNSIGNED DEFAULT 0,
    PRIMARY KEY (artist_id)
);

CREATE TABLE user(
    user_id INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
    name VARCHAR(30),
    birthdate DATE,
    gender ENUM('M', 'F'),
    country_id INTEGER UNSIGNED,
    email VARCHAR(50) UNIQUE,
    password VARCHAR(30),
    PRIMARY KEY (user_id)
);

CREATE TABLE favourite_music(
    music_id INTEGER UNSIGNED,
    user_id INTEGER UNSIGNED
);
ALTER TABLE favourite_music ADD CONSTRAINT PK_favourite_music PRIMARY KEY (music_id, user_id);

CREATE TABLE favourite_album(
    album_id INTEGER UNSIGNED,
    user_id INTEGER UNSIGNED
);
ALTER TABLE favourite_album ADD CONSTRAINT PK_favourite_album PRIMARY KEY (album_id, user_id);

CREATE TABLE favourite_artist(
    artist_id INTEGER UNSIGNED,
    user_id INTEGER UNSIGNED
);
ALTER TABLE favourite_artist ADD CONSTRAINT PK_favourite_artist PRIMARY KEY (artist_id, user_id);

CREATE TABLE album_artist(
    album_id INTEGER UNSIGNED,
    artist_id INTEGER UNSIGNED
);
ALTER TABLE album_artist ADD CONSTRAINT PK_album_artist PRIMARY KEY (album_id, artist_id);

CREATE TABLE music_history(
    user_id INTEGER UNSIGNED,
    music_id INTEGER UNSIGNED,
    nr_plays INTEGER UNSIGNED DEFAULT 0,
    lastTimePlayed TIMESTAMP
);
ALTER TABLE music_history ADD CONSTRAINT PK_music_history PRIMARY KEY (user_id, music_id);

ALTER TABLE music ADD CONSTRAINT FK_music_country_id FOREIGN KEY (country_id) REFERENCES country(country_id);
ALTER TABLE music ADD CONSTRAINT FK_music_genre_id FOREIGN KEY (genre_id) REFERENCES genre(genre_id);
ALTER TABLE album_producer ADD CONSTRAINT FK_album_producer_album_id FOREIGN KEY (album_id) REFERENCES album(album_id);
ALTER TABLE album_producer ADD CONSTRAINT FK_album_producer_producer_id FOREIGN KEY (producer_id) REFERENCES producer(producer_id);
ALTER TABLE music_album ADD CONSTRAINT FK_music_album_album_id FOREIGN KEY (album_id) REFERENCES album(album_id);
ALTER TABLE music_album ADD CONSTRAINT FK_music_music_album_id FOREIGN KEY (music_id) REFERENCES music(music_id);
ALTER TABLE album ADD CONSTRAINT FK_album_studio_id FOREIGN KEY (studio_id) REFERENCES studio(studio_id);
ALTER TABLE playlist ADD CONSTRAINT FK_playlist_user_id FOREIGN KEY (user_id) REFERENCES user(user_id);
ALTER TABLE music_playlist ADD CONSTRAINT FK_music_playlist_music_id FOREIGN KEY (music_id) REFERENCES music(music_id);
ALTER TABLE music_playlist ADD CONSTRAINT FK_music_playlist_playlist_id FOREIGN KEY (playlist_id) REFERENCES playlist(playlist_id);
ALTER TABLE studio ADD CONSTRAINT FK_studio_country_id FOREIGN KEY (country_id) REFERENCES country(country_id);
ALTER TABLE artist ADD CONSTRAINT FK_artist_country_id FOREIGN KEY (country_id) REFERENCES country(country_id);
ALTER TABLE user ADD CONSTRAINT FK_user_country_id FOREIGN KEY (country_id) REFERENCES country(country_id);
ALTER TABLE favourite_music ADD CONSTRAINT FK_favourite_music_music_id FOREIGN KEY (music_id) REFERENCES music(music_id);
ALTER TABLE favourite_music ADD CONSTRAINT FK_favourite_music_user_id FOREIGN KEY (user_id) REFERENCES user(user_id);
ALTER TABLE favourite_artist ADD CONSTRAINT FK_favourite_artist_artist_id FOREIGN KEY (artist_id) REFERENCES artist(artist_id);
ALTER TABLE favourite_artist ADD CONSTRAINT FK_favourite_artist_user_id FOREIGN KEY (user_id) REFERENCES user(user_id);
ALTER TABLE favourite_album ADD CONSTRAINT FK_favourite_album_album_id FOREIGN KEY (album_id) REFERENCES album(album_id);
ALTER TABLE favourite_album ADD CONSTRAINT FK_favourite_album_user_id FOREIGN KEY (user_id) REFERENCES user(user_id);
ALTER TABLE album_artist ADD CONSTRAINT FK_album_artist_album_id FOREIGN KEY (album_id) REFERENCES album(album_id);
ALTER TABLE album_artist ADD CONSTRAINT FK_album_artist_artist_id FOREIGN KEY (artist_id) REFERENCES artist(artist_id);
ALTER TABLE music_history ADD CONSTRAINT FK_music_history_user_id FOREIGN KEY (user_id) REFERENCES user(user_id);
ALTER TABLE music_history ADD CONSTRAINT FK_music_history_music_id FOREIGN KEY (music_id) REFERENCES music(music_id);