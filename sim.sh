clear

# rm sim/$1_sim
# iverilog -g2012 -o sim/$1_sim verilog/$1.sv test/$1_tb.sv
# vvp sim/$1_sim  > outputs/$1_out.csv


rm sim/arbiter_round_robin_sim
iverilog -g2012 -o sim/arbiter_round_robin_sim verilog/arbiter_round_robin.sv verilog/arbiter.sv test/arbiter_round_robin_tb.sv
vvp sim/arbiter_round_robin_sim
vvp sim/arbiter_round_robin_sim  > outputs/rr_out.csv

# > outputs/adder_out.csv

# python3 scripts/fp_verify.py > outputs/out_verif.txt

# cat outputs/out_verif.txt