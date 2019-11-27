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