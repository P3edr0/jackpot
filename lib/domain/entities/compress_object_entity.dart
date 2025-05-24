import 'dart:io';
import 'dart:ui';

class CompressObject {
  File imageFile;
  String path;
  int rand;
  Size expectedSize;

  CompressObject(
      {required this.imageFile,
      required this.path,
      required this.rand,
      required this.expectedSize});
}
