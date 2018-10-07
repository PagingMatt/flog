open Consumer

(** Logger functor wraps around some message consumer. Therefore it is the
    responsibility of the consumer to actually handle the messages. The concern
    of the Logger is purely to arrange computations within the logging monad. *)
module Logger (C : Consumer) : sig
  (** Logger type. *)
  type 'a t

  (** Lift a value up into the logging monad. *)
  val return : 'a -> 'a t

  (** Taking a value already lifted into the logging monad, apply a function to
      the value and then lift the result into the monad. This performs no
      logging action and purely drives computation along. *)
  val (=>=) : 'a t -> ('a -> 'b) -> 'b t

  (** Taking a value already lifted into the logging monad and a function which
      does some other logging, apply the function to the value and then relying
      on the monoidal properties on the underlying message consumers combine
      the current state of the log (wrapped around the initial value) with the
      log state produced by the function. *)
  val (=>|) : 'a t -> ('a -> 'b t) -> 'b t

  (** Taking a value already lifted into the logging monad and a message to
      pass down the logging consumer, handle the message and pass along the log
      state.

      TODO: a Message.t should be broken out rather than this being a string. *)
  val (==|) : 'a t -> string -> 'a t
end
