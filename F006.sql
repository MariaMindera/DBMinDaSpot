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
		name
	FROM
		genre
	WHERE
		genre_id = genre_id_in;
END;

DROP PROCEDURE IF EXISTS get_all_genre;
CREATE PROCEDURE get_all_genre ()
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

DROP PROCEDURE IF EXISTS delete_genre_by_id;
CREATE PROCEDURE delete_genre_by_id (IN genre_id_in INTEGER)
BEGIN
	DELETE FROM genre
	WHERE genre_id = genre_id_in;
END;

DROP PROCEDURE IF EXISTS delete_genre_music_by_genre_id;
CREATE PROCEDURE delete_genre_music_by_genre_id (IN genre_id_in INTEGER)
BEGIN
	DELETE FROM music
	WHERE genre_id = genre_id_in;
END;

DROP PROCEDURE IF EXISTS delete_genre_favourite_playlist_music_by_genre_id;
CREATE PROCEDURE delete_genre_favourite_playlist_music_by_genre_id (IN genre_id_in INTEGER)
BEGIN
	DELETE FROM favourite_music
	WHERE music_id In (SELECT music_id FROM music WHERE genre_id = genre_id_in);
	DELETE FROM playlist_music
	WHERE music_id In (SELECT music_id FROM music WHERE genre_id = genre_id_in);
END;

DROP PROCEDURE IF EXISTS delete_genre;
CREATE PROCEDURE delete_genre (IN genre_id_in INTEGER)
BEGIN
	CALL delete_genre_favourite_playlist_music_by_genre_id (genre_id_in);
	CALL delete_genre_music_by_genre_id (genre_id_in);
	CALL delete_genre_by_id (genre_id_in);
END;