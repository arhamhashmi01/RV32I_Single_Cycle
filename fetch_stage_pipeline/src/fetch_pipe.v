module fetch_pipe(
  input wire clk,
  input wire [31:0] pre_address_pc,
  input wire [31:0] instruction_fetch,
  input wire next_select,
  input wire branch_result,
  input wire load,

  output wire [31:0] pre_address_out,
  output wire [31:0] instruction
);

  reg [31:0] pre_address, instruc;
  reg flush_pipeline;

  always @ (posedge clk) begin
    if (next_select | branch_result) begin
      // If jal, jalr, or branch result is high, flush the pipeline for one cycle
      pre_address <= pre_address_pc;
      instruc <= 0;
      flush_pipeline <= 1; // Set flag to flush for one cycle
    end 
    else if (flush_pipeline) begin
      // Stall the pipeline for one additional cycle after flushing
      pre_address <= pre_address_pc;
      instruc <= 0;
      flush_pipeline <= 0; // Reset flag after one cycle stall
    end 
    else begin
      // For other instructions, proceed normally
      pre_address <= pre_address_pc;
      instruc <= instruction_fetch;
    end
  end

  assign pre_address_out = pre_address;
  assign instruction = instruc;
endmodule