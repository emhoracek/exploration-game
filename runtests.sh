#!/bin/zsh

runhaskell -itest-suite/ -itest-suite/librarySpec -itest-suite/executableSpec -iexecutable -ilibrary test-suite/Spec.hs
echo "HPC tests:"
hpc report tests.tix
