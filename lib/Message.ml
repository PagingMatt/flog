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
end