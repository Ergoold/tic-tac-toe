(module
  ;; fd, *iovs, iovs_len, nwritten -> nwritten
  (import "wasi_unstable" "fd_write" (func $fd_write (param i32 i32 i32 i32) (result i32)))
  ;; fd, *iovs, iovs_len, nread -> nread
  (import "wasi_unstable" "fd_read" (func $fd_read (param i32 i32 i32 i32) (result i32)))
  ;; declare a memory page
  (memory (export "memory") 1)
  ;; constant strings
  (data (i32.const 0) "X") ;; length 1
  (data (i32.const 1) "Y") ;; length 1
  (data (i32.const 2) ".") ;; length 1
  (data (i32.const 3) "'s turn\n") ;; length 8
  (data (i32.const 11) " wins!\n") ;; length 7
  (data (i32.const 18) "> ") ;; length 2
  ;; wasi i/o function wrappers
  ;; *str, len ->
  (func $write (param i32 i32)
    i32.const 20
    local.get 0
    i32.store
    i32.const 24
    local.get 1
    i32.store
    i32.const 1
    i32.const 20
    i32.const 1
    i32.const 28
    call $fd_write
    drop))
