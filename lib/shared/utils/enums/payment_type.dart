enum PaymentType {
  pix,
  creditCard,
  debitCard;

  bool get isPix => this == pix;
  bool get isCreditCard => this == creditCard;
  bool get isDebitCard => this == debitCard;

  String paymentTypeLabel() {
    {
      switch (this) {
        case pix:
          return 'PIX';
        case creditCard:
          return 'credit-card';
        default:
          return 'debit-card';
      }
    }
  }
}
