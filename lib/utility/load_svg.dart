import 'package:flutter_svg/flutter_svg.dart';

Future<void> preloadSvg(String path) async {
  final picture = SvgPicture.asset(path);
  await precachePicture(picture.pictureProvider, null);
}
