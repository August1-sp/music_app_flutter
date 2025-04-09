import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';
import '../models/api_response.dart';

part 'audiodb_api.g.dart';

@RestApi(baseUrl: "https://theaudiodb.com/api/v1/json/523532")
abstract class AudioDbService {
  factory AudioDbService(Dio dio) = _AudioDbService;

  @GET("/trending.php")
  Future<BaseApiResponse> getTrendingSingles(
    @Query("country") String country,
    @Query("type") String type,
    @Query("format") String format,
  );

  @GET("/trending.php")
  Future<BaseApiResponse> getTrendingAlbums(
    @Query("country") String country,
    @Query("type") String type,
    @Query("format") String format,
  );

  @GET("/album.php")
  Future<BaseApiResponse> getArtistAlbums(@Query("i") String artistId);

  @GET("/album.php")
Future<BaseApiResponse> getAlbum(@Query("m") String albumId);

  @GET("/search.php")
  Future<BaseApiResponse> searchArtists(@Query("s") String query);

  @GET("/artist.php")
  Future<BaseApiResponse> getArtist(@Query("i") String id);

  @GET("/track.php")
  Future<BaseApiResponse> getAlbumTracks(@Query("m") String albumId);
}
