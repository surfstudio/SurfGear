class Counter {
  static const _key = 'counterValue';

  final int value;

  const Counter([this.value = 0]);

  static Counter fromJson(Map<String, dynamic> json) {
    final counterValue = json[_key] as int;
    return Counter(counterValue);
  }

  Map<String, dynamic> toJson() => {_key: value};

  Counter getIncremented() => Counter(value + 1);
}
