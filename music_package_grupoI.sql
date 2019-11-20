-- CRUD Music 
DROP PROCEDURE IF EXISTS add_music;
CREATE PROCEDURE add_music (IN name_in VARCHAR(50), IN duration_in TIME, IN year_in YEAR(4), IN explicit_in BOOLEAN, IN spotify_url_in VARCHAR(300), IN youtube_url_in VARCHAR(300), IN country_id_in INTEGER, IN genre_id_in INTEGER)
BEGIN
	INSERT INTO music (name, duration, `year`, explicit, spotify_url, youtube_url, country_id, genre_id)
		VALUES(name_in, duration_in, year_in, explicit_in, spotify_url_in, youtube_url_in, country_id_in, genre_id_in);
END;

DROP PROCEDURE IF EXISTS get_music_by_id;
CREATE PROCEDURE get_music_by_id (IN music_id_in INTEGER)
BEGIN
	SELECT
		name, duration, `year`, explicit, spotify_url, youtube_url, country_id, genre_id
	FROM
		music
	WHERE
		music_id = music_id_in;
END;

DROP PROCEDURE IF EXISTS get_all_musics;
CREATE PROCEDURE get_all_musics ()
BEGIN
	SELECT
		name, duration, `year`, explicit, spotify_url, youtube_url, country_id, genre_id
	FROM
		music;
END;

DROP PROCEDURE IF EXISTS update_music;
CREATE PROCEDURE update_music (IN music_id_in INTEGER, IN name_music VARCHAR(50), IN duration_music TIME, IN year_music YEAR(4), IN explicit_music BOOLEAN, IN spotify_url_music VARCHAR(300), IN youtube_url_music VARCHAR(300), IN country_id_music INTEGER, IN genre_id_music INTEGER)
BEGIN
	UPDATE
		music SET
			name = name_music, duration = duration_music, `year` = year_music, explicit = explicit_music, spotify_url = spotify_url_music, youtube_url = youtube_url_music, country_id = country_id_music, genre_id = genre_id_music
		WHERE
			music_id = music_id_in;
END;

DROP PROCEDURE IF EXISTS delete_music_by_id;
CREATE PROCEDURE delete_music_by_id (IN music_id_in INTEGER)
BEGIN
	DELETE FROM music
	WHERE music_id = music_id_in;
END;

DROP PROCEDURE IF EXISTS delete_music_album_music_by_music_id;
CREATE PROCEDURE delete_music_album_music_by_music_id (IN music_id_in INTEGER)
BEGIN
	DELETE FROM album_music
	WHERE music_id = music_id_in;
END;

DROP PROCEDURE IF EXISTS delete_music_favourite_music_by_music_id;
CREATE PROCEDURE delete_music_favourite_music_by_music_id (IN music_id_in INTEGER)
BEGIN
	DELETE FROM favourite_music
	WHERE music_id = music_id_in;
END;

DROP PROCEDURE IF EXISTS delete_music_playlist_music_by_music_id;
CREATE PROCEDURE delete_music_playlist_music_by_music_id (IN music_id_in INTEGER)
BEGIN
	DELETE FROM playlist_music
	WHERE music_id = music_id_in;
END;

DROP PROCEDURE IF EXISTS delete_music;
CREATE PROCEDURE delete_music (IN music_id_in INTEGER)
BEGIN
	CALL delete_music_album_music_by_music_id(music_id_in);
	CALL delete_music_favourite_music_by_music_id(music_id_in);
	CALL delete_music_playlist_music_by_music_id(music_id_in);
	CALL delete_music_by_id(music_id_in);
END;


-- CRUD User
DROP PROCEDURE IF EXISTS add_user;
CREATE PROCEDURE add_user (IN name VARCHAR(30), IN birthdate DATE, IN gender ENUM ('M', 'F'), IN country_id INTEGER, IN email VARCHAR(30), IN PASSWORD VARCHAR(30))
BEGIN
	INSERT INTO user(name, birthdate, gender, country_id, email, PASSWORD)
			VALUES(name, birthdate, gender, country_id, email, PASSWORD);
END;

DROP PROCEDURE IF EXISTS get_user_by_id;
CREATE PROCEDURE get_user_by_id (IN user_id_in INTEGER)
BEGIN
	SELECT
		name, birthdate, gender, country_id, email
	FROM
		USER
	WHERE
		user_id = user_id_in;
END;

DROP PROCEDURE IF EXISTS get_all_users;
CREATE PROCEDURE get_all_users ()
BEGIN
	SELECT
		name, birthdate, gender, country_id, email
	FROM
		USER;
END;

DROP PROCEDURE IF EXISTS update_user;
CREATE PROCEDURE update_user (IN user_id_in INTEGER, IN name_user VARCHAR(30), IN birthdate_user DATE, IN gender_music ENUM ('M', 'F'), IN country_id_user INTEGER, IN email_user VARCHAR(30), IN password_user VARCHAR(30))
BEGIN
	UPDATE
		USER SET
			name = name_user, birthdate = birthdate_user, gender = gender_music, country_id = country_id_user, email = email_user, PASSWORD = password_user
		WHERE
			user_id = user_id_in;
END;

DROP PROCEDURE IF EXISTS delete_favourite_artist_by_user_id;
CREATE PROCEDURE delete_favourite_artist_by_user_id (IN user_id_in INTEGER)
BEGIN
	DELETE FROM favourite_artist
	WHERE user_id = user_id_in;
END;

DROP PROCEDURE IF EXISTS delete_favourite_music_by_user_id;
CREATE PROCEDURE delete_favourite_music_by_user_id (IN user_id_in INTEGER)
BEGIN
	DELETE FROM favourite_music
	WHERE user_id = user_id_in;
END;

DROP PROCEDURE IF EXISTS delete_user_by_id;
CREATE PROCEDURE delete_user_by_id (IN user_id_in INTEGER)
BEGIN
	DELETE FROM USER
	WHERE user_id = user_id_in;
END;

DROP PROCEDURE IF EXISTS delete_user;
CREATE PROCEDURE delete_user (IN user_id_in INTEGER)
BEGIN
	CALL delete_favourite_artist (user_id_in);
	CALL delete_favourite_music (user_id_in);
	CALL delete_user_by_id (user_id_in);
END;


-- CRUD Playlist
DROP PROCEDURE IF EXISTS add_Playlist;
CREATE PROCEDURE add_Playlist (IN name VARCHAR(50), IN user_id INTEGER)
BEGIN
	INSERT INTO playlist (name, user_id)
		VALUES(name, user_id);
END;

DROP PROCEDURE IF EXISTS get_all_playlist;
CREATE PROCEDURE get_all_playlist ()
BEGIN
	SELECT
		name
	FROM
		playlist;
END;

DROP PROCEDURE IF EXISTS get_Playlist_by_id;
CREATE PROCEDURE get_Playlist_by_id (IN playlist_id_in INTEGER)
BEGIN
	SELECT
		name
	FROM
		playlist
	WHERE
		playlist_id = playlist_id_in;
END;

DROP PROCEDURE IF EXISTS update_Playlist;
CREATE PROCEDURE update_Playlist (IN playlist_id_in int, IN update_playlist_name VARCHAR(50))
BEGIN
	UPDATE
		playlist SET
			name = update_playlist_name
		WHERE
			playlist_id = playlist_id_in;
END;

DROP PROCEDURE IF EXISTS delete_playlist_by_id;
CREATE PROCEDURE delete_playlist_by_id (IN playlist_id_in INTEGER)
BEGIN
	DELETE FROM playlist
	WHERE playlist_id = playlist_id_in;
END;

DROP PROCEDURE IF EXISTS delete_playlist_music_by_playlist_id;
CREATE PROCEDURE delete_playlist_music_by_playlist_id (IN playlist_id_in INTEGER)
BEGIN
	DELETE FROM playlist_music
	WHERE playlist_id = playlist_id_in;
END;

DROP PROCEDURE IF EXISTS delete_playlist;
CREATE PROCEDURE delete_playlist (IN playlist_id_in INTEGER)
BEGIN
	CALL delete_playlist_music_by_playlist_id (playlist_id_in);
	CALL delete_playlist_by_id (playlist_id_in);
END;


-- CRUD Artist
DROP PROCEDURE IF EXISTS add_artist;
CREATE PROCEDURE add_artist (IN name VARCHAR(50), IN country_id INTEGER, IN description VARCHAR(2000))
BEGIN
	INSERT INTO artist (name, country_id, description)
		VALUES(name, country_id, description);
END;

DROP PROCEDURE IF EXISTS get_all_artist;
CREATE PROCEDURE get_all_artist ()
BEGIN
	SELECT
		name, country_id, description
	FROM
		artist;
END;

DROP PROCEDURE IF EXISTS get_artist_by_id;
CREATE PROCEDURE get_artist_by_id (IN artist_id_in INTEGER)
BEGIN
	SELECT
		name, country_id, description
	FROM
		artist
	WHERE
		artist_id = artist_id_in;
END;

DROP PROCEDURE IF EXISTS update_artist;
CREATE PROCEDURE update_artist (IN artist_id_in int, IN artist_name VARCHAR(50), IN artist_country INTEGER, IN artist_description VARCHAR(2000))
BEGIN
	UPDATE
		artist SET
			name = artist_name, country_id = artist_country, description = artist_description
		WHERE
			artist_id = artist_id_in;
END;

DROP PROCEDURE IF EXISTS delete_artist_by_id;
CREATE PROCEDURE delete_artist_by_id (IN artist_id_in INTEGER)
BEGIN
	DELETE FROM artist
	WHERE artist_id = artist_id_in;
END;

DROP PROCEDURE IF EXISTS delete_artist_album_artist_by_artist_id;
CREATE PROCEDURE delete_artist_album_artist_by_artist_id (IN artist_id_in INTEGER)
BEGIN
	DELETE FROM album_artist
	WHERE artist_id = artist_id_in;
END;

DROP PROCEDURE IF EXISTS delete_artist_favourite_artist_by_artist_id;
CREATE PROCEDURE delete_artist_favourite_artist_by_artist_id (IN artist_id_in INTEGER)
BEGIN
	DELETE FROM favourite_artist
	WHERE artist_id = artist_id_in;
END;

DROP PROCEDURE IF EXISTS delete_artist;
CREATE PROCEDURE delete_artist (IN id INTEGER)
BEGIN
	CALL delete_artist_album_artist_by_artist_id (id);
	CALL delete_artist_favourite_artist_by_artist_id (id);
	CALL delete_artist_by_id (id);
END;


-- CRUD Album
DROP PROCEDURE IF EXISTS add_album;
CREATE PROCEDURE add_album (IN name_in VARCHAR(50), IN year_in YEAR(4), IN studio_id_in INTEGER)
BEGIN
	INSERT INTO album (name, `year`, studio_id)
		VALUES(name_in, year_in, studio_id_in);
END;

DROP PROCEDURE IF EXISTS get_album;
CREATE PROCEDURE get_album (IN album_id_in INTEGER)
BEGIN
	SELECT
		name, `year`, studio_id
	FROM
		album
	WHERE
		album_id = album_id_in;
END;

DROP PROCEDURE IF EXISTS get_all_albums;
CREATE PROCEDURE get_all_albums ()
BEGIN
	SELECT
		name, `year`, studio_id
	FROM
		album;
END;

DROP PROCEDURE IF EXISTS update_album;
CREATE PROCEDURE update_album (IN album_id_in INTEGER, IN name_in VARCHAR(100), IN year_in YEAR(4), IN studio_id_in INTEGER)
BEGIN
	UPDATE
		album SET
			name = name_in, `year` = year_in, studio_id = studio_id_in
		WHERE
			album_id = album_id_in;
END;

DROP PROCEDURE IF EXISTS delete_album_from_album;
CREATE PROCEDURE delete_album_from_album (IN album_id_in INTEGER)
BEGIN
	DELETE FROM album
	WHERE album_id = album_id_in;
END;

DROP PROCEDURE IF EXISTS delete_album_from_album_music;
CREATE PROCEDURE delete_album_from_album_music (IN album_id_in INTEGER)
BEGIN
	DELETE FROM album_music
	WHERE album_id = album_id_in;
END;

DROP PROCEDURE IF EXISTS delete_album_from_album_producer;
CREATE PROCEDURE delete_album_from_album_producer (IN album_id_in INTEGER)
BEGIN
	DELETE FROM album_producer
	WHERE album_id = album_id_in;
END;

DROP PROCEDURE IF EXISTS delete_album;
CREATE PROCEDURE delete_album (IN album_id_in INTEGER)
BEGIN
	CALL delete_album_from_album_producer (album_id_in);
	CALL delete_album_from_album_music (album_id_in);
	CALL delete_album_from_album (album_id_in);
END;


-- CRUD Genre
DROP PROCEDURE IF EXISTS add_genre;
CREATE PROCEDURE add_genre (IN name_in VARCHAR(30))
BEGIN
	INSERT INTO genre (name)
		VALUES(name_in);
END;

DROP PROCEDURE IF EXISTS get_genre;
CREATE PROCEDURE get_genre (IN genre_id_in INTEGER)
BEGIN
	SELECT
		name
	FROM
		genre
	WHERE
		genre_id = genre_id_in;
END;

DROP PROCEDURE IF EXISTS get_all_genre;
CREATE PROCEDURE get_all_genre (IN genre_id_in INTEGER)
BEGIN
	SELECT
		name
	FROM
		genre;
END;

DROP PROCEDURE IF EXISTS update_genre;
CREATE PROCEDURE update_genre (IN genre_id_in INTEGER, IN name_in VARCHAR(30))
BEGIN
	UPDATE
		genre SET
			name = name_in
		WHERE
			genre_id = genre_id_in;
END;

DROP PROCEDURE IF EXISTS delete_from_genre;
CREATE PROCEDURE delete_from_genre (IN genre_id_in INTEGER)
BEGIN
	DELETE FROM genre
	WHERE genre_id = genre_id_in;
END;

DROP PROCEDURE IF EXISTS delete_from_music_genre_id;
CREATE PROCEDURE delete_from_music_genre_id (IN genre_id_in INTEGER)
BEGIN
	DELETE FROM music
	WHERE genre_id = genre_id_in;
END;

DROP PROCEDURE IF EXISTS delete_genre_from_album_music;
CREATE PROCEDURE delete_genre_from_album_music (IN genre_id_in INTEGER)
BEGIN
	DELETE FROM album_music
	WHERE genre_id = genre_id_in;
END;

DROP PROCEDURE IF EXISTS delete_genre;
CREATE PROCEDURE delete_genre (IN genre_id_in INTEGER)
BEGIN
	CALL delete_genre_from_album_music (genre_id_in);
	CALL delete_from_music_genre_id (genre_id_in);
	CALL delete_from_genre (genre_id_in);
END;


-- CRUD Favourites
DROP PROCEDURE IF EXISTS add_favourit_music;
CREATE PROCEDURE add_favourit_music (IN user_id_in INTEGER, IN music_id_in INTEGER)
BEGIN
	INSERT INTO favourite_music (user_id, music_id)
		VALUES(user_id_in, music_id_in);
END;

DROP PROCEDURE IF EXISTS add_favourit_artist;
CREATE PROCEDURE add_favourit_artist (IN user_id_in INTEGER, IN artist_id_in INTEGER)
BEGIN
	INSERT INTO favourite_artist (user_id, artist_id)
		VALUES(user_id_in, artist_id_in);
END;

DROP PROCEDURE IF EXISTS delete_favourit_artist;
CREATE PROCEDURE delete_favourite_artist ()
BEGIN

END;


-- Add/Remove music from playlist
DROP PROCEDURE IF EXISTS add_music_to_playlist;
CREATE PROCEDURE add_music_to_playlist (IN playlist_id_in INT, IN music_id_in INT)
BEGIN
	INSERT INTO playlist_music (playlist_id, music_id)
		VALUES(playlist_id_in, music_id_in);
END;

DROP PROCEDURE IF EXISTS remove_music_from_playlist;
CREATE PROCEDURE remove_music_from_playlist (IN playlist_id_in INT, IN music_id_in INT)
BEGIN
	UPDATE
		playlist_music SET
			music_id = music_id_in
		WHERE
			playlist_id = playlist_id_in;
END;


-- Artist profile - Profile of all the songs and albums of the selected artist
DROP PROCEDURE IF EXISTS get_all_songs_from_artist;
CREATE PROCEDURE get_all_songs_from_artist (IN artist_id_in INT)
BEGIN
	SELECT
		music.name, music.duration, music.year, music.explicit, music.spotify_url, music.youtube_url, music.country_id, music.genre_id
	FROM
		music
		INNER JOIN artist_music ON music.music_id = artist_music.music_id
	WHERE
		artist_music.artist_id = artist_id_in;
END;

DROP PROCEDURE IF EXISTS get_all_albums_from_artist;
CREATE PROCEDURE get_all_albums_from_artist (IN artist_id_in INT)
BEGIN
	SELECT
		name, `year`, studio_id
	FROM
		album
	WHERE
		album_id = ( SELECT DISTINCT
			album_id
		FROM
			album_music
			INNER JOIN artist_music ON album_music.music_id = artist_music.artist_id
		WHERE
			artist_music.artist_id = 1);
END;


--Filter playlists - Do playlists with filters (country, genre and artists)



-- Top Chart
DROP PROCEDURE IF EXISTS top_50;
CREATE PROCEDURE top_50 ()
BEGIN
	SELECT
		*
	FROM
		music
	ORDER BY
		nr_searchs DESC
	LIMIT 50;
END;