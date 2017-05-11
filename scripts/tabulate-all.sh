#!/bin/bash
#
# Copyright (C) 2017 Université Clermont Auvergne, CNRS/IN2P3, LPC
# Author: Valentin NIESS (niess@in2p3.fr)
#
# Generate the energy loss tabulations for all MDF files using `pumas-tabulate`.
# The material properties (Mean Excitation Energy and Sternheimer coefficients)
# are set according to the PDG tables.
#
# References:
# PDG, Atomic and Nuclear Properties of Materials,
# http://pdg.lbl.gov/2016/AtomicNuclearProperties/index.html

# Generate the energy loss tables for the `standard.xml MDF. Both muon and tau
# data are generated.`
for particle in tau muon; do
        # Configure the sampling.
        if [ "$particle" == "tau" ]; then
                sampling="--kinetic-min=1E+02 --kinetic-max=1E+12 -k 201"
        else
                sampling=""
        fi

        # Process the tables.
        echo ". Processing $particle in StandardRock."
        pumas-tabulate $particle mdf/standard.xml -m StandardRock -I 136.4 \
            -S "0.0830  3.4120  0.0492  3.0549  3.7738 0.00" \
            $sampling -f -o dedx/$particle

        echo ". Processing $particle in Water."
        pumas-tabulate $particle mdf/standard.xml -m Water -I 79.7 \
            -S "0.0912  3.4773  0.2400  2.8004   3.5017 0.00" \
            $sampling -f -o dedx/$particle

        echo ". Processing $particle in Air."
        pumas-tabulate $particle mdf/standard.xml -m Air -I 85.7 \
            -S "0.1091  3.3994  1.7418  4.2759  10.5961 0.00" \
            $sampling -f -o dedx/$particle
done

# Generate the energy loss tables for the `minerals.xml MDF.
echo ". Processing muon in Fluorite."
pumas-tabulate muon mdf/minerals.xml -m Fluorite -I 166.0 \
    -S "0.0694  3.5263  0.0676  3.1683  4.0653 0.00" -f -o dedx/muon

echo ". Processing muon in Halite."
pumas-tabulate muon mdf/minerals.xml -m Halite -I 175.3 \
    -S "0.1596  3.0000  0.1995  2.9995  4.4227 0.00" -f -o dedx/muon

echo ". Processing muon in Corundum."
pumas-tabulate muon mdf/minerals.xml -m Corundum -I 145.2 \
    -S "0.0850  3.5458  0.0402  2.8665  3.5682 0.00" -f -o dedx/muon

echo ". Processing muon in Hematite."
pumas-tabulate muon mdf/minerals.xml -m Hematite -I 227.3 \
    -S "0.1048  3.1313 -0.0074  3.2573  4.2245 0.00" -f -o dedx/muon

echo ". Processing muon in Calcite."
pumas-tabulate muon mdf/minerals.xml -m Calcite -I 136.4 \
    -S "0.0830  3.4120  0.0492  3.0549  3.7738 0.00" -f -o dedx/muon

echo ". Processing muon in Anhydrite."
pumas-tabulate muon mdf/minerals.xml -m Anhydrite -I 152.3 \
    -S "0.0771  3.4495  0.0587  3.1229  3.9388 0.00" -f -o dedx/muon

echo ". Processing muon in Quartz."
pumas-tabulate muon mdf/minerals.xml -m Quartz -I 139.2 \
    -S "0.0841  3.5064  0.1500  3.0140  4.0560 0.00" -f -o dedx/muon
