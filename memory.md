# Memory Structure
The following strings are saved in memory for i/o purposes:

address|string
---:|---
0|`"."`
1|`"X"`
2|`"O"`
3|`"\n"`
4|`"3 "`
6|`"2 "`
8|`"1 "`
10|`"  abc\n"`
16|`"'s turn\n"`
24|`" wins!\n"`
31|`"It's a tie!\n"`
43|`">"`

Next, the following addresses are used for arguments to WASI functions:

address|parameter
---:|---
44|`iovs`
52|`nwritten`/`nread`

The tic-tac-toe game field itself follows:

address|cell
---:|---
56|a1
60|a2
64|a3
68|b1
72|b2
76|b3
80|c1
84|c2
88|c3

Which correspond like this to the board:

```
3 ...
2 ...
1 ...
  abc
```

Lastly, user input is stored beginning at address 92.
