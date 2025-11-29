// RiSC-16 Control Unit 

module control (
    input [2:0] op,  
    input EQ,
    output reg [1:0] FUNC_alu,
    output reg MUX_alu1,
    output reg MUX_alu2,
    output reg [1:0] MUX_pc,
    output reg MUX_rf,
    output reg [1:0] MUX_tgt,
    output reg WE_rf,
    output reg WE_dmem
);

    localparam ADD = 3'b000;
    localparam ADDI = 3'b001;
    localparam NAND = 3'b010;
    localparam LUI = 3'b011;
    localparam LW = 3'b100;
    localparam SW = 3'b101;
    localparam BEQ = 3'b110;
    localparam JALR = 3'b111;
    localparam F_ADD = 2'b00;
    localparam F_NAND = 2'b01;
    localparam F_PASS = 2'b10;
    localparam F_EQL = 2'b11;
  
    localparam PC_PLUS1 = 2'b00;
    localparam PC_PLUS1_IMM = 2'b01;
    localparam PC_JALR = 2'b10;

    always @(*) begin
        FUNC_alu = F_ADD;
        MUX_alu1 = 1'b0;
        MUX_alu2 = 1'b0;
        MUX_pc = PC_PLUS1;
        MUX_rf = 1'b0;
        MUX_tgt = 2'b01;  
        WE_rf = 1'b0;
        WE_dmem = 1'b0;

        case (op)
            ADD: begin
                FUNC_alu = F_ADD;
                MUX_alu1 = 1'b0;
                MUX_alu2 = 1'b0;
                MUX_pc = PC_PLUS1;
                MUX_rf = 1'b0;
                MUX_tgt = 2'b01;   
                WE_rf = 1'b1;
                WE_dmem = 1'b0;
            end

            ADDI: begin
                FUNC_alu = F_ADD;
                MUX_alu1 = 1'b0;
                MUX_alu2 = 1'b1;    
                MUX_pc = PC_PLUS1;
                MUX_rf = 1'b0;
                MUX_tgt = 2'b01;   
                WE_rf = 1'b1;
                WE_dmem  = 1'b0;
            end

            NAND: begin
                FUNC_alu = F_NAND;
                MUX_alu1 = 1'b0;
                MUX_alu2 = 1'b0;
                MUX_pc = PC_PLUS1;
                MUX_rf = 1'b0;
                MUX_tgt = 2'b01;   
                WE_rf = 1'b1;
                WE_dmem  = 1'b0;
            end

            LUI: begin
                FUNC_alu = F_PASS;  
                MUX_alu1 = 1'b1;  
                MUX_alu2 = 1'b0;
                MUX_pc = PC_PLUS1;
                MUX_rf = 1'b0;
                MUX_tgt = 2'b01;  
                WE_rf = 1'b1;
                WE_dmem = 1'b0;
            end

            LW: begin
                FUNC_alu = F_ADD;  
                MUX_alu1 = 1'b0;
                MUX_alu2 = 1'b1;   
                MUX_pc = PC_PLUS1;
                MUX_rf = 1'b0;
                MUX_tgt = 2'b00;  
                WE_rf = 1'b1;
                WE_dmem  = 1'b0;
            end

            SW: begin
                FUNC_alu = F_ADD; 
                MUX_alu1 = 1'b0;
                MUX_alu2 = 1'b1;
                MUX_pc = PC_PLUS1;
                MUX_rf = 1'b1;  
                MUX_tgt = 2'b00;
                WE_rf = 1'b0;
                WE_dmem = 1'b1;  
            end

            BEQ: begin
                FUNC_alu = F_EQL;
                MUX_alu1 = 1'b0;
                MUX_alu2 = 1'b0;
                MUX_rf = 1'b1; 
                MUX_tgt = 2'b00;
                WE_rf = 1'b0;
                WE_dmem = 1'b0;
                if (EQ)
                    MUX_pc = PC_PLUS1_IMM; 
                else
                    MUX_pc = PC_PLUS1;  
            end

            JALR: begin
                FUNC_alu = F_PASS;  
                MUX_alu1 = 1'b0;
                MUX_alu2 = 1'b0;
                MUX_pc = PC_JALR; 
                MUX_rf = 1'b0;
                MUX_tgt = 2'b10;  
                WE_rf = 1'b1;
                WE_dmem = 1'b0;
            end

        endcase
    end

endmodule


