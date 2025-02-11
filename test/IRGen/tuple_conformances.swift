// RUN: %target-swift-frontend -emit-ir -parse-stdlib -primary-file %s -enable-experimental-feature TupleConformances -parse-as-library | %FileCheck %s

// -enable-experimental-feature requires an asserts build
// REQUIRES: asserts

import Swift

protocol P {
  func defaultRequirement()
  static func staticRequirement()
}

extension P {
  func defaultRequirement() {}
}

extension Builtin.TheTupleType: P where repeat each Elements: P {
  static func staticRequirement() {}
}

func takesP<T: P>(_ t: T) {
  t.defaultRequirement()
  T.staticRequirement()
}

struct S: P {
  static func staticRequirement() {
    print(self)
  }
}

func use() {
  takesP(())
  takesP((S(), S()))
}

// CHECK-LABEL: define internal swiftcc void @"$sxxQp_t18tuple_conformances1PA2aBP18defaultRequirementyyFTW"(ptr {{.*}} swiftself %0, ptr %Self, ptr %SelfWitnessTable) {{.*}} {

// CHECK-LABEL: define internal swiftcc void @"$sxxQp_t18tuple_conformances1PA2aBP17staticRequirementyyFZTW"(ptr swiftself %0, ptr %Self, ptr %SelfWitnessTable) {{.*}} {

// CHECK-LABEL: define hidden swiftcc void @"$s18tuple_conformances3useyyF"() {{.*}} {
// CHECK: call ptr @"$s18tuple_conformances1SV_ACtxxQp_tAA1PAAWl"()
// CHECK: ret void

// CHECK-LABEL: define linkonce_odr hidden ptr @"$s18tuple_conformances1SV_ACtxxQp_tAA1PAAWl"() {{.*}} {


