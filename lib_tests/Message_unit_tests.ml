open Monoidl.Message
open Unix

let tm_a = gmtime 1514764801.0
let tm_b = gmtime 1514764802.0

let cmp_equal_zero () =
  let a = make (Some tm_a) Trace "Message A." in
  let b = make (Some tm_a) Trace "Message B." in
  Alcotest.(check int) "Checks that when cmp_tm is applied to messages with equal time, zero is returned."
      0 (cmp_tm a b)

let cmp_lt_positive () =
  let a = make (Some tm_a) Trace "Message A." in
  let b = make (Some tm_b) Trace "Message B." in
  Alcotest.(check int) "Checks that when cmp_tm is applied to an older message and a newer message the result is positive."
      1 (cmp_tm a b)

let cmp_gt_negative () =
  let a = make (Some tm_b) Trace "Message A." in
  let b = make (Some tm_a) Trace "Message B." in
  Alcotest.(check int) "Checks that when cmp_tm is applied to a newer message and an older message the result is negative."
      (-1) (cmp_tm a b)

let unit_tests = [
  ("Checks that when cmp_tm is applied to messages with equal time, zero is returned."                 , `Quick, cmp_equal_zero );
  ("Checks that when cmp_tm is applied to an older message and a newer message the result is positive.", `Quick, cmp_lt_positive);
  ("Checks that when cmp_tm is applied to a newer message and an older message the result is negative.", `Quick, cmp_gt_negative);
]