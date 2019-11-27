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