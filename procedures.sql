-- Playlist Music Update
DROP PROCEDURE IF EXISTS add_music_from_playlist;
CREATE PROCEDURE add_music_from_playlist (IN playlist_id_in INT, IN music_id_in INT)
BEGIN
	INSERT INTO playlist_music (playlist_id, music_id)
		VALUES (playlist_id_in, music_id_in);
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

--All Songs and Albums of the selected artist
DROP PROCEDURE IF EXISTS get_all_songs_from_artist;
CREATE PROCEDURE get_all_songs_from_artist (IN artist_id_in INT)
BEGIN
SELECT music.name, music.duration, music.year, music.explicit, music.spotify_url, music.youtube_url, music.country_id, music.genre_id FROM music INNER JOIN artist_music ON music.music_id = artist_music.music_id WHERE artist_music.artist_id = artist_id_in;
END; 

DROP PROCEDURE IF EXISTS get_all_albums_from_artist;

arroz queimado