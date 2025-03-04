// RUN: mlir-opt %s -arith-expand -split-input-file | FileCheck %s

// Test ceil divide with signed integer
// CHECK-LABEL:       func @ceildivi
// CHECK-SAME:     ([[ARG0:%.+]]: i32, [[ARG1:%.+]]: i32) -> i32 {
func.func @ceildivi(%arg0: i32, %arg1: i32) -> (i32) {
  %res = arith.ceildivsi %arg0, %arg1 : i32
  return %res : i32

// CHECK:           [[ONE:%.+]] = arith.constant 1 : i32
// CHECK:           [[ZERO:%.+]] = arith.constant 0 : i32
// CHECK:           [[MINONE:%.+]] = arith.constant -1 : i32
// CHECK:           [[CMP1:%.+]] = arith.cmpi sgt, [[ARG1]], [[ZERO]] : i32
// CHECK:           [[X:%.+]] = arith.select [[CMP1]], [[MINONE]], [[ONE]] : i32
// CHECK:           [[TRUE1:%.+]] = arith.addi [[X]], [[ARG0]] : i32
// CHECK:           [[TRUE2:%.+]] = arith.divsi [[TRUE1]], [[ARG1]] : i32
// CHECK:           [[TRUE3:%.+]] = arith.addi [[ONE]], [[TRUE2]] : i32
// CHECK:           [[FALSE1:%.+]] = arith.subi [[ZERO]], [[ARG0]] : i32
// CHECK:           [[FALSE2:%.+]] = arith.divsi [[FALSE1]], [[ARG1]] : i32
// CHECK:           [[FALSE3:%.+]] = arith.subi [[ZERO]], [[FALSE2]] : i32
// CHECK:           [[NNEG:%.+]] = arith.cmpi slt, [[ARG0]], [[ZERO]] : i32
// CHECK:           [[NPOS:%.+]] = arith.cmpi sgt, [[ARG0]], [[ZERO]] : i32
// CHECK:           [[MNEG:%.+]] = arith.cmpi slt, [[ARG1]], [[ZERO]] : i32
// CHECK:           [[MPOS:%.+]] = arith.cmpi sgt, [[ARG1]], [[ZERO]] : i32
// CHECK:           [[TERM1:%.+]] = arith.andi [[NNEG]], [[MNEG]] : i1
// CHECK:           [[TERM2:%.+]] = arith.andi [[NPOS]], [[MPOS]] : i1
// CHECK:           [[CMP2:%.+]] = arith.ori [[TERM1]], [[TERM2]] : i1
// CHECK:           [[RES:%.+]] = arith.select [[CMP2]], [[TRUE3]], [[FALSE3]] : i32
}

// -----

// Test ceil divide with index type
// CHECK-LABEL:       func @ceildivi_index
// CHECK-SAME:     ([[ARG0:%.+]]: index, [[ARG1:%.+]]: index) -> index {
func.func @ceildivi_index(%arg0: index, %arg1: index) -> (index) {
  %res = arith.ceildivsi %arg0, %arg1 : index
  return %res : index

// CHECK:           [[ONE:%.+]] = arith.constant 1 : index
// CHECK:           [[ZERO:%.+]] = arith.constant 0 : index
// CHECK:           [[MINONE:%.+]] = arith.constant -1 : index
// CHECK:           [[CMP1:%.+]] = arith.cmpi sgt, [[ARG1]], [[ZERO]] : index
// CHECK:           [[X:%.+]] = arith.select [[CMP1]], [[MINONE]], [[ONE]] : index
// CHECK:           [[TRUE1:%.+]] = arith.addi [[X]], [[ARG0]] : index
// CHECK:           [[TRUE2:%.+]] = arith.divsi [[TRUE1]], [[ARG1]] : index
// CHECK:           [[TRUE3:%.+]] = arith.addi [[ONE]], [[TRUE2]] : index
// CHECK:           [[FALSE1:%.+]] = arith.subi [[ZERO]], [[ARG0]] : index
// CHECK:           [[FALSE2:%.+]] = arith.divsi [[FALSE1]], [[ARG1]] : index
// CHECK:           [[FALSE3:%.+]] = arith.subi [[ZERO]], [[FALSE2]] : index
// CHECK:           [[NNEG:%.+]] = arith.cmpi slt, [[ARG0]], [[ZERO]] : index
// CHECK:           [[NPOS:%.+]] = arith.cmpi sgt, [[ARG0]], [[ZERO]] : index
// CHECK:           [[MNEG:%.+]] = arith.cmpi slt, [[ARG1]], [[ZERO]] : index
// CHECK:           [[MPOS:%.+]] = arith.cmpi sgt, [[ARG1]], [[ZERO]] : index
// CHECK:           [[TERM1:%.+]] = arith.andi [[NNEG]], [[MNEG]] : i1
// CHECK:           [[TERM2:%.+]] = arith.andi [[NPOS]], [[MPOS]] : i1
// CHECK:           [[CMP2:%.+]] = arith.ori [[TERM1]], [[TERM2]] : i1
// CHECK:           [[RES:%.+]] = arith.select [[CMP2]], [[TRUE3]], [[FALSE3]] : index
}

// -----

// Test floor divide with signed integer
// CHECK-LABEL:       func @floordivi
// CHECK-SAME:     ([[ARG0:%.+]]: i32, [[ARG1:%.+]]: i32) -> i32 {
func.func @floordivi(%arg0: i32, %arg1: i32) -> (i32) {
  %res = arith.floordivsi %arg0, %arg1 : i32
  return %res : i32
// CHECK:           [[ONE:%.+]] = arith.constant 1 : i32
// CHECK:           [[ZERO:%.+]] = arith.constant 0 : i32
// CHECK:           [[MIN1:%.+]] = arith.constant -1 : i32
// CHECK:           [[CMP1:%.+]] = arith.cmpi slt, [[ARG1]], [[ZERO]] : i32
// CHECK:           [[X:%.+]] = arith.select [[CMP1]], [[ONE]], [[MIN1]] : i32
// CHECK:           [[TRUE1:%.+]] = arith.subi [[X]], [[ARG0]] : i32
// CHECK:           [[TRUE2:%.+]] = arith.divsi [[TRUE1]], [[ARG1]] : i32
// CHECK:           [[TRUE3:%.+]] = arith.subi [[MIN1]], [[TRUE2]] : i32
// CHECK:           [[FALSE:%.+]] = arith.divsi [[ARG0]], [[ARG1]] : i32
// CHECK:           [[NNEG:%.+]] = arith.cmpi slt, [[ARG0]], [[ZERO]] : i32
// CHECK:           [[NPOS:%.+]] = arith.cmpi sgt, [[ARG0]], [[ZERO]] : i32
// CHECK:           [[MNEG:%.+]] = arith.cmpi slt, [[ARG1]], [[ZERO]] : i32
// CHECK:           [[MPOS:%.+]] = arith.cmpi sgt, [[ARG1]], [[ZERO]] : i32
// CHECK:           [[TERM1:%.+]] = arith.andi [[NNEG]], [[MPOS]] : i1
// CHECK:           [[TERM2:%.+]] = arith.andi [[NPOS]], [[MNEG]] : i1
// CHECK:           [[CMP2:%.+]] = arith.ori [[TERM1]], [[TERM2]] : i1
// CHECK:           [[RES:%.+]] = arith.select [[CMP2]], [[TRUE3]], [[FALSE]] : i32
}

// -----

// Test floor divide with index type
// CHECK-LABEL:       func @floordivi_index
// CHECK-SAME:     ([[ARG0:%.+]]: index, [[ARG1:%.+]]: index) -> index {
func.func @floordivi_index(%arg0: index, %arg1: index) -> (index) {
  %res = arith.floordivsi %arg0, %arg1 : index
  return %res : index
// CHECK:           [[ONE:%.+]] = arith.constant 1 : index
// CHECK:           [[ZERO:%.+]] = arith.constant 0 : index
// CHECK:           [[MIN1:%.+]] = arith.constant -1 : index
// CHECK:           [[CMP1:%.+]] = arith.cmpi slt, [[ARG1]], [[ZERO]] : index
// CHECK:           [[X:%.+]] = arith.select [[CMP1]], [[ONE]], [[MIN1]] : index
// CHECK:           [[TRUE1:%.+]] = arith.subi [[X]], [[ARG0]] : index
// CHECK:           [[TRUE2:%.+]] = arith.divsi [[TRUE1]], [[ARG1]] : index
// CHECK:           [[TRUE3:%.+]] = arith.subi [[MIN1]], [[TRUE2]] : index
// CHECK:           [[FALSE:%.+]] = arith.divsi [[ARG0]], [[ARG1]] : index
// CHECK:           [[NNEG:%.+]] = arith.cmpi slt, [[ARG0]], [[ZERO]] : index
// CHECK:           [[NPOS:%.+]] = arith.cmpi sgt, [[ARG0]], [[ZERO]] : index
// CHECK:           [[MNEG:%.+]] = arith.cmpi slt, [[ARG1]], [[ZERO]] : index
// CHECK:           [[MPOS:%.+]] = arith.cmpi sgt, [[ARG1]], [[ZERO]] : index
// CHECK:           [[TERM1:%.+]] = arith.andi [[NNEG]], [[MPOS]] : i1
// CHECK:           [[TERM2:%.+]] = arith.andi [[NPOS]], [[MNEG]] : i1
// CHECK:           [[CMP2:%.+]] = arith.ori [[TERM1]], [[TERM2]] : i1
// CHECK:           [[RES:%.+]] = arith.select [[CMP2]], [[TRUE3]], [[FALSE]] : index
}

// -----

// Test ceil divide with unsigned integer
// CHECK-LABEL:       func @ceildivui
// CHECK-SAME:     ([[ARG0:%.+]]: i32, [[ARG1:%.+]]: i32) -> i32 {
func.func @ceildivui(%arg0: i32, %arg1: i32) -> (i32) {
  %res = arith.ceildivui %arg0, %arg1 : i32
  return %res : i32
// CHECK:           [[ZERO:%.+]] = arith.constant 0 : i32
// CHECK:           [[ISZERO:%.+]] = arith.cmpi eq, %arg0, [[ZERO]] : i32
// CHECK:           [[ONE:%.+]] = arith.constant 1 : i32
// CHECK:           [[SUB:%.+]] = arith.subi %arg0, [[ONE]] : i32
// CHECK:           [[DIV:%.+]] = arith.divui [[SUB]], %arg1 : i32
// CHECK:           [[REM:%.+]] = arith.addi [[DIV]], [[ONE]] : i32
// CHECK:           [[RES:%.+]] = arith.select [[ISZERO]], [[ZERO]], [[REM]] : i32
}

// -----

// Test unsigned ceil divide with index
// CHECK-LABEL:       func @ceildivui_index
// CHECK-SAME:     ([[ARG0:%.+]]: index, [[ARG1:%.+]]: index) -> index {
func.func @ceildivui_index(%arg0: index, %arg1: index) -> (index) {
  %res = arith.ceildivui %arg0, %arg1 : index
  return %res : index
// CHECK:           [[ZERO:%.+]] = arith.constant 0 : index
// CHECK:           [[ISZERO:%.+]] = arith.cmpi eq, %arg0, [[ZERO]] : index
// CHECK:           [[ONE:%.+]] = arith.constant 1 : index
// CHECK:           [[SUB:%.+]] = arith.subi %arg0, [[ONE]] : index
// CHECK:           [[DIV:%.+]] = arith.divui [[SUB]], %arg1 : index
// CHECK:           [[REM:%.+]] = arith.addi [[DIV]], [[ONE]] : index
// CHECK:           [[RES:%.+]] = arith.select [[ISZERO]], [[ZERO]], [[REM]] : index
}

// -----

// CHECK-LABEL: func @maxf
func.func @maxf(%a: f32, %b: f32) -> f32 {
  %result = arith.maxf %a, %b : f32
  return %result : f32
}
// CHECK-SAME: %[[LHS:.*]]: f32, %[[RHS:.*]]: f32)
// CHECK-NEXT: %[[CMP:.*]] = arith.cmpf ugt, %[[LHS]], %[[RHS]] : f32
// CHECK-NEXT: %[[SELECT:.*]] = arith.select %[[CMP]], %[[LHS]], %[[RHS]] : f32
// CHECK-NEXT: %[[IS_NAN:.*]] = arith.cmpf uno, %[[RHS]], %[[RHS]] : f32
// CHECK-NEXT: %[[RESULT:.*]] = arith.select %[[IS_NAN]], %[[RHS]], %[[SELECT]] : f32
// CHECK-NEXT: return %[[RESULT]] : f32

// -----

// CHECK-LABEL: func @maxf_vector
func.func @maxf_vector(%a: vector<4xf16>, %b: vector<4xf16>) -> vector<4xf16> {
  %result = arith.maxf %a, %b : vector<4xf16>
  return %result : vector<4xf16>
}
// CHECK-SAME: %[[LHS:.*]]: vector<4xf16>, %[[RHS:.*]]: vector<4xf16>)
// CHECK-NEXT: %[[CMP:.*]] = arith.cmpf ugt, %[[LHS]], %[[RHS]] : vector<4xf16>
// CHECK-NEXT: %[[SELECT:.*]] = arith.select %[[CMP]], %[[LHS]], %[[RHS]]
// CHECK-NEXT: %[[IS_NAN:.*]] = arith.cmpf uno, %[[RHS]], %[[RHS]] : vector<4xf16>
// CHECK-NEXT: %[[RESULT:.*]] = arith.select %[[IS_NAN]], %[[RHS]], %[[SELECT]]
// CHECK-NEXT: return %[[RESULT]] : vector<4xf16>

// -----

// CHECK-LABEL: func @minf
func.func @minf(%a: f32, %b: f32) -> f32 {
  %result = arith.minf %a, %b : f32
  return %result : f32
}
// CHECK-SAME: %[[LHS:.*]]: f32, %[[RHS:.*]]: f32)
// CHECK-NEXT: %[[CMP:.*]] = arith.cmpf ult, %[[LHS]], %[[RHS]] : f32
// CHECK-NEXT: %[[SELECT:.*]] = arith.select %[[CMP]], %[[LHS]], %[[RHS]] : f32
// CHECK-NEXT: %[[IS_NAN:.*]] = arith.cmpf uno, %[[RHS]], %[[RHS]] : f32
// CHECK-NEXT: %[[RESULT:.*]] = arith.select %[[IS_NAN]], %[[RHS]], %[[SELECT]] : f32
// CHECK-NEXT: return %[[RESULT]] : f32


// -----

// CHECK-LABEL: func @maxsi
func.func @maxsi(%a: i32, %b: i32) -> i32 {
  %result = arith.maxsi %a, %b : i32
  return %result : i32
}
// CHECK-SAME: %[[LHS:.*]]: i32, %[[RHS:.*]]: i32)
// CHECK-NEXT: %[[CMP:.*]] = arith.cmpi sgt, %[[LHS]], %[[RHS]] : i32

// -----

// CHECK-LABEL: func @minsi
func.func @minsi(%a: i32, %b: i32) -> i32 {
  %result = arith.minsi %a, %b : i32
  return %result : i32
}
// CHECK-SAME: %[[LHS:.*]]: i32, %[[RHS:.*]]: i32)
// CHECK-NEXT: %[[CMP:.*]] = arith.cmpi slt, %[[LHS]], %[[RHS]] : i32


// -----

// CHECK-LABEL: func @maxui
func.func @maxui(%a: i32, %b: i32) -> i32 {
  %result = arith.maxui %a, %b : i32
  return %result : i32
}
// CHECK-SAME: %[[LHS:.*]]: i32, %[[RHS:.*]]: i32)
// CHECK-NEXT: %[[CMP:.*]] = arith.cmpi ugt, %[[LHS]], %[[RHS]] : i32


// -----

// CHECK-LABEL: func @minui
func.func @minui(%a: i32, %b: i32) -> i32 {
  %result = arith.minui %a, %b : i32
  return %result : i32
}
// CHECK-SAME: %[[LHS:.*]]: i32, %[[RHS:.*]]: i32)
// CHECK-NEXT: %[[CMP:.*]] = arith.cmpi ult, %[[LHS]], %[[RHS]] : i32

// -----

// CHECK-LABEL: @static_basis
//  CHECK-SAME:    (%[[IDX:.+]]: index)
//       CHECK:   arith.constant
//       CHECK:   arith.constant
//   CHECK-DAG:   %[[c224:.+]] = arith.constant 224 : index
//   CHECK-DAG:   %[[c50176:.+]] = arith.constant 50176 : index
//       CHECK:   %[[N:.+]] = arith.divui %[[IDX]], %[[c50176]] : index
//       CHECK:   %[[RES:.+]] = arith.remui %[[IDX]], %[[c50176]] : index
//       CHECK:   %[[P:.+]] = arith.divui %[[RES]], %[[c224]] : index
//       CHECK:   %[[Q:.+]] = arith.remui %[[RES]], %[[c224]] : index
//       CHECK:   return %[[N]], %[[P]], %[[Q]]
func.func @static_basis(%linear_index: index) -> (index, index, index) {
  %b0 = arith.constant 16 : index
  %b1 = arith.constant 224 : index
  %b2 = arith.constant 224 : index
  %1:3 = arith.delinearize_index %linear_index (%b0, %b1, %b2) : index, index, index
  return %1#0, %1#1, %1#2 : index, index, index
}
