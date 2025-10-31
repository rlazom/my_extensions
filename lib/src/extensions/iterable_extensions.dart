extension ListX on List {
  bool compareLists(List list) {
    if (this.length != list.length) {
      return false;
    }

    for (var item in this) {
      if (!list.contains(item)) {
        return false;
      }
    }

    return true;
  }
}