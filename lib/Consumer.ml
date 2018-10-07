module type Consumer = sig
  type t

  val empty : t

  val combine : t -> t -> t

  val consume : t -> string -> t
end

module ConsoleConsumer : Consumer = struct
  type t = unit

  let empty : t = ()

  let combine (_:t) (_:t) = ()

  let consume (_:t) (msg:string) =
    print_string msg
end
