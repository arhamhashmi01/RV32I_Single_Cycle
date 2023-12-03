module writeback_pipe(
  input wire clk,
  input wire reg_write_in,
  input wire [31:0] rd_sel_mux_in,
  input wire [31:0] instruction_in,

  output wire reg_write_out,
  output wire [31:0] rd_sel_mux_out,
  output wire [31:0] instruction_out
  );

  reg [31:0] rd_data_sel;
  reg [31:0] instruction;
  reg reg_write;

  always @ (posedge clk) begin
    rd_data_sel <= rd_sel_mux_in;
    instruction <= instruction_in;
    reg_write <= reg_write_in;
  end
  
  assign reg_write_out = reg_write;
  assign rd_sel_mux_out = rd_data_sel;
  assign instruction_out = instruction;
endmodule