# Package

version       = "0.1.0"
author        = "itsumura-h"
description   = "A new awesome nimble package"
license       = "MIT"


# Dependencies

requires "nim >= 1.6.4"
requires "jsbind >= 0.1.1"

task wasm, "wasm":
  exec "nim c -d:release -d:emscripten --gc:arc -o:wasm_module.js wasm_module.nim"
