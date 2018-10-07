open Unix

module Message : sig
  type t

  type level =
    | Trace
    | Debug
    | Information
    | Warning
    | Error
    | Fatal

  val make : Level -> tm option -> string -> t
end