module AsyncM: Idl.RPCMONAD = struct
  type 'a m = 'a Async.Deferred.t
  type 'a box = { box: 'a m }
  type ('a, 'b) t = ('a, 'b) Result.result box

  type rpcfn = Rpc.call -> Rpc.response m

  let box x = { box=x }
  let unbox { box } = box
  let bind x f = Async.Deferred.bind x f
  let return x = Async.Deferred.return x
  let fail exn = raise exn
end

module AsyncIdl = Idl.Make(AsyncM)
include AsyncIdl