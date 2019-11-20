-- CRUD User
DROP PROCEDURE IF EXISTS add_user;
CREATE PROCEDURE add_user (IN name VARCHAR(30), IN birthdate DATE, IN gender ENUM ('M', 'F'), IN country_id INTEGER, IN email VARCHAR(30), IN PASSWORD VARCHAR(30))
BEGIN
	INSERT INTO user(name, birthdate, gender, country_id, email, PASSWORD)
			VALUES(name, birthdate, gender, country_id, email, PASSWORD);
END;

DROP PROCEDURE IF EXISTS get_user_by_id;
CREATE PROCEDURE get_user_by_id (IN user_id_in INTEGER)
BEGIN
	SELECT
		name, birthdate, gender, country_id, email
	FROM
		USER
	WHERE
		user_id = user_id_in;
END;

DROP PROCEDURE IF EXISTS get_all_users;
CREATE PROCEDURE get_all_users ()
BEGIN
	SELECT
		name, birthdate, gender, country_id, email
	FROM
		USER;
END;

DROP PROCEDURE IF EXISTS update_user;
CREATE PROCEDURE update_user (IN user_id_in INTEGER, IN name_user VARCHAR(30), IN birthdate_user DATE, IN gender_music ENUM ('M', 'F'), IN country_id_user INTEGER, IN email_user VARCHAR(30), IN password_user VARCHAR(30))
BEGIN
	UPDATE
		USER SET
			name = name_user, birthdate = birthdate_user, gender = gender_music, country_id = country_id_user, email = email_user, PASSWORD = password_user
		WHERE
			user_id = user_id_in;
END;

DROP PROCEDURE IF EXISTS delete_favourite_artist_by_user_id;
CREATE PROCEDURE delete_favourite_artist_by_user_id (IN user_id_in INTEGER)
BEGIN
	DELETE FROM favourite_artist
	WHERE user_id = user_id_in;
END;

DROP PROCEDURE IF EXISTS delete_playlist_by_user_id;
CREATE PROCEDURE delete_playlist_by_user_id (IN user_id_in INTEGER)
BEGIN
	DELETE FROM playlist
	WHERE user_id = user_id_in;
END;

DROP PROCEDURE IF EXISTS delete_favourite_music_by_user_id;
CREATE PROCEDURE delete_favourite_music_by_user_id (IN user_id_in INTEGER)
BEGIN
	DELETE FROM favourite_music
	WHERE user_id = user_id_in;
END;

DROP PROCEDURE IF EXISTS delete_user_by_id;
CREATE PROCEDURE delete_user_by_id (IN user_id_in INTEGER)
BEGIN
	DELETE FROM USER
	WHERE user_id = user_id_in;
END;

DROP PROCEDURE IF EXISTS delete_user;
CREATE PROCEDURE delete_user (IN user_id_in INTEGER)
BEGIN
	CALL delete_playlist_by_user_id (user_id_in);
	CALL delete_favourite_artist_by_user_id (user_id_in);
	CALL delete_favourite_music_by_user_id (user_id_in);
	CALL delete_user_by_id (user_id_in);
END;