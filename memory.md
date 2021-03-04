# Memory Structure
The following strings are saved in memory for i/o purposes:

address|string
---:|---
0|`"X"`
1|`"Y"`
2|`"."`
3|`"'s turn\n"`
11|`" wins!\n"`
18|`"> "`

Next, the following addresses are used for arguments to WASI functions:

address|parameter
---:|---
20|`iovs`
28|`nwritten`/`nread`

The tic-tac-toe game field itself follows:

address|cell
---:|---
32|a1
36|a2
40|a3
44|b1
48|b2
52|b3
56|c1
60|c2
64|c3

Which correspond like this to the board:

```
3 ...
2 ...
1 ...

  abc
```

Lastly, user input is stored beginning at address 68.
