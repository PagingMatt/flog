open Unix

type level =
  | Trace
  | Debug
  | Information
  | Warning
  | Error
  | Fatal

type t = tm * level * string

let make time_opt lvl msg =
  let msg_time =
    match time_opt with
    | Some t -> t
    | None   -> time () |> gmtime
  in msg_time,lvl,msg

let string_of_time time =
  Printf.sprintf "%d-%d-%dT%02d:%02d:%02dZ"
    time.tm_year time.tm_mon time.tm_mday
    time.tm_hour time.tm_min time.tm_sec

let string_of_level lvl =
  match lvl with
  | Trace       -> "TRACE"
  | Debug       -> "DEBUG"
  | Information -> "INFORMATION"
  | Warning     -> "WARNING"
  | Error       -> "ERROR"
  | Fatal       -> "FATAL"

let cmp_tm (a,_,_) (b,_,_) =
  let a_tm,_ = mktime a in
  let b_tm,_ = mktime b in
  compare b_tm a_tm

let string_of_message (time,lvl,msg) =
  let serialized_tm  = string_of_time time in
  let serialized_lvl = string_of_level lvl in
  Printf.sprintf "%s - [%s]: %s\n" serialized_tm serialized_lvl msg
