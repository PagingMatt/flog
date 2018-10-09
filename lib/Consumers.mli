(** Signature for the combinable message consumers which satisfy the monoid
    laws:
      - Closure: Combining two consumers results in a consumer.
      - Associativity: Must be guaranteed by implementation of the signature.
      - Identity: From the empty/new consumer. *)
module type Consumer = sig
  (** Consumer type. *)
  type t

  (** Consumer identity value.

      @return An 'empty' or 'new' consumer which behaves as the identity value
              for the Consumer monoid. *)
  val empty : t

  (** Associative combiner function.

      @return The associative combination of the two Consumers. *)
  val combine : t -> t -> t

  (** Function to drive consumption of messages. 

      @return The consumer which is the result of the inital consumer consuming
              the message passed in. *)
  val consume : t -> Message.t -> t

  (** Contractually called when the logger is closed, this optionally can
      return the state held by the logger or can just be used to side-effect
      and guarantee the flushing of messages held in the consumer.

      @return The state inside the consumer if it exists. *)
  val flush : t -> (Message.t list) option
end

(** Simple message consumer which synchronously drops messages out onto the
    stdout stream. Given that consumption is synchronous there is no underlying
    state held in the consumer and combination is associative by design. *)
module ConsoleConsumer : Consumer
