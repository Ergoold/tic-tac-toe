# Memory Structure
The following strings are saved in memory for i/o purposes:

address|string
---:|---
0|`"."`
1|`"X"`
2|`"Y"`
3|`"\n"`
4|`"3 "`
6|`"2 "`
8|`"1 "`
11|`"  abc\n"`
16|`"'s turn\n"`
24|`" wins!\n"`
31|`">"`

Next, the following addresses are used for arguments to WASI functions:

address|parameter
---:|---
32|`iovs`
40|`nwritten`/`nread`

The tic-tac-toe game field itself follows:

address|cell
---:|---
44|a1
48|a2
52|a3
56|b1
60|b2
64|b3
68|c1
72|c2
76|c3

Which correspond like this to the board:

```
3 ...
2 ...
1 ...

  abc
```

Lastly, user input is stored beginning at address 80.
