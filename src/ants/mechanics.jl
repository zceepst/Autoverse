#=
Entity creation and dynamics formulations for ant agents moving in an artificial and bounded environment.
=#

using ..Autoverse
using ..Ants
using LinearAlgebra

# applies normalization to a 2D cartesian vector (unit magnitude or 'direction vector')
function normed(in::Cartesian2D{T}) where {T<:Number}
    denominator = norm((in.x , in.y))
    return Cartesian2D{T}(in.x / denominator, in.y / denominator)
end

function generateAnt(initialPos::Tuple{T,T}, initialHead::Tuple{T,T}, id::Int, environment::Ants.Environment{T}) where {T}
    position = Ants.Cartesian2D(initialPos...)
    heading = Ants.Cartesian2D(initialHead...) |> Ants.normed
    @info "Checking for initial position environment size coherence"
    @assert position.x <= environment.x_lim
    @assert position.y <= environment.y_lim
    @info "Check complete!"
    return Ants.Ant2D(position, heading, id)
end

function sumCartesian(A::Ants.Cartesian2D, B::Ants.Cartesian2D)
    return Ants.Cartesian2D(
        A.x + B.x,
        A.y + B.y
    )
end

"Updates the position and heading of an `Ant2D` object based on previous state."
function nextAnt2D(ant::Ants.Ant2D{T}, newHeading::Tuple{T,T}) where {T}
    return Ants.Ant2D(
        sumCartesian(ant.position, ant.heading),
        Ants.Cartesian2D(newHeading...) |> Ants.normed,
        ant.id
    )
end
