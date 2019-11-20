-- Artist profile Profile of all the songs and albums of the selected artist
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