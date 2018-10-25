(** Logger module contains the top-level functor that provides logging
    operations. *)

open Consumers

(** Logger signature. *)
module type Logger = sig
  (** Logger type which wraps around some value. *)
  type 'a t

  (** Opens a region that can be logged by lifting a value up into the logging
      monad provided by flog. *)
  val start : 'a -> 'a t

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

      'Pass-through' logging. *)
  val (==|) : 'a t -> Message.t -> 'a t

  (** Taking a value already lifted into the logging monad and a function to
      construct a message from the wrapped value, apply the function to build a
      message, pass the message to the underlying consumer and pass along the log
      state.

      'Pass-in' logging. *)
  val (=|=) : 'a t -> ('a -> Message.t) -> 'a t

  (** When the region that needs to be logged is exited the log can be closed.
      The result of this is the value currently wrapped in the monad and the
      value of calling flush on the Consumer module that this functor was
      applied to possibly a collection of messages should state be maintained
      by the consumer. *)
  val stop : 'a t -> 'a * (Message.t list) option
end

(** Logger functor wraps around some message consumer. Therefore it is the
    responsibility of the consumer to actually handle the messages. The concern
    of the Logger is purely to arrange computations within the logging monad. *)
module ConsumerLogger (C : Consumer) : Logger
