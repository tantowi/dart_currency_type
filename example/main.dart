import 'package:currency_type/currency_type.dart';

void main(List<String> arguments) {
  usingDouble();
  print('');
  usingCurrency();
  print('');
}

void usingDouble() {
  var a = 0.7;
  var b = 0.49;
  var c = a * a;

  print('Using Double');
  print('$a * $a = $c');

  if (c == b) {
    print("Equal");
  } else {
    print("Not Equal");
  }
}

void usingCurrency() {
  var a = Currency.parse('0.7');
  var b = Currency.parse('0.49');
  var c = a * a;

  print('Using Currency');
  print('$a * $a = $c');

  if (c == b) {
    print("Equal");
  } else {
    print("Not Equal");
  }
}
