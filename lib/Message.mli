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

(** Compares two messages based on the time they were logged at. Ensures that
    more recent messages appear first.

    @return A negative [int] if [a] is greater than [b], [0] if they are equal
            and a positive [int] if [a] is less than [b].*)
val cmp_tm : t -> t -> int

(** Helper function to serialize messages.

    @return The serialized the message passed in.*)
val string_of_message : t -> string
