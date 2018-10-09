open Consumer
open Message

module Logger (C : Consumer) : sig
  type 'a t

  val start : 'a -> 'a t

  val (=>=) : 'a t -> ('a -> 'b) -> 'b t

  val (=>|) : 'a t -> ('a -> 'b t) -> 'b t

  val (==|) : 'a t -> Message.t -> 'a t

  val stop : 'a t -> 'a * (Message.t list) option
end = struct
  type 'a t = 'a * C.t

  let start x = x,C.empty

  let (=>=) m f =
    match m with
    | x,c -> (f x),c

  let (=>|) m f =
    match m with
    | x,ca ->
      let y,cb = f x in
      y,(C.combine ca cb)

  let (==|) m msg =
    match m with
    | x,c -> x,(C.consume c msg)

  let stop (l:'a t) =
    match l with
    | x,c -> let ms = C.flush c in x,ms
end
