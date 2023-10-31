// class Expansion {
//   final int? height;
//   final int? width;

//   Expansion({
//     this.height = 9,
//     this.width = 16,
//   });

//   Expansion copyWith({
//     int? height,
//     int? width,
//   }) {
//     return Expansion(
//       height: height ?? this.height,
//       width: width ?? this.width,
//     );
//   }

//   double get aspectRatio => ((width ?? 16) / (height ?? 9));

//   static Expansion fromJson(String? json) {
//     final List<String> parts = '$json'.split(':');

//     if (parts.length == 2) {
//       final int width = int.parse(parts[0]);
//       final int height = int.parse(parts[1]);
//       return Expansion(height: height, width: width);
//     } else {
//       return Expansion(height: 9, width: 16);
//     }
//   }

//   Map<String, dynamic> toJson() => {'height': height, 'width': width};
// }
