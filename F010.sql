-- Filter playlists Do playlists with filters (country, genre and artists)
DROP PROCEDURE IF EXISTS filter_music_by_country;
CREATE PROCEDURE filter_music_by_country (IN country_id_in INTEGER)
BEGIN
    SELECT music_id FROM music WHERE country_id=country_id_in;
END;

DROP PROCEDURE IF EXISTS get_playlist_id_by_name;
CREATE PROCEDURE get_playlist_id_by_name (IN name_in VARCHAR(50))
BEGIN
    SELECT playlist_id FROM playlist WHERE name=name_in;
END;

DROP PROCEDURE IF EXISTS create_playlist_by_country_id;
CREATE PROCEDURE create_playlist_by_country_id (IN country_id_in INTEGER, IN user_id_in INTEGER, IN name_in VARCHAR(50))
BEGIN
    CALL add_Playlist(name_in, user_id_in);
    CALL add_music_to_playlist(get_playlist_id_by_name(name_in), filter_music_by_country);
END;