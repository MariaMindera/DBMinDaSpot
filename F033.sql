-- Age restriction	Explicit songs
DROP FUNCTION IF EXISTS age_by_user_id;
CREATE FUNCTION age_by_user_id (user_id_in INT)
	RETURNS INT DETERMINISTIC
BEGIN
DECLARE
	age INT;
	SET age = (
	SELECT
		timestampdiff(YEAR, birthdate, curdate())
		FROM
			USER
		WHERE
			user_id = user_id_in);
	RETURN age;
END;
	
DROP PROCEDURE IF EXISTS get_no_explicit_musics;
CREATE PROCEDURE get_no_explicit_musics ()
BEGIN
	SELECT
		name, duration, `year`, explicit, spotify_url, youtube_url, country_id, genre_id
	FROM
		music
	WHERE
		explicit = 0;
END;

DROP PROCEDURE IF EXISTS explicit_songs_by_user_id;
CREATE PROCEDURE explicit_songs_by_user_id (IN user_id_in INTEGER)
BEGIN
	IF (SELECT age_by_user_id (user_id_in)) > 17 THEN
		CALL get_all_musics ();
	ELSE
		CALL get_no_explicit_musics ();
	END IF;
END;