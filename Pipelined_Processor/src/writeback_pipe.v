module writeback_pipe(
  input wire clk
  input wire [31:0] rd_sel_mux_in,

  output wire [31:0] rd_sel_mux_out
  );

  reg [31:0] rd_data_sel;

  always @ (posedge clk) begin
    rd_data_sel <= rd_sel_mux_in;
  end

  assign rd_sel_mux_out = rd_data_sel;
endmodule