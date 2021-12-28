import Pkg;

packages = ["Plots", "PlotlyJS", "GenericLinearAlgebra", "WriteVTK", "LanguageServer"]

Pkg.add(packages)

Pkg.gc()
