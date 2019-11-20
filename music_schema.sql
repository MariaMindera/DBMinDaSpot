USE mind_da_spot;

DROP TABLE IF EXISTS album_music;
DROP TABLE IF EXISTS favourite_music;
DROP TABLE IF EXISTS playlist_music;
DROP TABLE IF EXISTS album_artist;
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
    PRIMARY KEY (album_id)
);

CREATE TABLE album_producer(
    album_id INTEGER UNSIGNED,
    producer_id INTEGER UNSIGNED
);
ALTER TABLE album_producer ADD CONSTRAINT PK_album_producer PRIMARY KEY (album_id, producer_id);

CREATE TABLE album_music(
    music_id INTEGER UNSIGNED,
    album_id INTEGER UNSIGNED
);
ALTER TABLE album_music ADD CONSTRAINT PK_album_music PRIMARY KEY (music_id, album_id);

CREATE TABLE playlist(
    playlist_id INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
    name VARCHAR(50),
    user_id INTEGER UNSIGNED,
    PRIMARY KEY (playlist_id)
);

CREATE TABLE playlist_music(
    music_id INTEGER UNSIGNED,
    playlist_id INTEGER UNSIGNED
);
ALTER TABLE playlist_music ADD CONSTRAINT PK_playlist_music PRIMARY KEY (music_id, playlist_id);

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
    PRIMARY KEY (artist_id)
);

CREATE TABLE user(
    user_id INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
    name VARCHAR(30),
    birthdate DATE,
    gender ENUM('M', 'F'),
    country_id INTEGER UNSIGNED,
    email VARCHAR(30) UNIQUE,
    password VARCHAR(30),
    PRIMARY KEY (user_id)
);

CREATE TABLE favourite_music(
    music_id INTEGER UNSIGNED,
    user_id INTEGER UNSIGNED
);
ALTER TABLE favourite_music ADD CONSTRAINT PK_favourite_music PRIMARY KEY (music_id, user_id);

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

ALTER TABLE music ADD CONSTRAINT FK_music_country_id FOREIGN KEY (country_id) REFERENCES country(country_id);
ALTER TABLE music ADD CONSTRAINT FK_music_genre_id FOREIGN KEY (genre_id) REFERENCES genre(genre_id);
ALTER TABLE album_producer ADD CONSTRAINT FK_album_producer_album_id FOREIGN KEY (album_id) REFERENCES album(album_id);
ALTER TABLE album_producer ADD CONSTRAINT FK_album_producer_producer_id FOREIGN KEY (producer_id) REFERENCES producer(producer_id);
ALTER TABLE album_music ADD CONSTRAINT FK_album_music_album_id FOREIGN KEY (album_id) REFERENCES album(album_id);
ALTER TABLE album_music ADD CONSTRAINT FK_album_music_music_id FOREIGN KEY (music_id) REFERENCES music(music_id);
ALTER TABLE album ADD CONSTRAINT FK_album_studio_id FOREIGN KEY (studio_id) REFERENCES studio(studio_id);
ALTER TABLE playlist ADD CONSTRAINT FK_playlist_user_id FOREIGN KEY (user_id) REFERENCES user(user_id);
ALTER TABLE playlist_music ADD CONSTRAINT FK_playlist_music_music_id FOREIGN KEY (music_id) REFERENCES music(music_id);
ALTER TABLE playlist_music ADD CONSTRAINT FK_playlist_music_playlist_id FOREIGN KEY (playlist_id) REFERENCES playlist(playlist_id);
ALTER TABLE studio ADD CONSTRAINT FK_studio_country_id FOREIGN KEY (country_id) REFERENCES country(country_id);
ALTER TABLE artist ADD CONSTRAINT FK_artist_country_id FOREIGN KEY (country_id) REFERENCES country(country_id);
ALTER TABLE user ADD CONSTRAINT FK_user_country_id FOREIGN KEY (country_id) REFERENCES country(country_id);
ALTER TABLE favourite_music ADD CONSTRAINT FK_favourite_music_music_id FOREIGN KEY (music_id) REFERENCES music(music_id);
ALTER TABLE favourite_music ADD CONSTRAINT FK_favourite_music_user_id FOREIGN KEY (user_id) REFERENCES user(user_id);
ALTER TABLE favourite_artist ADD CONSTRAINT FK_favourite_artist_artist_id FOREIGN KEY (artist_id) REFERENCES artist(artist_id);
ALTER TABLE favourite_artist ADD CONSTRAINT FK_favourite_artist_user_id FOREIGN KEY (user_id) REFERENCES user(user_id);
ALTER TABLE album_artist ADD CONSTRAINT FK_album_artist_album_id FOREIGN KEY (album_id) REFERENCES album(album_id);
ALTER TABLE album_artist ADD CONSTRAINT FK_album_artist_artist_id FOREIGN KEY (artist_id) REFERENCES artist(artist_id);