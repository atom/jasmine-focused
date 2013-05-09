# Jasmine Focused Node Module

Adds global functions to run only certain
[Jasmine](https://github.com/pivotal/jasmine) specs.

The number of `f` characters in the method name denotes the
priority of a `describe` or `it` spec.

For example, a `fit` specs would be run instead of any `it` specs and a
`ffit` spec would be run instead of any `fit` or `it` specs.

This module included a `jasmine-focused` executable that wraps `jasmine-node`
allowing you to use the focus functions without adding any additional requires
to your spec files.

## Spec functions

  * `fit`
  * `ffit`
  * `fffit`
  * `fdescribe`
  * `ffdescribe`
  * `fffdescribe`
