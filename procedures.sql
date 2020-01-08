-- Age restriction	Explicit songs 
DROP FUNCTION IF EXISTS age_by_user_id;

CREATE FUNCTION age_by_user_id (user_id_in INT)
	RETURNS INT DETERMINISTIC
BEGIN
DECLARE
	age INT;
	SET age = (
	SELECT
		timestampdiff(YEAR, birthdate, curdate())
		FROM
			USER
		WHERE
			user_id = user_id_in);
	RETURN age;
END;

-- CRUD Album
DROP PROCEDURE IF EXISTS add_album;

CREATE PROCEDURE add_album (IN name_in VARCHAR(50), IN year_in YEAR(4), IN studio_id_in INTEGER)
BEGIN
	INSERT INTO album (name, `year`, studio_id)
		VALUES(name_in, year_in, studio_id_in);
END;

DROP PROCEDURE IF EXISTS get_album_by_id;

CREATE PROCEDURE get_album_by_id (IN album_id_in INTEGER)
BEGIN
	SELECT
		*
	FROM
		album
	WHERE
		album_id = album_id_in;
END;

DROP PROCEDURE IF EXISTS get_all_album;

CREATE PROCEDURE get_all_album ()
BEGIN
	SELECT
		*
	FROM
		album
	ORDER BY
		nr_likes DESC;
END;

DROP PROCEDURE IF EXISTS get_album_id_by_name;

CREATE PROCEDURE get_album_id_by_name (IN name_album VARCHAR(50))
BEGIN
	SELECT
		album_id
	FROM
		album
	WHERE
		name = name_album;
END;

DROP PROCEDURE IF EXISTS get_all_albums_from_artist;

CREATE PROCEDURE get_all_albums_from_artist (IN artist_id_in INTEGER)
BEGIN
	SELECT
		*
	FROM
		album
	WHERE
		album_id in(
		SELECT
			album_id FROM album_artist
		WHERE
			artist_id = artist_id_in)
		ORDER BY
			nr_likes DESC;
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

DROP PROCEDURE IF EXISTS delete_album_by_id;

CREATE PROCEDURE delete_album_by_id (IN album_id_in INTEGER)
BEGIN
	DELETE FROM album
	WHERE album_id = album_id_in;
END;

DROP PROCEDURE IF EXISTS delete_music_album_album_by_album_id;

CREATE PROCEDURE delete_music_album_album_by_album_id (IN album_id_in INTEGER)
BEGIN
	DELETE FROM music_album
	WHERE album_id = album_id_in;
END;

DROP PROCEDURE IF EXISTS delete_album_album_producer_by_album_id;

CREATE PROCEDURE delete_album_album_producer_by_album_id (IN album_id_in INTEGER)
BEGIN
	DELETE FROM album_producer
	WHERE album_id = album_id_in;
END;

DROP PROCEDURE IF EXISTS delete_album_album_artist_by_album_id;

CREATE PROCEDURE delete_album_album_artist_by_album_id (IN album_id_in INTEGER)
BEGIN
	DELETE FROM album_artist
	WHERE album_id = album_id_in;
END;

DROP PROCEDURE IF EXISTS delete_album;

CREATE PROCEDURE delete_album (IN album_id_in INTEGER)
BEGIN
	CALL delete_album_album_artist_by_album_id (album_id_in);
	CALL delete_music_album_album_by_album_id (album_id_in);
	CALL delete_album_album_producer_by_album_id (album_id_in);
	CALL delete_album_by_id (album_id_in);
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
		*
	FROM
		artist
	ORDER BY
		nr_followers DESC;
END;

DROP PROCEDURE IF EXISTS get_artist_by_id;

CREATE PROCEDURE get_artist_by_id (IN artist_id_in INTEGER)
BEGIN
	SELECT
		*
	FROM
		artist
	WHERE
		artist_id = artist_id_in;
END;

DROP PROCEDURE IF EXISTS get_artist_id_by_name;

CREATE PROCEDURE get_artist_id_by_name (IN name_artist VARCHAR(50))
BEGIN
	SELECT
		artist_id
	FROM
		artist
	WHERE
		name = name_artist;
END;

DROP PROCEDURE IF EXISTS update_artist;

CREATE PROCEDURE update_artist (IN artist_id_in INTEGER, IN artist_name VARCHAR(50), IN artist_country INTEGER, IN artist_description VARCHAR(2000))
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

-- CRUD Country
DROP PROCEDURE IF EXISTS add_country;

CREATE PROCEDURE add_country (IN name_in VARCHAR(30))
BEGIN
	INSERT INTO country (name)
		VALUES(name_in);
END;

DROP PROCEDURE IF EXISTS get_country_by_id;

CREATE PROCEDURE get_country_by_id (IN country_id_in INTEGER)
BEGIN
	SELECT
		*
	FROM
		country
	WHERE
		country_id = country_id_in;
END;

DROP PROCEDURE IF EXISTS get_country_id_by_name;

CREATE PROCEDURE get_country_id_by_name (IN name_country VARCHAR(50))
BEGIN
	SELECT
		country_id
	FROM
		country
	WHERE
		name = name_country;
END;

DROP PROCEDURE IF EXISTS get_all_country;

CREATE PROCEDURE get_all_country ()
BEGIN
	SELECT
		*
	FROM
		country;
END;

DROP PROCEDURE IF EXISTS update_country;

CREATE PROCEDURE update_country (IN country_id_in INTEGER, IN update_country_name VARCHAR(30))
BEGIN
	UPDATE
		country SET
			name = update_country_name
		WHERE
			country_id = country_id_in;
END;

DROP PROCEDURE IF EXISTS delete_country_by_id;

CREATE PROCEDURE delete_country_by_id (IN country_id_in INTEGER)
BEGIN
	DELETE FROM country
	WHERE country_id = country_id_in;
END;

DROP PROCEDURE IF EXISTS delete_country_artist_by_id;

CREATE PROCEDURE delete_country_artist_by_id (IN country_id_in INTEGER)
BEGIN
	DELETE FROM artist
	WHERE country_id = country_id_in;
END;

DROP PROCEDURE IF EXISTS delete_country_studio_by_id;

CREATE PROCEDURE delete_country_studio_by_id (IN country_id_in INTEGER)
BEGIN
	DELETE FROM studio
	WHERE country_id = country_id_in;
END;

DROP PROCEDURE IF EXISTS delete_country_music_by_id;

CREATE PROCEDURE delete_country_music_by_id (IN country_id_in INTEGER)
BEGIN
	DELETE FROM music
	WHERE country_id = country_id_in;
END;

DROP PROCEDURE IF EXISTS delete_music_album_country_by_id;

CREATE PROCEDURE delete_music_album_country_by_id (IN country_id_in INTEGER)
BEGIN
	DELETE FROM music_album
	WHERE music_id IN(
		SELECT
			music_id FROM music
		WHERE
			country_id = country_id_in);
END;

DROP PROCEDURE IF EXISTS delete_album_studio_country_by_id;

CREATE PROCEDURE delete_album_studio_country_by_id (IN country_id_in INTEGER)
BEGIN
	DELETE FROM album
	WHERE studio_id IN(
		SELECT
			studio_id FROM studio
		WHERE
			country_id = country_id_in);
END;

DROP PROCEDURE IF EXISTS delete_favourite_music_country_by_id;

CREATE PROCEDURE delete_favourite_music_country_by_id (IN country_id_in INTEGER)
BEGIN
	DELETE FROM favourite_music
	WHERE music_id IN(
		SELECT
			music_id FROM music
		WHERE
			country_id = country_id_in);
END;

DROP PROCEDURE IF EXISTS delete_music_playlist_country_by_id;

CREATE PROCEDURE delete_music_playlist_country_by_id (IN country_id_in INTEGER)
BEGIN
	DELETE FROM music_playlist
	WHERE music_id IN(
		SELECT
			music_id FROM music
		WHERE
			country_id = country_id_in);
END;

DROP PROCEDURE IF EXISTS delete_album_producer_country_by_id;

CREATE PROCEDURE delete_album_producer_country_by_id (IN country_id_in INTEGER)
BEGIN
	DELETE FROM album_producer
	WHERE album_id IN(
		SELECT
			album.album_id FROM album
			INNER JOIN studio ON album.studio_id = studio.studio_id
		WHERE
			studio.country_id = country_id_in);
END;

DROP PROCEDURE IF EXISTS delete_country;

CREATE PROCEDURE delete_country (IN country_id_in INTEGER)
BEGIN
	CALL delete_album_producer_country_by_id (country_id_in);
	CALL delete_album_studio_country_by_id (country_id_in);
	CALL delete_country_studio_by_id (country_id_in);
	CALL delete_music_playlist_country_by_id (country_id_in);
	CALL delete_favourite_music_country_by_id (country_id_in);
	CALL delete_music_album_country_by_id (country_id_in);
	CALL delete_country_music_by_id (country_id_in);
	CALL delete_country_artist_by_id (country_id_in);
	CALL delete_country_by_id (country_id_in);
END;

-- CRUD Genre
DROP PROCEDURE IF EXISTS add_genre;

CREATE PROCEDURE add_genre (IN name_in VARCHAR(30))
BEGIN
	INSERT INTO genre (name)
		VALUES(name_in);
END;

DROP PROCEDURE IF EXISTS get_genre_by_id;

CREATE PROCEDURE get_genre_by_id (IN genre_id_in INTEGER)
BEGIN
	SELECT
		*
	FROM
		genre
	WHERE
		genre_id = genre_id_in;
END;

DROP PROCEDURE IF EXISTS get_all_genre;

CREATE PROCEDURE get_all_genre ()
BEGIN
	SELECT
		*
	FROM
		genre;
END;

DROP PROCEDURE IF EXISTS get_genre_id_by_name;

CREATE PROCEDURE get_genre_id_by_name (IN name_genre VARCHAR(50))
BEGIN
	SELECT
		genre_id
	FROM
		genre
	WHERE
		name = name_genre;
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

DROP PROCEDURE IF EXISTS delete_genre_by_id;

CREATE PROCEDURE delete_genre_by_id (IN genre_id_in INTEGER)
BEGIN
	DELETE FROM genre
	WHERE genre_id = genre_id_in;
END;

DROP PROCEDURE IF EXISTS delete_music_by_genre_id;

CREATE PROCEDURE delete_music_by_genre_id (IN genre_id_in INTEGER)
BEGIN
	DELETE FROM music
	WHERE genre_id = genre_id_in;
END;

DROP PROCEDURE IF EXISTS delete_favourite_music_playlist_by_genre_id;

CREATE PROCEDURE delete_favourite_music_playlist_by_genre_id (IN genre_id_in INTEGER)
BEGIN
	DELETE FROM favourite_music
	WHERE music_id In(
		SELECT
			music_id FROM music
		WHERE
			genre_id = genre_id_in);
	DELETE FROM music_playlist
	WHERE music_id In(
			SELECT
				music_id FROM music
			WHERE
				genre_id = genre_id_in);
END;

DROP PROCEDURE IF EXISTS delete_music_album_by_genre_id;

CREATE PROCEDURE delete_music_album_by_genre_id (IN genre_id_in INTEGER)
BEGIN
	DELETE FROM music_album
	WHERE music_id In(
		SELECT
			music_id FROM music
		WHERE
			genre_id = genre_id_in);
END;

DROP PROCEDURE IF EXISTS delete_genre;

CREATE PROCEDURE delete_genre (IN genre_id_in INTEGER)
BEGIN
	CALL delete_music_album_by_genre_id (genre_id_in);
	CALL delete_favourite_music_playlist_by_genre_id (genre_id_in);
	CALL delete_music_by_genre_id (genre_id_in);
	CALL delete_genre_by_id (genre_id_in);
END;

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
		*
	FROM
		music
	WHERE
		music_id = music_id_in;
END;

DROP PROCEDURE IF EXISTS get_music_id_by_name;

CREATE PROCEDURE get_music_id_by_name (IN name_music VARCHAR(50))
BEGIN
	SELECT
		music_id
	FROM
		music
	WHERE
		name = name_music;
END;

DROP PROCEDURE IF EXISTS get_all_music;

CREATE PROCEDURE get_all_music ()
BEGIN
	SELECT
		*
	FROM
		music
	ORDER BY
		nr_likes DESC;
END;

DROP PROCEDURE IF EXISTS get_music_from_playlist_by_playlist_id;

CREATE PROCEDURE get_music_from_playlist_by_playlist_id (IN playlist_id_in INTEGER)
BEGIN
	SELECT
		music_id
	FROM
		music_playlist
	WHERE
		playlist_id = playlist_id_in;
END;

DROP PROCEDURE IF EXISTS get_all_musics_from_artist;

CREATE PROCEDURE get_all_musics_from_artist (IN artist_id_in INTEGER)
BEGIN
	SELECT
		*
	FROM
		music
	WHERE
		music_id in(
		SELECT
			music_album.music_id FROM music_album
			INNER JOIN album_artist ON music_album.album_id = album_artist.album_id
		WHERE
			album_artist.artist_id = artist_id_in)
		ORDER BY
			nr_likes DESC;
END;

DROP PROCEDURE IF EXISTS get_music_from_album_by_album_id;

CREATE PROCEDURE get_music_from_album_by_album_id (IN album_id_in INTEGER)
BEGIN
	SELECT
		music_id
	FROM
		music_album
	WHERE
		album_id = album_id_in;
END;

DROP PROCEDURE IF EXISTS get_musics_by_genre;

CREATE PROCEDURE get_musics_by_genre (IN genre_id_in INTEGER)
BEGIN
	SELECT
		*
	FROM
		music
	WHERE
		genre_id = genre_id_in;
END;

DROP PROCEDURE IF EXISTS get_musics_by_country;

CREATE PROCEDURE get_musics_by_country (IN country_id_in INTEGER)
BEGIN
	SELECT
		*
	FROM
		music
	WHERE
		country_id = country_id_in;
END;

DROP PROCEDURE IF EXISTS get_no_explicit_musics;

CREATE PROCEDURE get_no_explicit_musics ()
BEGIN
	SELECT
		*
	FROM
		music
	WHERE
		explicit = 0;
END;

DROP PROCEDURE IF EXISTS explicit_songs_by_user_id;

CREATE PROCEDURE explicit_songs_by_user_id (IN user_id_in INTEGER)
BEGIN
	IF(
		SELECT
			age_by_user_id (user_id_in)) > 17 THEN
		CALL get_all_music ();
	ELSE
		CALL get_no_explicit_musics ();
	END IF;
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
END;

DROP PROCEDURE IF EXISTS delete_music_music_album_by_music_id;

CREATE PROCEDURE delete_music_music_album_by_music_id (IN music_id_in INTEGER)
BEGIN
	DELETE FROM music_album
	WHERE music_id = music_id_in;
END;

DROP PROCEDURE IF EXISTS delete_music_favourite_music_by_music_id;

CREATE PROCEDURE delete_music_favourite_music_by_music_id (IN music_id_in INTEGER)
BEGIN
	DELETE FROM favourite_music
	WHERE music_id = music_id_in;
END;

DROP PROCEDURE IF EXISTS delete_music_music_playlist_by_music_id;

CREATE PROCEDURE delete_music_music_playlist_by_music_id (IN music_id_in INTEGER)
BEGIN
	DELETE FROM music_playlist
	WHERE music_id = music_id_in;
END;

DROP PROCEDURE IF EXISTS delete_music;

CREATE PROCEDURE delete_music (IN music_id_in INTEGER)
BEGIN
	CALL delete_music_music_album_by_music_id (music_id_in);
	CALL delete_music_favourite_music_by_music_id (music_id_in);
	CALL delete_music_music_playlist_by_music_id (music_id_in);
	CALL delete_music_by_id (music_id_in);
END;

-- CRUD Playlist
DROP PROCEDURE IF EXISTS add_playlist;

CREATE PROCEDURE add_playlist (IN name VARCHAR(50), IN user_id INTEGER)
BEGIN
	INSERT INTO playlist (name, user_id)
		VALUES(name, user_id);
END;

DROP PROCEDURE IF EXISTS get_all_playlist_by_user;

CREATE PROCEDURE get_all_playlist_by_user (IN user_id_in INTEGER)
BEGIN
	SELECT
		*
	FROM
		playlist
	WHERE
		user_id = user_id_in;
END;

DROP PROCEDURE IF EXISTS get_playlist_by_id;

CREATE PROCEDURE get_playlist_by_id (IN playlist_id_in INTEGER)
BEGIN
	SELECT
		*
	FROM
		playlist
	WHERE
		playlist_id = playlist_id_in;
END;

DROP PROCEDURE IF EXISTS get_all_playlist;

CREATE PROCEDURE get_all_playlist ()
BEGIN
	SELECT
		*
	FROM
		playlist;
END;

DROP PROCEDURE IF EXISTS get_playlist_by_id_by_user;

CREATE PROCEDURE get_playlist_by_id_by_user (IN playlist_id_in INTEGER, IN user_id_in INTEGER)
BEGIN
	SELECT
		*
	FROM
		playlist
	WHERE
		playlist_id = playlist_id_in AND user_id = user_id_in;
END;

DROP PROCEDURE IF EXISTS get_playlist_id_by_name;

CREATE PROCEDURE get_playlist_id_by_name (IN name_playlist VARCHAR(50))
BEGIN
	SELECT
		playlist_id
	FROM
		playlist
	WHERE
		name = name_playlist;
END;

DROP PROCEDURE IF EXISTS get_playlist_id_by_name_by_user;

CREATE PROCEDURE get_playlist_id_by_name_by_user (IN name_playlist VARCHAR(50), IN user_id_in INTEGER)
BEGIN
	SELECT
		playlist_id
	FROM
		playlist
	WHERE
		name = name_playlist AND user_id = user_id_in;
END;

DROP PROCEDURE IF EXISTS update_playlist;

CREATE PROCEDURE update_playlist (IN playlist_id_in INTEGER, IN update_playlist_name VARCHAR(50))
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

DROP PROCEDURE IF EXISTS delete_music_playlist_by_playlist_id;

CREATE PROCEDURE delete_music_playlist_by_playlist_id (IN playlist_id_in INTEGER)
BEGIN
	DELETE FROM music_playlist
	WHERE playlist_id = playlist_id_in;
END;

DROP PROCEDURE IF EXISTS delete_playlist;

CREATE PROCEDURE delete_playlist (IN playlist_id_in INTEGER)
BEGIN
	CALL delete_music_playlist_by_playlist_id (playlist_id_in);
	CALL delete_playlist_by_id (playlist_id_in);
END;

-- CRUD Producer
DROP PROCEDURE IF EXISTS add_producer;

CREATE PROCEDURE add_producer (IN name_in VARCHAR(30))
BEGIN
	INSERT INTO producer (name)
		VALUES(name_in);
END;

DROP PROCEDURE IF EXISTS get_producer_by_id;

CREATE PROCEDURE get_producer_by_id (IN producer_id_in INTEGER)
BEGIN
	SELECT
		*
	FROM
		producer
	WHERE
		producer_id = producer_id_in;
END;

DROP PROCEDURE IF EXISTS get_producer_id_by_name;

CREATE PROCEDURE get_producer_id_by_name (IN name_producer VARCHAR(50))
BEGIN
	SELECT
		producer_id
	FROM
		producer
	WHERE
		name = name_producer;
END;

DROP PROCEDURE IF EXISTS get_all_producer;

CREATE PROCEDURE get_all_producer ()
BEGIN
	SELECT
		*
	FROM
		producer;
END;

DROP PROCEDURE IF EXISTS update_producer;

CREATE PROCEDURE update_producer (IN producer_id_in INTEGER, IN update_producer_name VARCHAR(30))
BEGIN
	UPDATE
		producer SET
			name = update_producer_name
		WHERE
			producer_id = producer_id_in;
END;

DROP PROCEDURE IF EXISTS delete_producer_by_id;

CREATE PROCEDURE delete_producer_by_id (IN producer_id_in INTEGER)
BEGIN
	DELETE FROM producer
	WHERE producer_id = producer_id_in;
END;

DROP PROCEDURE IF EXISTS delete_album_producer_producer_id;

CREATE PROCEDURE delete_album_producer_producer_id (IN producer_id_in INTEGER)
BEGIN
	DELETE FROM album_producer
	WHERE producer_id = producer_id_in;
END;

DROP PROCEDURE IF EXISTS delete_producer;

CREATE PROCEDURE delete_producer (IN producer_id_in INTEGER)
BEGIN
	CALL delete_album_producer_producer_id (producer_id_in);
	CALL delete_producer_by_id (producer_id_in);
END;

-- CRUD Studio
DROP PROCEDURE IF EXISTS add_studio;

CREATE PROCEDURE add_studio (IN name_in VARCHAR(30), IN city_in VARCHAR(30), IN country_id_in INTEGER)
BEGIN
	INSERT INTO studio (name, city, country_id)
		VALUES(name_in, city_in, country_id_in);
END;

DROP PROCEDURE IF EXISTS get_studio_by_id;

CREATE PROCEDURE get_studio_by_id (IN studio_id_in INTEGER)
BEGIN
	SELECT
		*
	FROM
		studio
	WHERE
		studio_id = studio_id_in;
END;

DROP PROCEDURE IF EXISTS get_studio_id_by_name;

CREATE PROCEDURE get_studio_id_by_name (IN name_studio VARCHAR(50))
BEGIN
	SELECT
		studio_id
	FROM
		studio
	WHERE
		name = name_studio;
END;

DROP PROCEDURE IF EXISTS get_all_studio;

CREATE PROCEDURE get_all_studio ()
BEGIN
	SELECT
		*
	FROM
		studio;
END;

DROP PROCEDURE IF EXISTS update_studio;

CREATE PROCEDURE update_studio (IN studio_id_in INTEGER, IN update_studio_name VARCHAR(30), IN city_in VARCHAR(30), IN country_id_in INTEGER)
BEGIN
	UPDATE
		studio SET
			name = update_studio_name, city = city_in, country_id = country_id_in
		WHERE
			studio_id = studio_id_in;
END;

DROP PROCEDURE IF EXISTS delete_studio_by_id;

CREATE PROCEDURE delete_studio_by_id (IN studio_id_in INTEGER)
BEGIN
	DELETE FROM studio
	WHERE studio_id = studio_id_in;
END;

DROP PROCEDURE IF EXISTS delete_album_studio_by_id;

CREATE PROCEDURE delete_album_studio_by_id (IN studio_id_in INTEGER)
BEGIN
	DELETE FROM album
	WHERE studio_id = studio_id_in;
END;

DROP PROCEDURE IF EXISTS delete_album_artist_studio_id;

CREATE PROCEDURE delete_album_artist_studio_id (IN studio_id_in INTEGER)
BEGIN
	DELETE FROM album_artist
	WHERE album_id IN(
		SELECT
			album_id FROM album
		WHERE
			studio_id = studio_id_in);
END;

DROP PROCEDURE IF EXISTS delete_music_album_studio_id;

CREATE PROCEDURE delete_music_album_studio_id (IN studio_id_in INTEGER)
BEGIN
	DELETE FROM music_album
	WHERE album_id IN(
		SELECT
			album_id FROM album
		WHERE
			studio_id = studio_id_in);
END;

DROP PROCEDURE IF EXISTS delete_album_producer_studio_id;

CREATE PROCEDURE delete_album_producer_studio_id (IN studio_id_in INTEGER)
BEGIN
	DELETE FROM album_producer
	WHERE album_id IN(
		SELECT
			album_id FROM album
		WHERE
			studio_id = studio_id_in);
END;

DROP PROCEDURE IF EXISTS delete_studio;

CREATE PROCEDURE delete_studio (IN studio_id_in INTEGER)
BEGIN
	CALL delete_album_producer_studio_id (studio_id_in);
	CALL delete_music_album_studio_id (studio_id_in);
	CALL delete_album_artist_studio_id (studio_id_in);
	CALL delete_album_studio_by_id (studio_id_in);
	CALL delete_studio_by_id (studio_id_in);
END;

-- CRUD User
DROP PROCEDURE IF EXISTS add_user;

CREATE PROCEDURE add_user (IN name VARCHAR(30), IN birthdate DATE, IN gender ENUM ('M', 'F'), IN country_id INTEGER, IN email VARCHAR(50), IN PASSWORD VARCHAR(30))
BEGIN
	INSERT INTO user(name, birthdate, gender, country_id, email, PASSWORD)
			VALUES(name, birthdate, gender, country_id, email, PASSWORD);
END;

DROP PROCEDURE IF EXISTS get_user_by_id;

CREATE PROCEDURE get_user_by_id (IN user_id_in INTEGER)
BEGIN
	SELECT
		*
	FROM
		USER
	WHERE
		user_id = user_id_in;
END;

DROP PROCEDURE IF EXISTS get_user_id_by_name;

CREATE PROCEDURE get_user_id_by_name (IN name_user VARCHAR(50))
BEGIN
	SELECT
		user_id
	FROM
		USER
	WHERE
		name = name_user;
END;

DROP PROCEDURE IF EXISTS get_user_id_by_email_password;

CREATE PROCEDURE get_user_id_by_email_password (IN password_in VARCHAR(30), IN email_in VARCHAR(50))
BEGIN
	SELECT
		user_id
	FROM
		`user`
	WHERE
		`password` = password_in AND email = email_in;
END;

DROP PROCEDURE IF EXISTS get_all_user;

CREATE PROCEDURE get_all_user ()
BEGIN
	SELECT
		*
	FROM
		`user`;
END;

DROP PROCEDURE IF EXISTS verify_email_exists;

CREATE PROCEDURE verify_email_exists (IN email_in VARCHAR(50))
BEGIN
	SELECT
		user_id
	FROM
		`user`
	WHERE
		email = email_in;
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

DROP PROCEDURE IF EXISTS delete_playlist_by_user_id;

CREATE PROCEDURE delete_playlist_by_user_id (IN user_id_in INTEGER)
BEGIN
	DELETE FROM playlist
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
	CALL delete_playlist_by_user_id (user_id_in);
	CALL delete_favourite_artist_by_user_id (user_id_in);
	CALL delete_favourite_music_by_user_id (user_id_in);
	CALL delete_user_by_id (user_id_in);
END;

-- Intermediate Tables
DROP PROCEDURE IF EXISTS add_music_playlist;

CREATE PROCEDURE add_music_playlist (IN playlist_id_in INTEGER, IN music_id_in INTEGER)
BEGIN
	INSERT INTO music_playlist (playlist_id, music_id)
		VALUES(playlist_id_in, music_id_in);
END;

DROP PROCEDURE IF EXISTS add_album_artist;

CREATE PROCEDURE add_album_artist (IN album_id_in INTEGER, IN artist_id_in INTEGER)
BEGIN
	INSERT INTO album_artist (album_id, artist_id)
		VALUES(album_id_in, artist_id_in);
END;

DROP PROCEDURE IF EXISTS add_album_producer;

CREATE PROCEDURE add_album_producer (IN album_id_in INTEGER, IN producer_id_in INTEGER)
BEGIN
	INSERT INTO album_producer (album_id, producer_id)
		VALUES(album_id_in, producer_id_in);
END;

DROP PROCEDURE IF EXISTS add_favourite_album;

CREATE PROCEDURE add_favourite_album (IN album_id_in INTEGER, IN user_id_in INTEGER)
BEGIN
	INSERT INTO favourite_album (album_id, user_id)
		VALUES(album_id_in, user_id_in);
	UPDATE
		album
	SET
		nr_likes = nr_likes + 1
	WHERE
		album_id = album_id_in;
END;

DROP PROCEDURE IF EXISTS add_favourite_artist;

CREATE PROCEDURE add_favourite_artist (IN artist_id_in INTEGER, IN user_id_in INTEGER)
BEGIN
	INSERT INTO favourite_artist (artist_id, user_id)
		VALUES(artist_id_in, user_id_in);
	UPDATE
		artist
	SET
		nr_followers = nr_followers + 1
	WHERE
		artist_id = artist_id_in;
END;

DROP PROCEDURE IF EXISTS add_favourite_music;

CREATE PROCEDURE add_favourite_music (IN music_id_in INTEGER, IN user_id_in INTEGER)
BEGIN
	INSERT INTO favourite_music (music_id, user_id)
		VALUES(music_id_in, user_id_in);
	UPDATE
		music
	SET
		nr_likes = nr_likes + 1
	WHERE
		music_id = music_id_in;
END;

DROP PROCEDURE IF EXISTS add_music_album;

CREATE PROCEDURE add_music_album (IN music_id_in INTEGER, IN album_id_in INTEGER)
BEGIN
	INSERT INTO music_album (music_id, album_id)
		VALUES(music_id_in, album_id_in);
END;

DROP PROCEDURE IF EXISTS add_music_playlist;

CREATE PROCEDURE add_music_playlist (IN music_id_in INTEGER, IN playlist_id_in INTEGER)
BEGIN
	INSERT INTO music_playlist (music_id, playlist_id)
		VALUES(music_id_in, playlist_id_in);
END;

DROP PROCEDURE IF EXISTS get_album_artist;

CREATE PROCEDURE get_album_artist (IN album_id_in INTEGER)
BEGIN
	SELECT
		artist_id
	FROM
		album_artist
	WHERE
		album_id = album_id_in;
END;

DROP PROCEDURE IF EXISTS get_album_producer;

CREATE PROCEDURE get_album_producer (IN album_id_in INTEGER)
BEGIN
	SELECT
		producer_id
	FROM
		album_producer
	WHERE
		album_id = album_id_in;
END;

DROP PROCEDURE IF EXISTS get_favourite_artist;

CREATE PROCEDURE get_favourite_artist (IN user_id_in INTEGER)
BEGIN
	SELECT
		artist_id
	FROM
		favourite_artist
	WHERE
		user_id = user_id_in;
END;

DROP PROCEDURE IF EXISTS get_favourite_album;

CREATE PROCEDURE get_favourite_album (IN user_id_in INTEGER)
BEGIN
	SELECT
		album_id
	FROM
		favourite_album
	WHERE
		user_id = user_id_in;
END;

DROP PROCEDURE IF EXISTS get_favourite_music;

CREATE PROCEDURE get_favourite_music (IN user_id_in INTEGER)
BEGIN
	SELECT
		music_id
	FROM
		favourite_music
	WHERE
		user_id = user_id_in;
END;

DROP PROCEDURE IF EXISTS get_music_album;

CREATE PROCEDURE get_music_album (IN album_id_in INTEGER)
BEGIN
	SELECT
		music_id
	FROM
		music_album
	WHERE
		album_id = album_id_in;
END;

DROP PROCEDURE IF EXISTS get_music_playlist;

CREATE PROCEDURE get_music_playlist (IN playlist_id_in INTEGER)
BEGIN
	SELECT
		music_id
	FROM
		music_playlist
	WHERE
		playlist_id = playlist_id_in;
END;

DROP PROCEDURE IF EXISTS exists_music_playlist;

CREATE PROCEDURE exists_music_playlist (IN playlist_id_in INTEGER, IN music_id_in INTEGER)
BEGIN
	SELECT
		*
	FROM
		music_playlist
	WHERE
		playlist_id = playlist_id_in AND music_id = music_id_in;
END;

DROP PROCEDURE IF EXISTS exists_album_artist;

CREATE PROCEDURE exists_album_artist (IN album_id_in INTEGER, IN artist_id_in INTEGER)
BEGIN
	SELECT
		*
	FROM
		album_artist
	WHERE
		album_id = album_id_in AND artist_id = artist_id_in;
END;

DROP PROCEDURE IF EXISTS exists_album_producer;

CREATE PROCEDURE exists_album_producer (IN album_id_in INTEGER, IN producer_id_in INTEGER)
BEGIN
	SELECT
		*
	FROM
		album_producer
	WHERE
		album_id = album_id_in AND producer_id = producer_id_in;
END;

DROP PROCEDURE IF EXISTS exists_favourite_album;

CREATE PROCEDURE exists_favourite_album (IN album_id_in INTEGER, IN user_id_in INTEGER)
BEGIN
	SELECT
		*
	FROM
		favourite_album
	WHERE
		album_id = album_id_in AND user_id = user_id_in;
END;

DROP PROCEDURE IF EXISTS exists_favourite_artist;

CREATE PROCEDURE exists_favourite_artist (IN artist_id_in INTEGER, IN user_id_in INTEGER)
BEGIN
	SELECT
		*
	FROM
		favourite_artist
	WHERE
		artist_id = artist_id_in AND user_id = user_id_in;
END;

DROP PROCEDURE IF EXISTS exists_favourite_music;

CREATE PROCEDURE exists_favourite_music (IN music_id_in INTEGER, IN user_id_in INTEGER)
BEGIN
	SELECT
		*
	FROM
		favourite_music
	WHERE
		music_id = music_id_in AND user_id = user_id_in;
END;

DROP PROCEDURE IF EXISTS exists_music_album;

CREATE PROCEDURE exists_music_album (IN music_id_in INTEGER, IN album_id_in INTEGER)
BEGIN
	SELECT
		*
	FROM
		music_album
	WHERE
		album_id = album_id_in AND music_id = music_id_in;
END;

DROP PROCEDURE IF EXISTS exists_music_playlist;

CREATE PROCEDURE exists_music_playlist (IN music_id_in INTEGER, IN playlist_id_in INTEGER)
BEGIN
	SELECT
		*
	FROM
		music_playlist
	WHERE
		music_id = music_id_in AND playlist_id = playlist_id_in;
END;

DROP PROCEDURE IF EXISTS remove_music_playlist;

CREATE PROCEDURE remove_music_playlist (IN playlist_id_in INTEGER, IN music_id_in INTEGER)
BEGIN
	DELETE FROM music_playlist
	WHERE playlist_id = playlist_id_in AND music_id = music_id_in;
END;

DROP PROCEDURE IF EXISTS remove_album_artist;

CREATE PROCEDURE remove_album_artist (IN album_id_in INTEGER, IN artist_id_in INTEGER)
BEGIN
	DELETE FROM album_artist
	WHERE album_id = album_id_in AND artist_id = artist_id_in;
END;

DROP PROCEDURE IF EXISTS remove_album_producer;

CREATE PROCEDURE remove_album_producer (IN album_id_in INTEGER, IN producer_id_in INTEGER)
BEGIN
	DELETE FROM album_producer
	WHERE album_id = album_id_in AND producer_id = producer_id_in;
END;

DROP PROCEDURE IF EXISTS remove_favourite_album;

CREATE PROCEDURE remove_favourite_album (IN album_id_in INTEGER, IN user_id_in INTEGER)
BEGIN
	DELETE FROM favourite_album
	WHERE album_id = album_id_in AND user_id = user_id_in;
	UPDATE
		album
	SET
		nr_likes = nr_likes - 1
	WHERE
		album_id = album_id_in;
END;

DROP PROCEDURE IF EXISTS remove_favourite_artist;

CREATE PROCEDURE remove_favourite_artist (IN artist_id_in INTEGER, IN user_id_in INTEGER)
BEGIN
	DELETE FROM favourite_artist
	WHERE artist_id = artist_id_in AND user_id = user_id_in;
	UPDATE
		artist
	SET
		nr_followers = nr_followers - 1
	WHERE
		artist_id = artist_id_in;
END;

DROP PROCEDURE IF EXISTS remove_favourite_music;

CREATE PROCEDURE remove_favourite_music (IN music_id_in INTEGER, IN user_id_in INTEGER)
BEGIN
	DELETE FROM favourite_music
	WHERE music_id = music_id_in AND user_id = user_id_in;
	UPDATE
		music
	SET
		nr_likes = nr_likes - 1
	WHERE
		music_id = music_id_in;
END;

DROP PROCEDURE IF EXISTS remove_music_album;

CREATE PROCEDURE remove_music_album (IN music_id_in INTEGER, IN album_id_in INTEGER)
BEGIN
	DELETE FROM music_album
	WHERE album_id = album_id_in AND music_id = music_id_in;
END;

DROP PROCEDURE IF EXISTS remove_music_playlist;

CREATE PROCEDURE remove_music_playlist (IN music_id_in INTEGER, IN playlist_id_in INTEGER)
BEGIN
	DELETE FROM music_playlist
	WHERE music_id = music_id_in AND playlist_id = playlist_id_in;
END;