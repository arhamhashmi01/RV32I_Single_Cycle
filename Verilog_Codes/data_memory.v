module datamemory (
    input wire clk,
    input wire mem_en,
    input wire [7:0]address,
    input wire [31:0]storein,
    input wire [3:0]mask,

    output reg [31:0]loadout
);

    reg [31:0] mem [0:255];

    always @(posedge clk) begin
        if (mem_en) begin
            if(mask[0]) begin
                mem[address][7:0] <= storein[7:0];
            end
            if(mask[1]) begin
                mem[address][15:8] <= storein[15:8];
            end
            if(mask[2]) begin
                mem[address][23:16] <= storein[23:16];
            end
            if(mask[3]) begin
                mem[address][31:24] <= storein[31:24];
            end
        end
        
    end
    always @(*) begin
        loadout = mem[address];
    end

endmodule