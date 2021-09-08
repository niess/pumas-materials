# Materials data for the PUMAS library
( **S**emi **A**nalytical **MU**ons -or taus- **P**ropagation, *backwards* )

## Description

This is a compilation of materials data for the
[PUMAS](http://niess.github.io/pumas/index.html) library. It contains two type
of files:

* **M**aterial **D**escription **F**iles (**MDF**), located under the
  [mdf/elements](mdf/elements) and [mdf/materials](mdf/materials) directories.
  These files are coded in XML. The tags specific to MDFs are described in the
  [PUMAS
  documentation](https://pumas.readthedocs.io/en/latest/materials-description-files/).

  _The MDFs provided under [mdf/elements](mdf/elements) are incomplete since
  they do not define any material. They are provided as samples of atomic
  element entries._

* Stopping power tables are provided in the [dedx](dedx) directory. These tables
  have been generated with the PUMAS library.  For muons one can also use the
  tables provided online by the
  [PDG](https://pdg.lbl.gov/2020/AtomicNuclearProperties/index.html).  However,
  the latter are less accurate than PUMAS ones at high energy due to
  improvements on the cross-sections of radiative processes (see e.g.  [Sandrock
  _et
  al._](https://iopscience.iop.org/article/10.1088/1742-6596/1690/1/012005)).

## Usage

In order to use the MDF with PUMAS please refer to the [PUMAS
documentation](https://pumas.readthedocs.io/en/latest/).

_The stopping power tables are not needed anymore since PUMAS v1.1. They are
self-generated from the MDF at initialisation._

## License
The PUMAS library is under the **GNU LGPLv3** license. See the provided
`LICENSE` and `COPYING.LESSER` files.
