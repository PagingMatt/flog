open Consumer

module Logger (C : Consumer) : sig
  type 'a t

  val return : 'a -> 'a t

  val (=>=) : 'a t -> ('a -> 'b) -> 'b t

  val (=>|) : 'a t -> ('a -> 'b t) -> 'b t

  val (==|) : 'a t -> string -> 'a t
end = struct
  type 'a t = 'a * C.t

  let return x = x,C.empty

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
end
