-- Filter playlists Do playlists with filters (country, genre and artists)
DROP PROCEDURE IF EXISTS filter_playlist_by_country;
CREATE PROCEDURE filter_playlist_by_country (IN country_id_in INTEGER)
BEGIN
	SELECT
		*
	FROM
		music
	WHERE
		country_id = country_id_in;
END;

DROP PROCEDURE IF EXISTS filter_playlist_by_genre;
CREATE PROCEDURE filter_playlist_by_genre (IN country_id_in INTEGER)
BEGIN
	SELECT
		*
	FROM
		music
	WHERE
		country_id = country_id_in;
END;

DROP PROCEDURE IF EXISTS filter_playlist_by_artist;
CREATE PROCEDURE filter_playlist_by_artist (IN artist_id_in INTEGER)
BEGIN
	SELECT
		*
	FROM
		music
		INNER JOIN album_music ON music.music_id = album_music.music_id
		INNER JOIN album_artist ON album_music.album_id = album_artist.album_id
		INNER JOIN artist ON album_artist.artist_id = artist.artist_id
	WHERE
		artist.artist_id = artist_id_in;
END;