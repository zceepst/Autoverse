#=
Ants datatypes.
=#

struct Environment{T}
    x_lim::T
    y_lim::T
    use_pheromones::Bool
end

struct Cartesian2D{T}
    x::T
    y::T
end

struct Cartesian3D{T}
    x::T
    y::T
    z::T
end

struct Ant2D{T}
    position::Cartesian2D{T}
    heading::Cartesian2D{T}
    id::Int
end
