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