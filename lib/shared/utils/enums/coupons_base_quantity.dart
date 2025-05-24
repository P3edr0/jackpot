enum CouponsBaseQuantity {
  tree,
  five,
  ten;

  bool get isTree => this == tree;
  bool get isFive => this == five;
  bool get isTen => this == ten;

  int value() {
    switch (this) {
      case tree:
        return 3;
      case five:
        return 5;
      default:
        return 10;
    }
  }

  double price(double cost) {
    switch (this) {
      case tree:
        return 3 * cost;
      case five:
        return 5 * cost;
      default:
        return 10 * cost;
    }
  }
}
