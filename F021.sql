-- "This is" playlists	"This is" playlist based on artists the user follows
DROP PROCEDURE IF EXISTS artists_followed_by_user_id;
CREATE PROCEDURE artists_followed_by_user_id (IN user_id_in INTEGER)
BEGIN
	SELECT
		artist_id
	FROM
		favourite_artist
	WHERE
		user_id = user_id_in;
END;

--CAll get_all_songs_from_artist