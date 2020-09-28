const itemLabelArg = 'itemLabel';
const itemAmountArg = 'itemAmount';
const itemTypeArg = 'itemType';

/// Item for payment
class PaymentItem {
  PaymentItem(
    this.label,
    this.price,
    // ignore: avoid_positional_boolean_parameters
    this.isFinal,
  );

  final String label;
  final String price;
  final bool isFinal;

  Map<String, Object> map() {
    return <String, Object>{
      itemLabelArg: label,
      itemAmountArg: price,
      itemTypeArg: isFinal,
    };
  }
}
