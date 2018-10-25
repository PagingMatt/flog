open Flog.Logger
open Flog.Message
open Unix

include ConsumerLogger(TestConsumers.ListConsumer)

let tm_a = gmtime 1514764801.0

let start_stop_symmetric () =
  let i = 42 in i
  |> start
  |> stop
  |> fun (j,_) ->
    Alcotest.(check int) "Checks the symmetry between Logger.start and Logger.stop."
      i j

let stop_returns_consumer_flush () =
  let msg = make (Some tm_a) Trace "Message." in 42
  |> start
  ==| make (Some tm_a) Trace "Message."
  |> stop
  |> fun (_,ms) ->
    match ms with
    | Some (m::[]) ->
      Alcotest.(check int) "Checks that Logger.stop returns result of Consumer.flush."
        0 (cmp_tm msg m)
    | _ -> Alcotest.fail "Flushed state does not match expected pattern."


let unit_tests = [
  ("Checks the symmetry between Logger.start and Logger.stop.", `Quick, start_stop_symmetric       );
  ("Checks that Logger.stop returns result of Consumer.flush.", `Quick, stop_returns_consumer_flush);
]
