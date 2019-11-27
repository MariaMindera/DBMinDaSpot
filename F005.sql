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

DROP PROCEDURE IF EXISTS delete_album_by_id;
CREATE PROCEDURE delete_album_by_id (IN album_id_in INTEGER)
BEGIN
	DELETE FROM album
	WHERE album_id = album_id_in;
END;

DROP PROCEDURE IF EXISTS delete_album_album_music_by_album_id;
CREATE PROCEDURE delete_album_album_music_by_album_id (IN album_id_in INTEGER)
BEGIN
	DELETE FROM album_music
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
	CALL delete_album_album_music_by_album_id (album_id_in);
	CALL delete_album_album_producer_by_album_id (album_id_in);
	CALL delete_album_by_id (album_id_in);
END;