import 'dart:ui' as ui;

class TextDirectionUtils {
  /// Detects if the given text contains Arabic characters
  static bool isArabic(String text) {
    if (text.isEmpty) return false;
    
    // Arabic Unicode ranges
    // Arabic (0600-06FF)
    // Arabic Supplement (0750-077F)
    // Arabic Extended-A (08A0-08FF)
    // Arabic Presentation Forms-A (FB50-FDFF)
    // Arabic Presentation Forms-B (FE70-FEFF)
    for (int i = 0; i < text.length; i++) {
      int codeUnit = text.codeUnitAt(i);
      if ((codeUnit >= 0x0600 && codeUnit <= 0x06FF) || // Arabic
          (codeUnit >= 0x0750 && codeUnit <= 0x077F) || // Arabic Supplement
          (codeUnit >= 0x08A0 && codeUnit <= 0x08FF) || // Arabic Extended-A
          (codeUnit >= 0xFB50 && codeUnit <= 0xFDFF) || // Arabic Presentation Forms-A
          (codeUnit >= 0xFE70 && codeUnit <= 0xFEFF)) { // Arabic Presentation Forms-B
        return true;
      }
    }
    return false;
  }
  
  /// Returns TextDirection based on text content
  static ui.TextDirection getTextDirection(String text) {
    return isArabic(text) ? ui.TextDirection.rtl : ui.TextDirection.ltr;
  }
}
