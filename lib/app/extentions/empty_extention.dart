extension EmptyCheckX on Object? {
  bool get isNullOrEmpty {
    final v = this;

    if (v == null) return true;
    if (v is String) return v.trim().isEmpty;
    if (v is Iterable) return v.isEmpty;
    if (v is Map) return v.isEmpty;

    return false;
  }

  bool get isNotNullOrEmpty => !isNullOrEmpty;
}
