module type_decoder (opcode,r_type,i_type,load,store,branch,jal);

    input wire [6:0]opcode;
    
    output reg r_type;
    output reg i_type; 
    output reg load;
    output reg store;
    output reg branch; 
    output reg jal;

    always @(*) begin
        case(opcode)
            7'b0110011:begin
                r_type = 1'b1;
                i_type = 1'b0;
                load  = 1'b0;
                store = 1'b0;
                branch = 1'b0;
                jal = 1'b0;
            end
            7'b0010011:begin
                i_type = 1'b1;
                r_type = 1'b0;
                load  = 1'b0;
                store = 1'b0;
                branch = 1'b0;
                jal = 1'b0;
            end
            7'b0000011 : begin
                load = 1'b1;
                r_type = 1'b0;
                i_type  = 1'b0;
                store = 1'b0;
                branch = 1'b0;
            end
            7'b0100011 : begin
                store = 1'b1;
                r_type = 1'b0;
                i_type  = 1'b0;
                load = 1'b0;
                branch = 1'b0;
                jal = 1'b0;
            end
            7'b1100011 : begin
                branch = 1'b1;
                r_type = 1'b0;
                i_type  = 1'b0;
                load = 1'b0;
                store = 1'b0;
                jal = 1'b0;
            end
            7'b1101111 : begin
                jal = 1'b1;
                branch = 1'b0;
                r_type = 1'b0;
                i_type  = 1'b0;
                load = 1'b0;
                store = 1'b0;
            
            end
            default: begin 
                r_type = 1'b0;
                i_type = 1'b0;
                load = 1'b0;
                store = 1'b0;
                branch = 1'b0;
                jal = 1'b0;
            end
        endcase        
    end 
endmodule