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

function newAnt(initialPos::Tuple{T,T}, initialHead::Tuple{T,T}, id::Int, environment::Ants.Environment{T}) where {T}
    position = Ants.Cartesian2D(initialPos...)
    heading = Ants.Cartesian2D(initialHead...) |> Ants.normed
    @info "Checking for initial position environment size coherence"
    @assert position.x <= environment.x_lim
    @assert position.y <= environment.y_lim
    @info "Check complete!"
    #  make composable later on -> potential use of Base.@kwdef struct kwargs
    θ = deg2rad(45)
    radius = 0.5
    sensorArr = sensorArray(position, heading, θ, radius)
    return Ants.Ant2D(position, heading, sensorArr, id)
end

function sumCartesian2D(A::Ants.Cartesian2D, B::Ants.Cartesian2D)
    return Ants.Cartesian2D(
        A.x + B.x,
        A.y + B.y
    )
end

function scaleCartesian2D(A::Ants.Cartesian2D, scalar::T) where {T <: Real}
    return Ants.Cartesian2D(scalar * A.x, scalar * A.y)
end

"Updates the position and heading of an `Ant2D` object based on previous state."
function nextAnt2D(ant::Ants.Ant2D{T}, newHeading::Tuple{T,T}) where {T}
    return Ants.Ant2D(
        sumCartesian2D(ant.position, ant.heading),
        Ants.Cartesian2D(newHeading...) |> Ants.normed,
        ant.id
    )
end

function sensorHeading(heading, θ)
    x = cos(θ) * (heading.x) - sin(θ) * (heading.y)
    y = sin(θ) * (heading.x) + cos(θ) * (heading.y)
    return Ants.Cartesian2D(x, y)
end

function sensorArray(position, heading, θ, radius)
    sp1 = sumCartesian2D(position, scaleCartesian2D(heading, 2))
    sp2 = sumCartesian2D(position, scaleCartesian2D(sensorHeading(heading, θ) ,2))
    sp3 = sumCartesian2D(position, scaleCartesian2D(sensorHeading(heading, -θ) ,2))
    return SensorArray(
        Sensor2D(sp1, radius),
        Sensor2D(sp2, radius),
        Sensor2D(sp3, radius)
    )
end

inCircle(tuple, radius) = radius >= sqrt(tuple[1]^2 + tuple[2]^2) ? true : false

function sensorPheromoneCount(ant::Ant2D{T}, points::Vector{Cartesian2D{T}}, whichSensor::Symbol) where {T}
    diff = [(points[i].x - getproperty(ant.sensor, whichSensor).point.x, points[i].y - getproperty(ant.sensor, whichSensor).point.y) for i in 1:length(points)]
    return count(x -> inCircle(x, getproperty(ant.sensor, whichSensor).radius), diff)
end

"Returns the symbol of the sensor which picked up the most pheromone trails"
function attractorSensor(ant::Ant2D{T}, pheromones::Vector{Cartesian2D{T}}) where {T}
    count = [sensorPheromoneCount(ant, pheromones, symbol) for symbol in [:left, :center, :right]]
    # center shifted, to be chosen in case of no unique maximum sensor count
    countDict = Dict(count[1] => :left, count[3] => :right, count[2] => :center)
    return countDict[max(keys(countDict)...)]
end

genPheronomesTest(num) = [Cartesian2D(Random.rand(0.:0.01:100.), Random.rand(0.:0.01:100.)) for i in 1:num]

# generate next heading value based on pheromone trails and infused randomness
function newHeading(ant::Ants.Ant2D{T}, env::Ants.Environment{T}) where {T}
end
