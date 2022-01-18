import Pkg;

packages = ["Plots", "PlotlyJS", "GenericLinearAlgebra", "WriteVTK", "LanguageServer"]

Pkg.add(packages)

Pkg.gc()

using IJulia
installkernel("Julia Singlethreaded", env=Dict("JULIA_NUM_THREADS"=>"1"))
