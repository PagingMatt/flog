open Unix

module Message : sig
  type level =
    | Trace
    | Debug
    | Information
    | Warning
    | Error
    | Fatal

  type t

  val make : tm option -> level -> string -> t

  val string_of_message : t -> string
end = struct
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
    Printf.sprintf "%d-%d-%dT%d:%d:%dZ"
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

  let string_of_message (time,lvl,msg) =
    let serialized_tm  = string_of_time time in
    let serialized_lvl = string_of_level lvl in
    Printf.sprintf "%s - [%s]: %s\n" serialized_tm serialized_lvl msg
end