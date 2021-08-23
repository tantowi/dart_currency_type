// BSD 3-Clause License
//
// Copyright (c) 2021, Mohamad Tantowi Mustofa (tantowi.com)
// All rights reserved.
//
// Redistribution and use in source and binary forms, with or without
// modification, are permitted provided that the following conditions are met:
//
// 1. Redistributions of source code must retain the above copyright notice, this
//    list of conditions and the following disclaimer.
//
// 2. Redistributions in binary form must reproduce the above copyright notice,
//    this list of conditions and the following disclaimer in the documentation
//    and/or other materials provided with the distribution.
//
// 3. Neither the name of the copyright holder nor the names of its
//    contributors may be used to endorse or promote products derived from
//    this software without specific prior written permission.
//
// THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
// AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
// IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
// DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE
// FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
// DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
// SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
// CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
// OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
// OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

library currency_type;

///
/// The `Currency` is a number type with four decimal places.
/// The `Currency` is appropriate for financial calculations that require large numbers without round-off errors.
///
class Currency implements Comparable<Currency> {
  ///
  /// Number of decimal point stored in `Currency`
  ///
  static const SCALE = 4;

  //
  // _MULTIPLIER = 10^SCALE
  //
  static const _MULTIPLIER = 10000;

  ///
  /// Internal value of the currency and is immutable
  ///
  late final BigInt _value;

  ///
  /// Create `Currency` with zero value
  ///
  Currency() {
    _value = BigInt.zero;
  }

  ///
  /// Create `Currency` from specified internal value representation
  ///
  Currency._fromValue(BigInt value) {
    _value = value;
  }

  ///
  /// Create `Currency` from numeric (integer or double) [value]
  ///
  /// For value bigger than [num] can hold, use [Currency.parse]
  ///
  Currency.from(num value) {
    if (value is int) {
      //print('Currency.from (int): $value');
      _value = BigInt.from(value) * BigInt.from(_MULTIPLIER);
      return;
    }

    // assuming double
    //print("Currency.from (double): $value");

    try {
      this._value = _parse(value.toStringAsFixed(SCALE));
    } on FormatException {
      this._value = BigInt.zero;
    }
  }

  ///
  /// Create `Currency` from BigInt value
  ///
  Currency.fromBigInt(BigInt value) {
    _value = value * BigInt.from(_MULTIPLIER);
  }

  ///
  /// Returns `Currency` from [value] string.
  ///
  /// Return 0 when [value] has format error
  ///
  static Currency parse(String value) {
    try {
      return Currency._fromValue(_parse(value));
    } on FormatException {
      return Currency();
    }
  }

  ///
  /// Returns `Currency` from [value] string
  ///
  /// Returns null when [value] has format error
  ///
  static Currency? tryParse(String value) {
    try {
      return Currency._fromValue(_parse(value));
    } on FormatException {
      return null;
    }
  }

  //
  // Parse string to Currency internal value in BigInt
  // Throws FormatException on format error
  //
  static BigInt _parse(String value) {
    value = value.trim();
    if (value == '') return BigInt.zero;

    var av = value.split('.');
    if (av.length > 2) {
      return BigInt.zero;
    }

    if (av.length == 1) {
      return BigInt.parse(av[0]) * BigInt.from(_MULTIPLIER);
    }

    // av.length==2
    var dint = _parseInt(av[0]);
    var ddec = _parseDec(av[1]);

    BigInt rs = dint * BigInt.from(_MULTIPLIER) + (dint >= BigInt.zero ? ddec : -ddec);
    //print("_parse: $value  ->  int:$dint  dec:$ddec  ->  $rs");
    return rs;
  }

  //
  // Parse the integer part
  // Throws FormatException on format error
  //
  static BigInt _parseInt(String value) {
    if (value == '') return BigInt.zero;
    return BigInt.parse(value);
  }

  //
  // Parse the decimal part
  // Throws FormatException on format error
  //
  static BigInt _parseDec(String value) {
    if (value == '') return BigInt.zero;
    if (value[0] == '-') throw FormatException("Invalid Parsing Currency");

    if (value.length <= SCALE) {
      while (value.length < SCALE) value = value + '0';
      return BigInt.parse(value);
    }

    // value.length > SCALE
    var dv = BigInt.parse(value.substring(0, SCALE));
    //if (dv < BigInt.zero) throw FormatException("Invalid Parsing Currency");

    int cu = value.codeUnitAt(SCALE);
    if (cu >= 53 && cu <= 57) dv = dv + BigInt.one;

    return dv;
  }

  ///
  /// Convert Currency to string with full 4 decimal places
  ///
  @override
  String toString() {
    var st = _value.toString();
    if (st.length <= SCALE) {
      while (st.length < SCALE) st = '0' + st;
      return '0.' + st;
    }

    // length > SCALE
    var n = st.length - SCALE;
    return st.substring(0, n) + '.' + st.substring(n);
  }

  ///
  /// Operator +
  ///
  Currency operator +(Currency other) {
    BigInt x = _value + other._value;
    return new Currency._fromValue(x);
  }

  ///
  /// Operator -
  ///
  Currency operator -(Currency other) {
    BigInt x = _value - other._value;
    return new Currency._fromValue(x);
  }

  ///
  /// Operator *
  ///
  Currency operator *(Currency other) {
    //var M = pow(10, SCALE);

    BigInt x = _value * other._value;
    x = _roundx(x, _MULTIPLIER);
    return new Currency._fromValue(x);
  }

  //
  // _roundx
  //
  BigInt _roundx(BigInt value, int rounder) {
    BigInt MTP = BigInt.from(rounder);
    BigInt HMTP = BigInt.from(rounder / 2);
    if (value.remainder(MTP) >= HMTP) {
      return (value ~/ MTP) + BigInt.from(1);
    }
    return value ~/ MTP;
  }

  ///
  /// Operator /
  ///
  Currency operator /(Currency other) {
    BigInt MTP10 = BigInt.from(_MULTIPLIER * 10);
    BigInt x = (_value * MTP10) ~/ other._value;
    x = _roundx(x, 10);
    return new Currency._fromValue(x);
  }

  ///
  /// Operator ==
  ///
  @override
  bool operator ==(Object other) {
    if (!(other is Currency)) return false;

    return (this._value == other._value);
  }

  ///
  /// Operator <
  ///
  bool operator <(Currency other) {
    return (this._value < other._value);
  }

  ///
  /// Operator <=
  ///
  bool operator <=(Currency other) {
    return (this._value <= other._value);
  }

  ///
  /// Operator >
  ///
  bool operator >(Currency other) {
    return (this._value > other._value);
  }

  ///
  /// Operator >=
  ///
  bool operator >=(Currency other) {
    return (this._value >= other._value);
  }

  ///
  /// Compares this object to another object
  ///
  /// Returns (-1) if `this` is ordered before [other], returns (+1) if `this` is ordered after [other], and returns (0) if `this` and [other] are ordered together
  ///
  @override
  int compareTo(Currency other) {
    if (this._value < other._value)
      return -1;
    else if (this._value > other._value)
      return 1;
    else
      return 0;
  }

  ///
  /// Returns the absolute value of `this`
  ///
  Currency abs() {
    if (_value >= BigInt.from(0)) {
      return Currency._fromValue(_value);
    } else {
      return Currency._fromValue(-_value);
    }
  }

  ///
  /// Returns the greatest `Currency` having integer value no greater than `this`
  ///
  Currency floor() {
    BigInt MTP = BigInt.from(_MULTIPLIER);
    return Currency._fromValue(_value * MTP);
  }

  ///
  /// Returns the least `Currency` having integer components no smaller than `this`
  ///
  Currency ceil() {
    BigInt MTP = BigInt.from(_MULTIPLIER);
    if (_value.remainder(MTP) == 0) {
      return Currency._fromValue(_value);
    }

    BigInt x = ((_value ~/ MTP) + BigInt.from(1)) * MTP;
    return Currency._fromValue(x);
  }

  ///
  /// Returns the integer closest to `this`
  ///
  Currency round() {
    BigInt x = _roundx(_value, _MULTIPLIER);
    return new Currency._fromValue(x);
  }

  ///
  /// Make sure `this` is between [lo] and [hi]
  ///
  /// Return [lo] if `this` is smaller than [lo], return [hi] if `this` is bigger than [hi], otherwise return `this`
  ///
  Currency clamp(Currency lo, Currency hi) {
    if (lo._value > hi._value) {
      var tt = lo;
      lo = hi;
      hi = tt;
    }

    if (this._value >= hi._value) {
      return Currency._fromValue(hi._value);
    }

    if (this._value <= lo._value) {
      return Currency._fromValue(lo._value);
    }

    return Currency._fromValue(this._value);
  }

  BigInt getValue() {
    return this._value;
  }
}
