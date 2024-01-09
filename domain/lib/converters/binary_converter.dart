class BianaryConverter {
  static String toHex(List<int> data) {
    return data
        .map((int value) => value.toRadixString(16).padLeft(2, '0'))
        .join();
  }

  static List<int> hexStringToList(String hexString) {
    List<int> intList = [];
    for (int i = 0; i < hexString.length; i += 2) {
      String hexSubstring = hexString.substring(i, i + 2);
      int decimalValue = int.parse(hexSubstring, radix: 16);
      intList.add(decimalValue);
    }
    return intList;
  }
}
