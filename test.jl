# using CSV
# using DataFrames
using Parameters
# using Distributions
# using Optim
# using Optim: converged, maximum, maximizer, minimizer, iterations 

# using LinearAlgebra
# using Interpolations

using DataFrames
using CSV

using Plots
# plotly()
gr()
using LaTeXStrings
using JLD, HDF5

include("./InternalCandi/InternalCandi.jl")
include("./InternalCandi/whyholes.jl")


# Read in the est_para 

# df = CSV.read("/Users/bohu/Nutstore Files/ActiveDocuments/1projects/4InternalCandi/script/ContractMatchingPooled/estimation_log.csv", DataFrame);
# est_para = Array(df[1, 3:22])
# est_para_names = ["λi", "λe", "γi", "γe", "ai", "bi", "ae", "be", "ρ", "β1", "β2", "β3", "β4", "β5", "γ1", "γ3", "γ4", "γ5", "κ0", "κ1"]
# [est_para_names est_para]

dataMoment = load("./dataMoment.jld", "dataMoment");
momentName = load("./dataMoment.jld", "momentName");


est_para = [
   # λi, λe, γi, γe, ai, bi, ae, be, ρ,
   5.5443, 14.9405, 8.0161, 1.3515, 1.1624, 6.7023, 3.1204, 3.4607, -0.5267, 
   # β1, β2, β3, β4, β5, 
   0.6, -0.78, 0.03, -0.014, -0.05, 
   # γ1, γ3, γ4, γ5, κ0, κ1
   0.2, -0.03, 0.3, -0.01, -0.622, 0.5689]

# this one matches atwill and explicit well
est_para1 = [7.3521, 9.8538, 10.5309, 6.8028, 5.1948, 7.0379, 6.1274, 9.4036, -1.7805, 
            0.9038, -1.4863, -0.1138, -0.7322, 0.8202, 
            0.3163, 0.8562, 0.0055, -0.6035, 
            -0.542, 0.0282]
modelMoment1, error_flag, not_convergent = InternalCandi.genMoments(est_para = est_para1, diagnosis = true)

# this one gives a lowest score
est_para2 = [7.3521, 19.6277, 10.5309, 8.0252, 3.4585, 7.7851, 7.2956, 7.3673, -0.1274, 
            0.8572, -1.4896, 0.0138, -0.3717, 0.0191, 
            0.9504, -0.3166, 0.5982, 0.843, 
            -2.5548,  0.2937]
modelMoment2, error_flag, not_convergent = InternalCandi.genMoments(est_para = est_para2, diagnosis = true)

df_data = DataFrame(moment = momentName, data = dataMoment, model1 = modelMoment1, model2 = modelMoment2)
show(df_data, allcols=true)

# plot objectives to gain insights
est_para1 = [7.3521, 9.8538, 10.5309, 6.8028, 5.1948, 7.0379, 6.1274, 9.4036, -1.7805, 
             0.75, -1.161, 0.2935, -0.3735, 0.1566, 
             0.0831, -0.9822, 0.7014, -0.2179, -3.6678, 0.5267];
modelMoment1, error_flag, not_convergent = InternalCandi.genMoments(est_para = est_para1, diagnosis = true)
df_data = DataFrame(moment = momentName, data = dataMoment, model1 = modelMoment1, model2 = modelMoment2)

para1 = InternalCandi.est_para2deep_para(est_para1);
sol1, not_convergent = InternalCandi.solve_main(para = para1, diagnosis = true)
 whyholes(11, 28, sol1, para1)





est_para = [12.9801, 14.4704, 18.557, 3.77702, 7.73451, 5.20342, 6.21324, 7.51897, -1.80401, 0.841674, -1.41032, -0.590435, -0.995595, 0.975385, 0.0313107, -0.454453, 0.356562, -0.979959, -0.913731, 0.136749]

modelMoment, error_flag, not_convergent = InternalCandi.genMoments(est_para = est_para, diagnosis = true)

df_data = DataFrame(moment = momentName, data = dataMoment, model = modelMoment)
show(df_data, allcols=true)

# There are two directions to debug
# (1) Check the objective functions and understand why it does not work
# (2) (together with) solving each contract at the last possible places
# (3) Check if vec_Ve, mat_Ve, vec_Vi has problems

include("internal_candi_parameters.jl")
include("internal_candi_solvemodel.jl")
include("internal_candi_bounds.jl")
include("internal_candi_valueupdate.jl")
include("internal_candi_contracting.jl")
include("internal_candi_policy.jl")
include("internal_candi_funcs.jl")
include("internal_candi_plots.jl")
include("internal_candi_moments.jl")
include("whyholes.jl")

para = est_para2deep_para(est_para)
i_quasiconcave, e_quasiconcave = quasiconcave_objects(para)
sol, not_convergent = solve_main(para = para, diagnosis = true)

# plot objective functions



@unpack vec_Vi, vec_Ve, mat_Ve, mat_Mu = sol

ii = 14
ei = 35

i_ind = ii; e_ind = ei; dummies_ind = 2

whyholes(14, 35, sol, para)

mat_Mu[ii, ei]

vi_val = sol.vec_Vi[ii] 
ve_val = sol.vec_Ve[ei] 

mat_Πe[ii, ei] - ve_val 

























