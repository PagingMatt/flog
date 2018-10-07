open Message

module type Consumer = sig
  type t

  val empty : t

  val combine : t -> t -> t

  val consume : t -> Message.t -> t
end

module ConsoleConsumer : Consumer = struct
  type t = unit

  let empty : t = ()

  let combine (_:t) (_:t) = ()

  let consume (c:t) (msg:Message.t) =
    print_string (Message.string_of_message msg); c
end
