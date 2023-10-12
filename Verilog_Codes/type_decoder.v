module type_decoder (opcode,r_type,i_type,load,store,branch,jal,jalr,lui,auipc);

    input wire [6:0]opcode;
    
    output reg r_type;
    output reg i_type; 
    output reg load;
    output reg store;
    output reg branch; 
    output reg jal;
    output reg jalr;
    output reg lui;
    output reg auipc;

    always @(*)begin 
        r_type = 1'b0;
        i_type = 1'b0;
        store = 1'b0;
        load = 1'b0;
        branch = 1'b0;
        auipc = 1'b0; 
        jal = 1'b0; 
        jalr = 1'b0; 
        lui = 1'b0; 
        case(opcode)
            7'b0110011:begin 
                r_type = 1'b1;
            end 
            7'b0010011:begin 
                i_type = 1'b1;
            end
            7'b0100011:begin 
                store = 1'b1;
            end
            7'b0000011:begin 
                load = 1'b1;
            end
            7'b1100011:begin 
                branch = 1'b1;
            end
            7'b0010111:begin 
                auipc = 1'b1;
            end
            7'b1101111:begin 
                jal = 1'b1;
            end
            7'b1100111:begin 
                jalr = 1'b1;
            end
            7'b0110111:begin 
                lui = 1'b1;
            end

            default:begin 
                r_type = 1'b0;
                i_type = 1'b0;
                store= 1'b0;
                load = 1'b0;
                branch = 1'b0;
                auipc = 1'b0;
                jal = 1'b0; 
                jalr = 1'b0; 
                lui = 1'b0; 
            end
        endcase
    end  
endmodule