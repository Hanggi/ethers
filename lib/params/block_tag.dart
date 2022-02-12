class BlockTag {
  final String? stringValue;
  final int? intValue;

  const BlockTag.latest()
      : stringValue = 'latest',
        intValue = 0;

  const BlockTag.earliest()
      : stringValue = '0x0',
        intValue = 0;

  const BlockTag.pending()
      : stringValue = 'pending',
        intValue = 0;

  const BlockTag.at(int at)
      : intValue = at,
        stringValue = null;

  // TODO: verify the hex value is valid.
  const BlockTag.hash(String hex)
      : intValue = 0,
        stringValue = hex;

  toParam() {
    if (stringValue != null) {
      return stringValue;
    }
    return intValue;
  }
}
