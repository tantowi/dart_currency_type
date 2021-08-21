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

import 'package:test/test.dart';
import 'package:currency/currency.dart';

void main() {
  test('test_constructor', test_constructor);
  test('test_from_1', test_from_1);
  test('test_from_2', test_from_2);
  test('test_from_3', test_from_3);
  test('test_from_4', test_from_4);
  test('test_from_5', test_from_5);
  test('test_from_6', test_from_6);
  test('test_from_7', test_from_7);
  test('test_from_8', test_from_8);

  test('test_from_10', test_from_10);
  test('test_from_11', test_from_11);
  test('test_from_12', test_from_12);
  test('test_from_13', test_from_13);
  test('test_from_14', test_from_14);
  test('test_from_15', test_from_15);

  test('test_parse_01', test_parse_01);
  test('test_parse_02', test_parse_02);
  test('test_parse_03', test_parse_03);
  test('test_parse_04', test_parse_04);
}

///
///
///
void test_constructor() {
  var c = Currency();
  var v = c.getValue();

  expect(v, equals(BigInt.zero));
}

///
void test_from_1() {
  var c = Currency.from(0);
  expect(c.getValue(), equals(BigInt.from(0)));
}

///
void test_from_2() {
  var c = Currency.from(1);
  expect(c.getValue(), equals(BigInt.from(10000)));
}

///
void test_from_3() {
  var c = Currency.from(-1);
  expect(c.getValue(), equals(BigInt.from(-10000)));
}

///
void test_from_4() {
  var c = Currency.from(1.5);
  expect(c.getValue(), equals(BigInt.from(15000)));
}

///
void test_from_5() {
  var c = Currency.from(-1.5);
  expect(c.getValue(), equals(BigInt.from(-15000)));
}

///
void test_from_6() {
  var c = Currency.from(123);
  expect(c.getValue(), equals(BigInt.from(1230000)));
}

///
void test_from_7() {
  var c = Currency.from(123456789);
  expect(c.getValue(), equals(BigInt.from(1234567890000)));
}

///
void test_from_8() {
  var c = Currency.from(123.45);
  expect(c.getValue(), equals(BigInt.from(1234500)));
}

///
void test_from_10() {
  var c = Currency.from(123.1);
  expect(c.getValue(), equals(BigInt.from(1231000)));
}

///
void test_from_11() {
  var c = Currency.from(123.12);
  expect(c.getValue(), equals(BigInt.from(1231200)));
}

///
void test_from_12() {
  var c = Currency.from(123.123);
  expect(c.getValue(), equals(BigInt.from(1231230)));
}

///
void test_from_13() {
  var c = Currency.from(123.1234);
  expect(c.getValue(), equals(BigInt.from(1231234)));
}

///
void test_from_14() {
  var c = Currency.from(123.12341);
  expect(c.getValue(), equals(BigInt.from(1231234)));
}

///
void test_from_15() {
  var c = Currency.from(123.12345);
  expect(c.getValue(), equals(BigInt.from(1231235)));
}

///
void test_parse_01() {
  var c = Currency.parse('123');
  expect(c.getValue(), equals(BigInt.from(1230000)));
}

///
void test_parse_02() {
  var c = Currency.parse('123.99999');
  expect(c.getValue(), equals(BigInt.from(1240000)));
}

///
void test_parse_03() {
  var c = Currency.parse('-123.99999');
  expect(c.getValue(), equals(BigInt.from(-1240000)));
}

///
void test_parse_04() {
  var c = Currency.parse('123.-123');
  expect(c.getValue(), equals(BigInt.from(0)));
}
