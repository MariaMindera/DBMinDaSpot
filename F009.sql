-- Artist profile Get Musics and Album Details From Artist
DROP PROCEDURE IF EXISTS get_album_and_musics_from_artist_by_artist_id;
CREATE PROCEDURE get_album_and_musics_from_artist_by_artist_id (IN artist_id_in INTEGER)
BEGIN
	SELECT
		music.name, music.duration, music. `year`, music.explicit, music.spotify_url, music.youtube_url, music.country_id, music.genre_id, album.name, album. `year`, album.studio_id
	FROM
		music
		INNER JOIN album_music ON music.music_id = album_music.music_id
		INNER JOIN album ON album_music.album_id = album.album_id
		INNER JOIN album_artist ON album.album_id = album_artist.album_id
	WHERE
		album_artist.artist_id = artist_id_in;
END;