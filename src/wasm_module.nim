import jsbind/emscripten, json

proc multiply*(x, y: int32): int32 {.EMSCRIPTEN_KEEPALIVE.} =
  return x * y

proc fiboNim*(n:int32):int32 {.EMSCRIPTEN_KEEPALIVE.} =
  if n < 2:
    return n
  return fiboNim(n-2) + fiboNim(n-1)
