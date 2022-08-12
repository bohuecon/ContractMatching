
function whyholes(ii, ei, sol, deep_para; filename = "simple_objectives.pdf")

   # ii = 7 
   # ei = 32 #31-35 (32-34 are zeros)

   # sol.mat_Mu[ii, ei]
   # sol.mat_dummiesStar[ii, ei]
   # sol.mat_cStar[ii, ei]

   i_val = deep_para.vec_i[ii]
   e_val = deep_para.vec_e[ei]

   g_val = deep_para.mat_g[ii, ei]


   vi_val = sol.vec_Vi[ii] / g_val
   ve_val = sol.vec_Ve[ei] / g_val


   @unpack vec_dummies, num_dcases, h, ρ, β1, β2, vec_β, γ1, vec_γ, πi, πe = deep_para
   πi_s(c, dummies) = πi(c, dummies, β1, β2, vec_β, γ1, vec_γ) 
   πe_s(c, dummies) = πe(c, dummies, β1, β2, vec_β, γ1, vec_γ) 

   πi_ss00(c) = πi_s(c, [0,0,0])
   πi_ss10(c) = πi_s(c, [1,0,0])
   πi_ss01(c) = πi_s(c, [0,1,0])
   πi_ss11(c) = πi_s(c, [1,1,1])
   πe_ss00(c) = πe_s(c, [0,0,0])
   πe_ss10(c) = πe_s(c, [1,0,0])
   πe_ss01(c) = πe_s(c, [0,1,0])
   πe_ss11(c) = πe_s(c, [1,1,1])

   vec_c = range(0.0, 1.0, length = 200)

   # [:auto, :solid, :dash, :dot, :dashdot, :dashdotdot]
   plot(vec_c, πi_ss00.(vec_c), label = "πi00", linecolor = :green, linestyle = :solid, legend = :bottomleft, xlabel = "c", ylabel = "πi", title = "e = $ei")
   plot!(vec_c, πi_ss10.(vec_c), label = "πi10", linecolor = :darkorchid, linestyle = :solid)
   plot!(vec_c, πi_ss01.(vec_c), label = "πi01", linecolor = :deepskyblue, linestyle = :solid)
   plot!(vec_c, πi_ss11.(vec_c), label = "πi11", linecolor = :deeppink, linestyle = :solid)
   plot!(vec_c, vec_c -> vi_val, label = "vi_val", linecolor = :red, linestyle = :dashdot)

   p = twinx()

   plot!(p, vec_c, πe_ss00.(vec_c), label = "πe00", linecolor = :green, linestyle = :dot, legend = :best, ylabel = "πe")
   plot!(p, vec_c, πe_ss10.(vec_c), label = "πe10", linecolor = :darkorchid, linestyle = :dot)
   plot!(p, vec_c, πe_ss01.(vec_c), label = "πe01", linecolor = :deepskyblue, linestyle = :dot)
   plot!(p, vec_c, πe_ss11.(vec_c), label = "πe11", linecolor = :deeppink, linestyle = :dot)
   plot!(p, vec_c, vec_c -> ve_val, label = "ve_val", linecolor = :indianred, linestyle = :dot)

   filename_full= "./InternalCandi/figures/" * filename

   Plots.savefig(filename_full)
end


function simple_objectives(deep_para; filename = "simple_objectives.pdf")

   @unpack vec_dummies, num_dcases, h, ρ, β1, β2, vec_β, γ1, vec_γ, πi, πe = deep_para
   πi_s(c, dummies) = πi(c, dummies, β1, β2, vec_β, γ1, vec_γ) 
   πe_s(c, dummies) = πe(c, dummies, β1, β2, vec_β, γ1, vec_γ) 

   πi_ss00(c) = πi_s(c, [0,0,0])
   πi_ss10(c) = πi_s(c, [1,0,0])
   πi_ss01(c) = πi_s(c, [0,1,0])
   πi_ss11(c) = πi_s(c, [1,1,1])
   πe_ss00(c) = πe_s(c, [0,0,0])
   πe_ss10(c) = πe_s(c, [1,0,0])
   πe_ss01(c) = πe_s(c, [0,1,0])
   πe_ss11(c) = πe_s(c, [1,1,1])

   vec_c = range(0.0, 1.0, length = 200)

   # [:auto, :solid, :dash, :dot, :dashdot, :dashdotdot]
   plot(vec_c, πi_ss00.(vec_c), label = "πi00", linecolor = :green, linestyle = :solid, legend = :bottomleft, xlabel = "c", ylabel = "πi")
   plot!(vec_c, πi_ss10.(vec_c), label = "πi10", linecolor = :darkorchid, linestyle = :solid)
   plot!(vec_c, πi_ss01.(vec_c), label = "πi01", linecolor = :deepskyblue, linestyle = :solid)
   plot!(vec_c, πi_ss11.(vec_c), label = "πi11", linecolor = :deeppink, linestyle = :solid)
   # plot!(vec_c, vec_c -> vi_val, label = "vi_val", linecolor = :red, linestyle = :dashdot)

   p = twinx()

   plot!(p, vec_c, πe_ss00.(vec_c), label = "πe00", linecolor = :green, linestyle = :dashdot, legend = :best, ylabel = "πe")
   plot!(p, vec_c, πe_ss10.(vec_c), label = "πe10", linecolor = :darkorchid, linestyle = :dashdot)
   plot!(p, vec_c, πe_ss01.(vec_c), label = "πe01", linecolor = :deepskyblue, linestyle = :dashdot)
   plot!(p, vec_c, πe_ss11.(vec_c), label = "πe11", linecolor = :deeppink, linestyle = :dashdot)
   # plot!(p, vec_c, vec_c -> ve_val, label = "ve_val", linecolor = :indianred, linestyle = :dot)

   filename_full= "./InternalCandi/figures/" * filename

   Plots.savefig(filename_full)
end