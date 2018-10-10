open Flog
open Flog.Consumers

module ListConsumer : Consumer = struct
  type t = Message.t list

  let empty : t = []

  let combine (a:t) (b:t) =
    List.merge Message.cmp_tm a b

  let consume (c:t) (msg:Message.t) =
    msg :: c

  let flush (c:t) = Some c
end