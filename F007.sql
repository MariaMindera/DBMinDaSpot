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

DROP PROCEDURE IF EXISTS delete_favourite_artist_by_artist_id_user_id;
CREATE PROCEDURE delete_favourite_artist_by_artist_id_user_id (IN artist_id_in INTEGER, IN user_id_in INTEGER)
BEGIN
	DELETE FROM favourite_artist
	WHERE artist_id = artist_id_in AND user_id = user_id_in;
END;

DROP PROCEDURE IF EXISTS delete_favourite_music_by_music_id_user_id;
CREATE PROCEDURE delete_favourite_music_by_music_id_user_id (IN music_id_in INTEGER, IN user_id_in INTEGER)
BEGIN
	DELETE FROM favourite_music
	WHERE music_id = music_id_in AND user_id = user_id_in;
END;