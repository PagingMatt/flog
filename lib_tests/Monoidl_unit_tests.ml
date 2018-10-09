let unit_test_suite = [
  ("Message unit tests", Message_unit_tests.unit_tests);
  ("Logger unit tests" , Logger_unit_tests.unit_tests );
]

let () =
  Alcotest.run "monoidl unit tests" unit_test_suite
