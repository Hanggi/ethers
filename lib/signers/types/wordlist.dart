class Wordlist {
  final String locale;

  Wordlist(this.locale);

  List<String> split(String mnemonic) {
    final re = RegExp(r'/ +/g');
    return mnemonic.toLowerCase().split(re);
  }

  String join(List<String> words) {
    return words.join(' ');
  }
}
