/// The data of the m3u8 file
class M3U8Data {
  /// The quality of the video
  final String? dataQuality;

  /// The video's url
  final String? dataURL;

  String get dataQualityName {
    String? input = dataQuality;
    if (input?.contains('x') == true) {
      String output = '${input!.split('x').last}p';
      return output;
    } else {
      return '$dataQuality';
    }
  }

  /// Constructor
  M3U8Data({this.dataURL, this.dataQuality});
}
