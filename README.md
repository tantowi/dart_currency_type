# currency_type

![Version](https://img.shields.io/github/v/tag/tantowi/dart_currency_type?label=version)



The Currency type is a large numeric type, with exactly four digit after the decimal point. 
Internally, Currency using integer calculation to minimizes rounding errors.

The Currency type is appropriate for financial calculations that require large numbers of significant integral, up to four fractional digits, 
and minimize error caused by floating point calculation.

<br>

## Why Using Currency ?

<br>

`Currency` prevent rounding error from floating point calculation. `Currency` also make comparisan more accurate and predictable.

<br>

Using Double

```dart
func main() {
  var a = 0.7;
  var b = 0.49;
  var c = a * a;

  print('$a * $a = $c');

  if (c == b) {
    print("Equal");
  } else {
    print("Not Equal");
  }
}
```

```
0.7 * 0.7 = 0.48999999999999994
Not Equal
```

Using Currency

```dart
func main() {
  var a = Currency.parse('0.7');
  var b = Currency.parse('0.49');
  var c = a * a;

  print('$a * $a = $c');

  if (c == b) {
    print("Equal");
  } else {
    print("Not Equal");
  }
}
```


```
0.7000 * 0.7000 = 0.4900
Equal
```

<br>

## How To Use

<br>

To use `currency_type` module, you have to add to your project by run following command: 

```shell
$ dart pub add currency_type 
```

or add directly in `pubspec.yaml`

```yaml
dependencies: 
  currency_type: ^1.0.0
```

and then import to your dart file

```dart
import 'package:currency_type/currency_type.dart';
```

<br>

## Variable declaration 

<br>

You can declare `Currency` variable in 3 ways:


   1. Create zero value

      ```dart
      var a = Currency();
      ```

   2. Convert from `numbers` variable or literal :

      ```dart
      var b = 1234;
      var c = 1234.56;

      var d = Currency.from(b);
      var e = Currency.from(c);

      var f = Currency.from(1234);
      var g = Currency.from(1234.56);
      ```

   3. Parsing from `string` :

      ```dart
      var f = Currency.parse('1234567890');
      var g = Currency.parse('1234567890123456.1234');
      ```

<br>

## Operations

<br>

You can do arithmetic operation on `Currency` like addition, subtraction, multiplication, or division.

   ```dart
   var h = d + e; 
   var i = g - h;
   var j = d * e; 
   var k = g / f; 

   var l = (d + e) * g;
   ```

`Currency` can also be compared to other `Currency`

   ```dart
   if (k == l) {
      ...
   }
   

   if (h > Currency.from(100)) {
      ...
   }
   ```

<br>

## Big Numbers

<br>

Unlike `double`, `Currency` can store very big number precisely.

```dart
func main() {
  var a = 12345678901234567.1234;
  print("Big Double   : $a");

  var b = Currency.parse('12345678901234567.1234');
  print("Big Currency : $b");
}
```

```
Big Double   : 12345678901234568.0
Big Currency : 12345678901234567.1234
```

<br><br><br>


<small>
Copyright (c) 2021-2025, Mohamad Tantowi Mustofa (tantowi.com)<br>
Licensed under BSD 3-Clause license.
</small>
