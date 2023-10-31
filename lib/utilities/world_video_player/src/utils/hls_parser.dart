import 'dart:developer';

import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/models.dart';
import 'regex_response.dart';

class HlsParser {
  static Future<(List<M3U8Data>, List<AudioModel>)> getTraks({required String videoUrl}) async {
    RegExp regExp = RegExp(
      RegexResponse.regexM3U8Resolution,
      caseSensitive: false,
      multiLine: true,
    );

    final List<M3U8Data> videoTraks = [];
    final List<AudioModel> audioTraks = [];

    videoTraks.add(M3U8Data(dataQuality: 'Auto', dataURL: videoUrl));

    http.Response response = await http.get(Uri.parse(videoUrl));

    if (response.statusCode == 200) {
      final m3u8Content = utf8.decode(response.bodyBytes);

      List<RegExpMatch> matches = regExp.allMatches(m3u8Content).toList();

      final netRegex = RegExp(RegexResponse.regexHTTP);
      final netRegex2 = RegExp(RegexResponse.regexURL);

      // парсим quality traks
      for (RegExpMatch regExpMatch in matches) {
        String quality = (regExpMatch.group(1)).toString();
        String sourceURL = (regExpMatch.group(3)).toString();

        final isNetwork = netRegex.hasMatch(sourceURL);
        final match = netRegex2.firstMatch(videoUrl);

        String url;

        if (isNetwork) {
          url = sourceURL;
        } else {
          final dataURL = match?.group(0);
          url = "$dataURL$sourceURL";
        }

        videoTraks.add(M3U8Data(dataQuality: quality, dataURL: url));
      }

      // парсим audio traks
      for (RegExpMatch regExpMatch2 in matches) {
        String audioURL = (regExpMatch2.group(1)).toString();
        final isNetwork = netRegex.hasMatch(audioURL);
        final match = netRegex2.firstMatch(videoUrl);
        String auURL = audioURL;

        if (!isNetwork) {
          final auDataURL = match!.group(0);
          auURL = "$auDataURL$audioURL";
        }

        audioTraks.add(AudioModel(url: auURL));
      }
      return (videoTraks, audioTraks);
    } else {
      final message = 'Ошибка получения hls даты. Ошибка: ${response.statusCode}';
      log(message);
      throw message;
    }
  }
}
