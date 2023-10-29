# ob-C-stdin

Support the standard input header argument `:stdin <element-name>` for Org Babel code blocks in C/C++/D, e.g.:

```org
#+name: who
world

#+begin_src C :stdin who :results output
#include <stdio.h>

int main(int argc, char *argv[]) {
  printf("hello, ");
  char c;
  while ((c=getchar()) != EOF) putchar(c);
  return 0;
}
#+end_src

#+RESULTS:
: hello, world
```

## Install

Add `ob-C-stdin.el` to your `load-path`, or use a package manager like `use-package` w/ `quelpa`:

```elisp
(use-package ob-C-stdin
    :quelpa (ob-C-stdin :fetcher github :repo "cxa/ob-C-stdin"))
```
