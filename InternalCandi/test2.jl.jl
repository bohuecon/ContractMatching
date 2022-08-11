
# this one converges
est_para1 = [
   # λi, λe, γi, γe, ai, bi, ae, be, ρ,
   7.9669, 6.4285, 11.3733, 19.6905, 4.3613, 5.6546, 4.7125, 9.0024, -0.2923, 
   # β1, β2, β3, β4, β5, 
   5.5108, -8.3194, -1.0298, -0.2501, 5.4096, 
   # γ1, γ3, γ4, γ5, κ0, κ1
   # 4.0561, 0.0, 0.0, 0.0, -239.0179, 7.2275]
   # 4.0561, 12.0, 0.0, -10.0, -239.0179, 7.2275]
   4.0561, 13.9467, 1.5728, -19.5414, -239.0179, 7.2275]

para1 = est_para2deep_para(est_para1)
i_quasiconcave, e_quasiconcave = quasiconcave_objects(para1)
sol, not_convergent = solve_main(para = para1, diagnosis = true)

# this one does not converge

est_para2 = [
   # λi, λe, γi, γe, ai, bi, ae, be, ρ,
   7.9669, 6.4285, 11.3733, 19.6905, 4.3613, 5.6546, 4.7125, 9.0024, -0.2923, 
   # β1, β2, β3, β4, β5, 
   5.5108, -8.3194, -1.0298, -0.2501, 1.4096, 
   # γ1, γ3, γ4, γ5, κ0, κ1
   4.0561, 13.0, 2.0, -11.0, -239.0179, 7.2275]
   # 4.0561, 12.0, 0.0, -10.0, -239.0179, 7.2275]
   # 4.0561, 13.9467, 1.5728, -19.5414, -239.0179, 7.2275]

para2 = est_para2deep_para(est_para2)
i_quasiconcave, e_quasiconcave = quasiconcave_objects(para2)
sol, not_convergent = solve_main(para = para2, diagnosis = true)

# this one does not converge
est_para3 = [
   # λi, λe, γi, γe, ai, bi, ae, be, ρ,
   7.9669, 6.4285, 11.3733, 19.6905, 4.3613, 5.6546, 4.7125, 9.0024, -0.2923, 
   # β1, β2, β3, β4, β5, 
   5.5108, -8.3194, -1.0298, -0.2501, 1.4096, 
   # γ1, γ3, γ4, γ5, κ0, κ1
   4.0561, 13.9467, 1.5728, -19.5414, -239.0179, 7.2275]


para3 = est_para2deep_para(est_para3)
i_quasiconcave, e_quasiconcave = quasiconcave_objects(para3)
sol, not_convergent = solve_main(para = para3, diagnosis = true)

para4 = model_para()
i_quasiconcave, e_quasiconcave = quasiconcave_objects(para4)
sol, not_convergent = solve_main(para = para4, diagnosis = true)





@unpack vec_Ve, mat_Ve, vec_Vi = sol

vec_Ve0 = deepcopy(vec_Ve)
mat_Ve0 = deepcopy(mat_Ve)
vec_Vi0 = deepcopy(vec_Vi)

vec_Ve1 = deepcopy(vec_TVe)
mat_Ve1 = deepcopy(mat_TVe)
vec_Vi1 = deepcopy(vec_TVi)

vec_Ve2 = deepcopy(vec_TVe)
mat_Ve2 = deepcopy(mat_TVe)
vec_Vi2 = deepcopy(vec_TVi)

vec_Ve3 = deepcopy(vec_TVe)
mat_Ve3 = deepcopy(mat_TVe)
vec_Vi3 = deepcopy(vec_TVi)

Base.maximum(abs, vec_Ve1 - vec_Ve0)
Base.maximum(abs, vec_Ve2 - vec_Ve1)
Base.maximum(abs, vec_Ve3 - vec_Ve2)
Base.maximum(abs, vec_Ve2 - vec_Ve0)
Base.maximum(abs, vec_Ve3 - vec_Ve0)

Base.maximum(abs, mat_Ve1 - mat_Ve0)
Base.maximum(abs, mat_Ve2 - mat_Ve1)
Base.maximum(abs, mat_Ve3 - mat_Ve2)
Base.maximum(abs, mat_Ve2 - mat_Ve0)
Base.maximum(abs, mat_Ve3 - mat_Ve0)

diff10 = (mat_Ve1 - mat_Ve0)
maximum(abs, diff10[36:40, 11:20])
diff10[39, 13]
diff10 = (mat_Ve1 - mat_Ve0)
diff21 = (mat_Ve2 - mat_Ve1)
diff32 = (mat_Ve3 - mat_Ve2)
diff10[39, 13]
diff21[39, 13]
diff32[39, 13]
[mat_Ve0[39,13] mat_Ve1[39,13] mat_Ve2[39,13] mat_Ve3[39,13]]
[mat_Ve0[39,13]; mat_Ve1[39,13]; mat_Ve2[39,13]; mat_Ve3[39,13]]


onelayer_Ve = reshape(mat_Ve', 1, num_e, num_i) 
 arr_Πe .- repeat(onelayer_Ve, num_i, 1,1)

for i in 1:num_i
   println(minimum(arr_Πe[1, :, :] - mat_Ve))
end

i_ind = 18
e_ind = 50

minimum(mat_Πe - mat_Πe2) 




