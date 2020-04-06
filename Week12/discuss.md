In bash, it's fairly easy to iterate over positional parameters.  You can simply say `for arg; do ...; done`.  This assumes you want everything in `$@`.

To demonstrate that you are indeed looping through `$1`, `$2`, through `$N`, you can use a loop like this:

```bash
#!/usr/bin/env bash

for ((i=1;i<=$#;i++)); do echo "${!i} "; done
```

The `${!i}` is known as indirect variable expansion - if we just said `echo $i` it would simply should use the value of `i` or the loop iterator variable.  We want instead to actually expand the corresponding positional parameter:

```
$ ./show-all.sh red green blue
red
green
blue
```

The handy shortcuts produce wordlists, which is just a list of words in text.  Text is the bread and butter of UNIX programming.  Accomplishing tasks in a UNIX environment generally consists of applying multiple small tools in a large pipeline, and the go-between for all these small tools is always text.  Each tool expects some text in to STDIN and will produce its result to STDOUT, ready to be further manipulated if need be.

For this reason, bash and other UNIX tools assume you will be operating on your data in text form, and thus makes it easy to do things like iterate over wordlists.  While bash does support arrays, often it will be easier to simply keep yor array of values in wordlist form and operate on that directly, which will likely differ from idioms you use in non-scripting work.

Works cited:

“Shell Parameter Expansion.” Bash Reference Manual, The Free Software Foundation, 12 May 2019, www.gnu.org/software/bash/manual/html_node/Shell-Parameter-Expansion.html.