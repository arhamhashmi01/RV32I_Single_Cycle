export CORE_ROOT=/home/zeeshan/projects/RV32I_Single_Cycle/fetch_stage_pipeline

all: icarus

icarus: icarus_compile
	vvp $(CORE_ROOT)/temp/microprocessor.output

icarus_compile:
	mkdir -p temp
	iverilog -f flist -o $(CORE_ROOT)/temp/microprocessor.output

clean:
	rm -rf temp