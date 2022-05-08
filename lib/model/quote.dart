import 'dart:math';
import '../resources/quotes.dart' as data;

class Quote {
  String quote = "";
  String author = "";
  final List<Map<String, String>> _quotes = data.quotes;

  int length = data.quotes.length;

  void getQuote() {
    final int _idx = Random().nextInt(length) + 1;
    quote = _quotes[_idx]['quote']!;
    author = _quotes[_idx]['author']!;
  }
}
