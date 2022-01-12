#=
Autoverse.jl, entry-point to Autoverse package, a collection of complexity seeding systems built

Main module loads and runs simulations/systems provided by submodules which can be found in their individual sub-directories, e.g. src/Ants/...

Results visualized with Makie.jl, generated outputs passed to results/.
=#
module Autoverse

include("ants/Ants.jl") # imports `Ants`

end # module
