# Redraw — Unsafe

`redraw_unsafe` provides functions to work with Redraw: helpers to work with
Context in a 100% unsafe way. You should **not** use this package unless you
**really** know what you're doing. Redraw takes care of everything for you and
ensures you're not shooting you in the foot. At contrary, Redraw Unsafe expects
you're React experts, understand how the runtimes works internally, and that
you're ready to read the source code of the packages you're using, to understand
how Redraw Unsafe can destroy your stack and get you fired.

## Installation

That package is not published on Hex, and will never be. Install it the way you
prefer, whether by copying the content or using it as a git dependency. You're
free to choose how you want to destroy your stack.
