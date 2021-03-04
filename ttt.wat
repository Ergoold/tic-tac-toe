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
  (data (i32.const 3) "\n") ;; length 1
  (data (i32.const 4) "3 ") ;; length 2
  (data (i32.const 6) "2 ") ;; length 2
  (data (i32.const 8) "1 ") ;; length 2
  (data (i32.const 10) "\nabc\n") ;; length 5
  (data (i32.const 15) "'s turn\n") ;; length 8
  (data (i32.const 23) " wins!\n") ;; length 7
  (data (i32.const 30) "> ") ;; length 2
  ;; wasi i/o function wrappers
  ;; *str, len -> void
  (func $write (param i32 i32)
    i32.const 32
    local.get 0
    i32.store
    i32.const 36
    local.get 1
    i32.store
    i32.const 1
    i32.const 32
    i32.const 1
    i32.const 40
    call $fd_write
    drop)
  ;; void -> void
  (func $read
    i32.const 32
    i32.const 80
    i32.store
    i32.const 36
    i32.const 256
    i32.store
    i32.const 0
    i32.const 32
    i32.const 1
    i32.const 40
    call $fd_read
    drop))
