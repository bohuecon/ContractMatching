
# -------------------------------
#
# Description:
# This is the model of internal candidates
# In the model there is one continuous variable and two dummies
#
# -------------------------------
#
# Author: Bo Hu
# Date: 2022 June 16
#
# -------------------------------

module InternalCandi
export genMoments, model_para

using Parameters
using Distributions
using Optim
using Optim: converged, maximum, maximizer, minimizer, iterations 

using LinearAlgebra
using Interpolations
# using DataFrames
# using CSV

# using Plots
# theme(:default)
# using LaTeXStrings
# using JLD, HDF5

# using Roots
# using Statistics
# using LoopVectorization
# using BenchmarkTools
# using ProfileView

include("internal_candi_parameters.jl")
include("internal_candi_solvemodel.jl")
include("internal_candi_bounds.jl")
include("internal_candi_valueupdate.jl")
include("internal_candi_contracting.jl")
include("internal_candi_policy.jl")
include("internal_candi_funcs.jl")
# include("internal_candi_plots.jl")
include("internal_candi_moments.jl")

function genMoments(;est_para = est_para, diagnosis = false)

    # transform est para to deep model para

    deep_para = est_para2deep_para(est_para)

    # est_para_initial = [3.65803, 2.72272, 4.94808, 17.0181, 4.11957, 5.3761, 4.04063, 2.58149, -0.547694, 4.59406, -6.87669, 0.290423, -0.793224, -0.240003, 0.479697, -2.84134, 4.54637, 1.99139, -153.041, 3.6081]
    # est_para_initial = [9.2937, 13.0476, 15.8459, 9.2559, 6.3981, 9.2277, 8.5521, 5.9541, -0.9136, 4.0767, -6.8068, 1.1419, -2.5603, 3.7307, 3.097, 4.2259, 4.332, 4.0677, 70.3971, 41.4369]
    # deep_para = est_para2deep_para(est_para_initial)
    # est_para_initial = [7.98398, 9.94985, 11.5009, 6.76383, 6.13025, 8.80139, 6.48018, 8.41869, -1.1507, 2.68856, -4.26221, 0.428072, -0.306312, -0.285261, 3.64172, -3.75063, 2.92743, 2.29239, -177.283, 8.64983]
    # deep_para = est_para2deep_para(est_para_initial)

    # check if h() and γ() are quasicancave
    # i_flag = true means IT IS QUASICONCAVE

    i_quasiconcave, e_quasiconcave = quasiconcave_objects(deep_para)

    if diagnosis
        println()
        println("       >>> Objectives quasiconcave? i: $i_quasiconcave, e: $e_quasiconcave .")
    end

    quasiconcave = i_quasiconcave && e_quasiconcave

    if quasiconcave # both objectives are quasiconcave

        # solve the model
        # sol, not_convergent = solve_main(para = deep_para, diagnosis = true)
        sol, not_convergent = solve_main(para = deep_para, diagnosis = diagnosis)
        # sol, not_convergent = solve_main(para = deep_para, diagnosis = true, save_results = true)
        # plot_equ(;para = deep_para)
        
        # record not convergent cases 

        if not_convergent
            open("log_err", "a") do f
            write(f, "\n _____________________________________________ \n")
            write(f, "parameters: $est_para; \n \n")
            write(f, "error: not convergent; \n \n ")
            end
        end

        # check if mat_Mu has a row of zeros
        # that is, some type of firms will not be matched

        @unpack mat_Mu = sol

        firm_not_match = minimum(sum(mat_Mu, dims = 2)) == 0

        if firm_not_match
            return zeros(20), true, not_convergent
        else
            # generate moments
            modelMoment = compute_moments(sol, deep_para)
            return modelMoment, false, not_convergent
        end

        # if minimum(sum(mat_Mu, dims = 1)) * minimum(sum(mat_Mu, dims = 2)) == 0
        #     error_flag = true
        # end

        # if error_flag # does not converge
        #     return zeros(20), error_flag

        # else
        #     # generate moments
        #     modelMoment = compute_moments(sol, para)
        #     return modelMoment, false
        # end

    else
        not_convergent = false
        return zeros(20), true, not_convergent
    end
 
end

end



