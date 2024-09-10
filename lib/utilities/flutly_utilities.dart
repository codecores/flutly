class FlutlyUtilities {
  static String snakeToCamel(String text) {
    List<String> words = text.split('_');

    // İlk kelimeyi küçük bırakıp diğerlerinin baş harfini büyüt
    for (int i = 1; i < words.length; i++) {
      words[i] = words[i][0].toUpperCase() + words[i].substring(1);
    }

    // Kelimeleri birleştir ve sonucu döndür
    return words.join('');
  }
}
