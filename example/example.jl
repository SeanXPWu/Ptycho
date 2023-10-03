using Revise
using Ptycho
using ImageView

function main()
params = Parameters(300, 1.03, 4.65, 31.25, -126, -13500)
dps =load_dps("./test_data/",(127,127))

    recon, trans_exec, _ = prestart(params, dps, 0.01, 0.01)

iter_step = 1
rmse_list = Vector{Float64}(undef, iter_step)
for i = 1:iter_step
    @time recon,rmse = iterate(recon,trans_exec,dps)
    rmse_list[i] = rmse
end
return params, recon, rmse_list, dps, trans_exec
end

params,recon, rmse_list,dps, trans_exec=main()
obj = recon.Object.ObjectMatrix
imshow(abs.(obj))
