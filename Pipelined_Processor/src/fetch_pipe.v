module fetch_pipe(
  input wire clk,
  input wire [31:0] pre_address_pc,
  input wire [31:0] instruction_fetch,

  output wire [31:0] pre_address_out,
  output wire [31:0] instruction
 );

  reg [31:0] pre_address,instruc;

  always @ (posedge clk) begin
    pre_address <= pre_address_pc;
    instruc <= instruction_fetch;
  end

  assign pre_address_out = pre_address;
  assign instruction = instruc;
endmodule