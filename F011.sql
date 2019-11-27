-- Top Chart Top 50 songs this week
DROP PROCEDURE IF EXISTS top_50;
CREATE PROCEDURE top_50 ()
BEGIN
	SELECT
		name, duration, `year`, explicit, spotify_url, youtube_url, country_id, genre_id, sum(music_history.nr_plays) AS plays
		FROM
			music
			INNER JOIN music_history ON music.music_id = music_history.music_id
		GROUP BY
			music.music_id
		ORDER BY
			plays DESC
		LIMIT 50;
END;