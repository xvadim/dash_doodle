class Range {
  final double start;
  final double end;
  Range(this.start, this.end);

  bool overlaps(Range other) {
    if (other.start > start && other.start < end) return true;
    if (other.end > start && other.end < end) return true;
    return false;
  }
}
