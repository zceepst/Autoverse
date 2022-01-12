#=
Ants.jl, provides the Ants sub-module to Autoverse.
=#
module Ants

using ..Autoverse
using Printf
using Makie
using LinearAlgebra
using Random

include(joinpath(@__DIR__, "types.jl"))
include(joinpath(@__DIR__, "mechanics.jl"))

export Environment, Cartesian2D, Cartesian3D, Ant2D
export normed, generateAnt, sumCartesian, nextAnt2D

end # module
