(** Signature for the combinable message consumers which satisfy the monoid
    laws:
      - Closure: Combining two consumers results in a consumer.
      - Associativity: Must be guaranteed by implementation of the signature.
      - Identity: From the empty/new consumer. *)
module type Consumer = sig
  type t

  val empty : t

  val combine : t -> t -> t

  val consume : t -> string -> t
end

(** Simple message consumer which synchronously drops messages out onto the
    stdout stream. Given that consumption is synchronous there is no underlying
    state held in the consumer and combination is associative by design. *)
module ConsoleConsumer : Consumer