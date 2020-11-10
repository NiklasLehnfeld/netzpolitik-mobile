extension IntFormatting on int {

  String zeroFill(int length) {
    var result = toString();

    while (result.length < length) {
      result = '0$result';
    }

    return result;
  }

}