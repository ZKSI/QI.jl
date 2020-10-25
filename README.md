[![](https://img.shields.io/badge/docs-latest-green.svg)](https://iitis.github.io/QuantumInformation.jl/latest)
[![Build Status](https://travis-ci.org/iitis/QuantumInformation.jl.svg?branch=master)](https://travis-ci.org/iitis/QuantumInformation.jl)
[![Coverage Status](https://coveralls.io/repos/github/iitis/QuantumInformation.jl/badge.svg?branch=master)](https://coveralls.io/github/iitis/QuantumInformation.jl?branch=master)
[![DOI](https://zenodo.org/badge/23916883.svg)](https://zenodo.org/badge/latestdoi/23916883)
# QuantumInformation

A Julia package for numerical computation in quantum information theory. [Published in PLoS ONE](https://doi.org/10.1371/journal.pone.0209358).

Numerical investigations are prevalent in quantum information theory. Numerical experiments can be used to find counter examples for theorems, to test hypotheses or to gain insight about quantum objects and operations.

Our goal while designing **QuantumInformation.jl** library was to follow principles presented in book "Geometry of Quantum States'' [1]. We work with column vectors reprinting kets and row vectors representing bras. We fix our basis to the computational one. Density matrices and quantum channels are represented as two dimensional arrays in the same fixed basis. This approach allows us to obtain low level complexity of our code, high flexibility and good computational efficiency. The design choices where highly motivated by the properties of the language in which the our library was implemented, namely
[Julia](https://julialang.org/) [2].

## Package features
The purpose of **QuantumInformation.jl** library is to provide
functions to:
* creating and analyzing quantum
states,
* manipulating them with quantum channels
* calculating functionals on these objects, *i.e. trace norm, diamond norm, entropy, fidelity*,
* application of random matrix theory in quantum
information processing.

## How to cite

    @article{Gawron2018,
      doi = {10.1371/journal.pone.0209358},
      url = {https://doi.org/10.1371/journal.pone.0209358},
      year  = {2018},
      month = {dec},
      publisher = {Public Library of Science ({PLoS})},
      volume = {13},
      number = {12},
      pages = {e0209358},
      author = {Piotr Gawron and Dariusz Kurzyk and {\L}ukasz Pawela},
      editor = {Nicholas Chancellor},
      title = {{QuantumInformation}.jl{\textemdash}A Julia package for numerical computation in quantum information theory},
      journal = {{PLOS} {ONE}}
    }

## [References](@id refs)

[1] I. Bengtsson, K. Życzkowski, *Geometry of Quantum States: An Introduction to Quantum Entanglement*, Cambridge University Press (2008).

[2] J. Bezanson, S. Karpinski, V. B. Shah, A. Edelman, *Julia: A fast dynamic language for technical computing*,
[preprint](https://arxiv.org/pdf/1209.5145.pdf).
