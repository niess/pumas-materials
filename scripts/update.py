#! /usr/bin/env python3
from pathlib import Path
import pumas
from pumas.definitions import elements, materials, MaterialsDescription, \
                              MaterialsDict
import os
import sys


_PREFIX = Path(__file__).parent.parent


def update_element(symbol, data):
    '''Update the MDF for an atomic element
    '''

    dirname = f'{_PREFIX}/mdf/elements'
    filename = f'{symbol}.xml'
    path = os.path.join(dirname, filename)
    if os.path.exists(path): return

    print(f'generating MDF for {symbol}')
    sys.stdout.flush()

    align1 = (2 - len(symbol)) * ' '
    align2 = '' if data.Z >= 10 else ' '
    align3 = '' if data.A >= 10 else ' '
    align4 = '' if data.I >= 100E-09 else ' '
    I_eV = data.I * 1E+09
    content = f'''<pumas>
  <element name="{symbol}"{align1} Z="{data.Z:.0f}"{align2} A="{data.A:.6f}"{align3} I="{I_eV:.1f}"{align4} />
</pumas>
'''
    with open(path, 'w') as f:
        f.write(content)


def update_material(name, data):
    '''Update the MDF and stopping power table for a material
    '''

    dirname = f'{_PREFIX}/mdf/materials'
    filename = f'{name}.xml'
    path = os.path.join(dirname, filename)
    if os.path.exists(path): return

    print(f'generating data for {name}')
    sys.stdout.flush()

    description = MaterialsDescription(
        materials=MaterialsDict(name))
    description.dump(path)

    settings = {'dry': True}
    pumas.Physics(path, f'{_PREFIX}/dedx/muon', 'muon', **settings)
    pumas.Physics(path, f'{_PREFIX}/dedx/tau', 'tau', **settings)


if __name__ == '__main__':
    # Update the elements MDFs
    for symbol, data in elements.items():
        update_element(symbol, data)

    for name, data in materials.items():
        update_material(name, data)
