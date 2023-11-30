module memory_pipe(
  input wire clk,
  input wire [31:0] store_data_in,
  input wire [31:0] wrap_load_in,

  output wire [31:0] store_data_out,
  output wire [31:0] wrap_load_out
  );

  reg [31:0] store_data,wrap_load;

  always @ (posedge clk) begin
    store_data <= store_data_in;
    wrap_load <= wrap_load_in;
  end

  assign store_data_out = store_data;
  assign wrap_load_out = wrap_load;
endmodule