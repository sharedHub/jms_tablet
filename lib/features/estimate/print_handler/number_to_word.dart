class NumberToWordsFormatter {
  static const _ones = [
    '', 'One', 'Two', 'Three', 'Four', 'Five', 'Six',
    'Seven', 'Eight', 'Nine'
  ];

  static const _tens = [
    '', 'Ten', 'Twenty', 'Thirty', 'Forty', 'Fifty',
    'Sixty', 'Seventy', 'Eighty', 'Ninety'
  ];

  static const _teens = [
    'Ten', 'Eleven', 'Twelve', 'Thirteen', 'Fourteen',
    'Fifteen', 'Sixteen', 'Seventeen', 'Eighteen', 'Nineteen'
  ];

  static const _thousands = ['','Thousand','Lakh','Crore'];

  String convert(int number) {
    if (number == 0) return 'Zero';

    String words = '';
    int count = 0;

    while (number > 0) {
      int chunk = number % 1000;
      if (chunk != 0) {
        words = _convertChunk(chunk) + _thousands[count] + ' ' + words;
      }
      number ~/= count == 0 ? 1000 : 100;
      count++;
    }

    return words.trim();
  }

  String _convertChunk(int number) {
    if (number == 0) return '';

    String words = '';

    int hundred = number ~/ 100;
    int remainder = number % 100;

    if (hundred > 0) {
      words += '${_ones[hundred]} Hundred ';
    }

    if (remainder >= 10 && remainder < 20) {
      words += '${_teens[remainder - 10]} ';
    } else if (remainder >= 20 || remainder < 10 && remainder > 0) {
      int ten = remainder ~/ 10;
      int one = remainder % 10;
      if (ten > 0) words += '${_tens[ten]} ';
      if (one > 0) words += '${_ones[one]} ';
    }

    return words;
  }
}