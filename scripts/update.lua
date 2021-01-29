-------------------------------------------------------------------------------
-- Utitility script for updating the material data
-- Author: Valentin Niess
-- License: GNU GPL-3.0
-------------------------------------------------------------------------------
local lfs = require('lfs')
local pumas = require('pumas')


-------------------------------------------------------------------------------
-- Update the elements data
-------------------------------------------------------------------------------
do
    -- Build the MDFs
    local dirname = 'mdf/elements/'
    for k, v in pairs(pumas.elements) do
        local xml = k..'.xml'
        if not lfs.attributes(dirname..xml, 'mode') then
            print('generating MDF for '..k)
            io.flush()

            local align1 = string.rep(' ', 2 - #k)
            local align2 = v.Z >= 10 and '' or ' '
            local align3 = v.A >= 10 and '' or ' '
            local align4 = v.I >= 100E-09 and '' or ' '
            local content = string.format([[
<pumas>
  <element name="%s"%s Z="%d"%s A="%.6f"%s I="%.1f"%s />
</pumas>
]], k, align1, v.Z, align2, v.A, align3, v.I * 1E+09, align4)

            local file = io.open(dirname..xml, 'w+')
            file:write(content)
            file:close()
        end
    end
end


-------------------------------------------------------------------------------
-- Update the materials data
-------------------------------------------------------------------------------
do
    -- Build the MDFs and energy loss tables
    local dirname = 'mdf/materials/'
    for k, v in pairs(pumas.materials) do
        local xml = k..'.xml'
        if not lfs.attributes(dirname..xml, 'mode') then
            print('generating data for '..k)
            io.flush()

            local stats = pumas.build{
                materials = {[k] = v}, compile = false}
            os.rename(stats.dedx[1], 'dedx/muon/'..stats.dedx[1])

            stats = pumas.build{
                materials = {[k] = v}, compile = false, particle = 'tau'}
            os.rename(stats.dedx[1], 'dedx/tau/'..stats.dedx[1])

            os.rename('materials.xml', dirname..xml)
        end
    end
    os.remove('materials.xml')
end
