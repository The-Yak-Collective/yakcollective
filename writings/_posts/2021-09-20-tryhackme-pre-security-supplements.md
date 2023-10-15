---
title: 'TryHackMe: Pre Security (Supplements)'
date: 2021-09-20 12:00:00.000000000 Z
layout: post-external
original_link: https://cardboard-iguana.com/log/2021-09-20-tryhackme-pre-security-supplements.html
author: 100007
---

# Bash Scripting

## Variables

Using the -x flag will force bash to output each line of the shell script you’re running before that line is executed. This can be useful for debugging.

```
bash -x ./script.sh
```

The -x flag can also be incorporated into the interpreter line.

```
#!/usr/bin/env bash -x

# Script content...
```

Finally, this mode can be toggled on and off with the `set` command within the script itself.

```
#!/usr/bin/env bash

# Some script content...

set -x

# These lines will be echoed before execution.

set +x

# These lines will not be echoed...
```

Frequently `set -x` is used at the start of a script without a closing `set + x`, which will just cause all lines of the script to be echoed back before execution.

## Parameters

The `read` command in bash will set the variable name supplied to whatever is provided on STDIN (presumably up to IFS). For example:

```
#!/usr/bin/env bash

echo -n "Enter something: ""

read INPUT

echo "You typed: $INPUT"
```

Will echo back whatever is typed in, prefixed by “You typed: “.

## Arrays

Bash actually does support arrays.

```
MY_ARRAY=('item0' 'item1' 'item2')
```

As the above example suggests, arrays are 0-indexed. Use @ to output the full (space-separated) array.

```
echo "$MY_ARRAY" # item0 (weird!)
echo "${MY_ARRAY[@]}" # item0 item1 item2
echo "${MY_ARRAY[1]}" # item1

unset MY_ARRAY[1]
echo "${MY_ARRAY[@]}" # item0 item2

# But be aware that this DOESN't change the index of any
# element!

echo "${MY_ARRAY[0]}" # item0
echo "${MY_ARRAY[1]}" # Outputs nothing...
echo "${MY_ARRAY[2]}" # item2

MY_ARRAY[0]="item3"
echo "${MY_ARRAY[@]}" # item3 item2

MY_ARRAY[3]="item4"
echo "${MY_ARRAY[@]}" # item3 item2 item4
```

