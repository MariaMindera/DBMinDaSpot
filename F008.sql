-- Add/Remove music from playlist
DROP PROCEDURE IF EXISTS add_music_to_playlist;
CREATE PROCEDURE add_music_to_playlist (IN playlist_id_in INTEGER, IN music_id_in INTEGER)
BEGIN
	INSERT INTO playlist_music (playlist_id, music_id)
		VALUES(playlist_id_in, music_id_in);
END;

DROP PROCEDURE IF EXISTS remove_music_from_playlist;
CREATE PROCEDURE remove_music_from_playlist (IN playlist_id_in INTEGER, IN music_id_in INTEGER)
BEGIN
	DELETE FROM playlist_music
		WHERE
			playlist_id = playlist_id_in AND music_id = music_id_in;
END;