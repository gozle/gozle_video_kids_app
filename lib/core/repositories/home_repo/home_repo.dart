
import 'package:injectable/injectable.dart';


abstract class HomeRepo {
  Future<Map<String, dynamic>?> getVideos(int page);
}
