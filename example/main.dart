import 'package:currency_type/currency_type.dart';

void main(List<String> arguments) {
  print('');
  print('Using Currency:');

  var a = Currency.parse('0.7');
  var b = Currency.parse('0.49');
  var c = a * a;

  print('Result : $c');

  if (c == b) {
    print("Yes it's equal");
  } else {
    print("No it's not equal");
  }

  print('');
  print('Using Float');

  var aa = 0.7;
  var bb = 0.49;
  var cc = aa * aa;
  var dd = (cc == 0.49);

  print('Result : $cc');

  if (cc == bb) {
    print("Yes it's equal");
  } else {
    print("No it's not equal");
  }
}
