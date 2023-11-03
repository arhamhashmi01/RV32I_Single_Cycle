module pc (
    input wire clk,
    input wire rst,
    input wire load,
    input wire next_sel,
    input wire dmem_valid,
    input wire branch_reselt,
    input wire [31:0]next_address,
    input wire [31:0]address_in,

    output reg [31:0]address_out
);
//(((ld | st) & dmem_valid))
always @(posedge clk or negedge rst) begin
        if(!rst)begin
            address_out <= 0;
        end
        else if (next_sel | branch_reselt)begin
            address_out <= next_address;
        end
        else if (load & !dmem_valid)begin
            address_out <= address_out;
        end
        else begin
            address_out <= address_out + 32'd4;
        end
end
endmodule