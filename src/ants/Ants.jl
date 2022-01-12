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

# type exports
export Environment, Cartesian2D, Cartesian3D, Ant2D
export Sensor2D, SensorArray

# function exports
export normed, newAnt, sumCartesian2D, scaleCartesian2D, nextAnt2D
export sensorHeading, sensorArray, newHeading2D

end # module
