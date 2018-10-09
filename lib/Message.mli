(** Message module encapsulates types and a constructor needed for log
    messages. *)

open Unix

(** The levels at which messages are logged. *)
type level =
  | Trace
  | Debug
  | Information
  | Warning
  | Error
  | Fatal

(** Message type. *)
type t

(** Constructor for the Message.t type. If no time is passed in then the
    current UTC time when called will be stamped onto the message.

    @return The message constructed of the parameters passed in. *)
val make : tm option -> level -> string -> t

(** Helper function to serialize messages.

    @return The serialized the message passed in.*)
val string_of_message : t -> string
