(module
  ;; fd, *iovs, iovs_len, nwritten -> nwritten
  (import "wasi_unstable" "fd_write" (func $fd_write (param i32 i32 i32 i32) (result i32)))
  ;; fd, *iovs, iovs_len, nread -> nread
  (import "wasi_unstable" "fd_read" (func $fd_read (param i32 i32 i32 i32) (result i32)))
  ;; declare a memory page
  (memory (export "memory") 1)
  ;; constant strings
  (data (i32.const 0) ".") ;; length 1
  (data (i32.const 1) "X") ;; length 1
  (data (i32.const 2) "O") ;; length 1
  (data (i32.const 3) "\n") ;; length 1
  (data (i32.const 4) "3 ") ;; length 2
  (data (i32.const 6) "2 ") ;; length 2
  (data (i32.const 8) "1 ") ;; length 2
  (data (i32.const 10) "  abc\n") ;; length 6
  (data (i32.const 16) "'s turn\n") ;; length 8
  (data (i32.const 24) " wins!\n") ;; length 7
  (data (i32.const 31) ">") ;; length 1
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
    drop)
  ;; get the address of a cell
  ;; row, col -> address
  (func $cell_addr (param i32 i32) (result i32)
    local.get 0
    i32.const 12
    i32.mul
    local.get 1
    i32.const 4
    i32.mul
    i32.add
    i32.const 28
    i32.add)
  ;; get/set the value of a cell (1-based)
  ;; row, col -> value
  (func $get (param i32 i32) (result i32)
    local.get 0
    local.get 1
    call $cell_addr
    i32.load)
  ;; row, col, val -> void
  (func $set (param i32 i32 i32)
    local.get 0
    local.get 1
    call $cell_addr
    local.get 2
    i32.store)
  ;; write the game board to the screen
  (func $write_board (local $row i32) (local $col i32)
    i32.const 1
    local.set $row
    i32.const 1
    local.set $col
    (block
      (loop
	local.get $row
	i32.const 4
	i32.eq
	br_if 1
	i32.const 2
	i32.const 2
	local.get $row
	i32.mul
	i32.add
        i32.const 2
        call $write
        (block
          (loop
	    local.get $col
            i32.const 4
            i32.eq
            br_if 1
            local.get $row
	    local.get $col
	    call $get
	    i32.const 1
	    call $write
	    local.get $col
	    i32.const 1
	    i32.add
	    local.set $col
	    br 0))
	i32.const 3
	i32.const 1
	call $write
	local.get $row
	i32.const 1
	i32.add
	local.set $row
	i32.const 1
	local.set $col
	br 0))
    i32.const 10
    i32.const 6
    call $write)
  (func $parse_letter (result i32)
    i32.const 80
    i32.load8_s
    i32.const 96
    i32.sub)
  (func $parse_number (result i32)
    ;; now you're thinking with portals
    i32.const 4
    i32.const 81
    i32.load8_s
    i32.const 48
    i32.sub
    i32.sub)
  (func $write_turn (param i32)
    local.get 0
    i32.const 1
    call $write
    i32.const 16
    i32.const 8
    call $write)
  (func $write_prompt
    i32.const 31
    i32.const 1
    call $write)
  (func $turn (param i32)
    call $write_board
    local.get 0
    call $write_turn
    call $write_prompt
    call $read
    call $parse_number
    call $parse_letter
    local.get 0
    call $set)
  (func (export "_start")
    i32.const 1
    call $turn
    i32.const 2
    call $turn
    call $write_board))
