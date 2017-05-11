# Materials for the PUMAS library
( **S**emi **A**nalytical **MU**ons -or taus- **P**ropagation, *backwards* )

## Description

This is a compilation of materials for the [PUMAS](http://niess.github.io/pumas/index.html)
library. It is divided into two components.

* **M**aterial **D**escription **F**iles (**MDF**), provided in the
  [mdf](mdf) directory. These files are coded in XML. A typical MDF file
  contains:
  * One or more atomic element and its properties: atomic number (**Z**),
    atomic mass (**A**) and mean excitation energy (**I**, eV).
  * One or more basic material built as a *microscopic* mixture of atomic
    elements.
  * Optionally, composite materials built as a *mesoscopic* mixture of basic
    materials. Note that due to the density effect in the ionisation loss
    those are not equivalent to a basic material with the same atomic
    composition.


* Energy loss tabulations are provided in the [dedx](dedx) directory, for
  each basic material. These tabulations have been generated with the
  `pumas-tabulate` executable. For muons, one can also use the whole set of
  tabulations provided online by the [PDG](http://pdg.lbl.gov/2016/AtomicNuclearProperties/index.html).
  Note however that those are slightly less accurate than PUMAS ones, above
  100 TeV.

## Usage

A standard initialisation of PUMAS requires to specify a MDF file and a
directory where the energy loss tabulations are read from. This can be done
by providing explicits paths, e.g.:
```c
pumas_initialise(PUMAS_PARTICLE_MUON, "mdf/standard.xml", "dedx/muon", NULL);
```
or by setting one or both of the `PUMAS_MDF` and `PUMAS_DEDX` environment
variables.

The initialisation of PUMAS can take a few seconds, depending on the number of
materials. The provided material data are converted to a set of binary tables
optimised for the simulation. These tables can be dumped with the
`pumas_dump` function. Then, they can be reloaded with `pumas_load`, skipping
the initialisation.

> Beware: the binary dump is not portable. It may vary from one system to
> another, e.g. 32 vs 64 bits.

## License
The PUMAS library is under the **GNU LGPLv3** license. See the provided
`LICENSE` and `COPYING.LESSER` files.
