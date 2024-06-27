# Install ConceptX using Micromamba

This repo is a fork of ConceptX configured to be installed with Micromamba. Instructions are a modification from researchIT

## Getting Started
- Clone repo into desired work folder
- Allocate compute node with 4 CPUS on head node of pronto or nova
    $ srun -N1 -n4 -t4:0:0 --pty bash

- Run setup.sh script
  $ sh setup.sh

- Run getclusters.sh.micromamba
