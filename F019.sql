-- Country Charts	CRIAR PLAYLIST MAIS OUVIDA DO PAÍS
DROP PROCEDURE IF EXISTS music_history_per_country;
CREATE PROCEDURE music_history_per_country (IN in_country_id INTEGER)
BEGIN
	SELECT
		name, duration, `year`, explicit, spotify_url, youtube_url, country_id, genre_id
	FROM
		music_history
		INNER JOIN music ON music_history.music_id = music.music_id
	WHERE
		music.country_id = in_country_id
	ORDER BY
		nr_plays DESC
	LIMIT 50;
END;