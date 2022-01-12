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

struct Sensor2D{T}
    point::Cartesian2D{T}
    radius::T
end

struct SensorArray{T}
    left::Sensor2D{T}
    center::Sensor2D{T}
    right::Sensor2D{T}
end

struct Ant2D{T}
    position::Cartesian2D{T}
    heading::Cartesian2D{T}
    sensor::SensorArray{T}
    id::Int
end
