import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jackpot/shared/utils/app_assets.dart';
import 'package:path_provider/path_provider.dart';

class ViewerDocsController extends ChangeNotifier {
  bool isLoading = false;
  DocType? selectedDoc;
  String _filePath = '';

  String get filePath => _filePath;
  void setSelectedDoc(DocType newDoc) {
    selectedDoc = newDoc;
    notifyListeners();
  }

  String pageTitle() {
    switch (selectedDoc) {
      case DocType.privacy:
        return 'Termos de privacidade';
      case DocType.termsOfUse:
        return 'Termos de uso';

      default:
        return 'LGPD';
    }
  }

  Future<void> loadPdfFile() async {
    setLoading();
    final ByteData data = await rootBundle.load(AppAssets.privacyTerms);
    final Directory tempDir = await getTemporaryDirectory();
    final File tempFile = File('${tempDir.path}/documento.pdf');
    await tempFile.writeAsBytes(data.buffer.asUint8List(), flush: true);
    _filePath = tempFile.path;
    setLoading();
  }

  void setLoading() {
    isLoading = !isLoading;
    notifyListeners();
  }
}

enum DocType {
  privacy,
  termsOfUse,
  lgpd;

  bool get isPrivacy => this == privacy;
  bool get isTermsOfUse => this == termsOfUse;
  bool get isLgpd => this == lgpd;
}
