open Unix

(** Message module encapsulates types and a constructor needed for log
    messages. *)
module Message : sig
  (** Message type. *)
  type t

  (** Logging levels. *)
  type level =
    | Trace
    | Debug
    | Information
    | Warning
    | Error
    | Fatal

  (** Constructor for the Message.t type. If no time is passed in then the
      current UTC time when called will be stamped onto the message. *)
  val make : Level -> tm option -> string -> t
end