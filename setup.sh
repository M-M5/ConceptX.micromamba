#! /bin/bash

# Allocate compute node with 4 CPUS on head node of pronto or nova
srun -N1 -n4 -t4:0:0 --pty bash

# # Ask user if they'd like to install ConceptX here or another location
# echo "Would you like to install ConceptX here or another location?"
# echo "1. Here"
# echo "2. Another location"
# read -p "Enter your choice: " choice
# if [choice == 1]
# then
#     echo "Installing at Current Work Directory"
#     location = $PWD
# else
#     read -p "Enter the absolute location where you'd like to install ConceptX: " location
#     cd /
#     cd $location
# fi

# Assuming this folder is cloned in the directory in which they'd like to install ConceptX
location = $PWD

echo "Creating workspace for ConceptX"
mkdir ConceptX_micromamba
cd ConceptX_micromamba


# Setting up where envionments will be installed
echo "Setting up micromamba root prefix"
mkdir micromamba, define MAMBA_ROOT_PREFIX
export MAMBA_ROOT_PREFIX=$location/ConceptX_micromamba/micromamba

# Download ConceptX.micromamba fork
echo "Cloning ConceptX"
module purge
module load git
git clone https://github.com/hsajjad/ConceptX

# Sets up root prefix for ConceptX
echo "Setting up ConceptX root prefix"
export CONCEPTX_ROOT=$location/ConceptX_micromamba/ConceptX


# Modify env_clustering and env_neurox yml files in ConceptX/get_clusters to install perl into environment
echo "Modifying yml files to install perl into environment"
cp -f $location/ConceptX_micromamba/ConceptX/get_clusters/env_clustering.yml $location/env_clustering.yml
cp -f $location/ConceptX_micromamba/ConceptX/get_clusters/env_neurox.yml $location/env_neurox.yml

# Create the two environments
echo "Creating the two environments"
cd $location/ConceptX_micromamba/Conceptx/get_clusters
micromamba env create -y --file=env_clustering.yml
eval "$(micromamba shell hook --shell=bash)"
micromamba activate clustering
which perl
which python
micromamba deactivate

micromamba env create -y --file=env_neurox.yml
eval "$(micromamba shell hook --shell=bash)"
micromamba activate neurox_pip
which perl
which python
micromamba deactivate

# # Setup is done!
# echo "Setup is done! Would you like me to run the demo?"
# echo "1. Yes"
# echo "2. No"
# read -p "Enter your choice: " choice
# if [choice == 1]
# then
#     echo "Running the demo"
    

