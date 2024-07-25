
class FontTest {
  const FontTest._(this.index, this.value);

  /// The encoded integer value of this font weight.
  final int index;

  /// The thickness value of this font weight.
  final int value;

  static const FontTest w100 = FontTest._(0, 100);
}
