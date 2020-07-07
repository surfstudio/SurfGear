const ITEM_LABEL = "itemLabel";
const ITEM_AMOUNT = "itemAmount";
const ITEM_IS_FINAL = "itemType";

class PaymentItem {
  final String label;
  final String price;
  final bool isFinal;

  PaymentItem(this.label, this.price, this.isFinal);

  Map<String, dynamic> map() {
    return {
      ITEM_LABEL: label,
      ITEM_AMOUNT: price,
      ITEM_IS_FINAL: isFinal,
    };
  }
}
