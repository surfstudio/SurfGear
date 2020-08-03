const itemLabelArg = 'itemLabel';
const itemAmountArg = 'itemAmount';
const itemTypeArg = 'itemType';

/// Item for payment
class PaymentItem {
  PaymentItem(this.label, this.price, this.isFinal);

  final String label;
  final String price;
  final bool isFinal;

  Map<String, dynamic> map() {
    return <String, dynamic>{
      itemLabelArg: label,
      itemAmountArg: price,
      itemTypeArg: isFinal,
    };
  }
}
