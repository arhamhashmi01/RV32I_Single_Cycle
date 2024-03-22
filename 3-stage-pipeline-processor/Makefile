export CORE_ROOT=/home/arham/RV32I_Single_Cycle/3-stage-pipeline-processor

all: icarus

icarus: icarus_compile
	vvp $(CORE_ROOT)/temp/microprocessor.output

icarus_compile:
	mkdir -p temp
	iverilog -f flist -o $(CORE_ROOT)/temp/microprocessor.output

clean:
	rm -rf temp
