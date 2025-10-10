// RiSC-16 ALU

module alu (
    input [15:0] SRC1_rf, //reg
    input [15:0] SRC2_rf,
    input  [9:0]  instr10, //last 10 of instr
    input MUX_alu1, 
    input MUX_alu2, 
    input [1:0] FUNC_alu, //op select
    output reg [15:0] alu_out,
    output wire EQ  // BEQ
);

    wire [15:0] imm_lshift6 = {instr10, 6'b000000}; 
    wire [6:0] imm7 = instr10[6:0]; 
    wire [15:0] imm7_sext   = {{9{imm7[6]}}, imm7}; //sign-extend 7 -> 16

    wire [15:0] SRC1 = MUX_alu1 ? imm_lshift6 : SRC1_rf; //0: SRC1, 1: shift6
    wire [15:0] SRC2 = MUX_alu2 ? imm7_sext : SRC2_rf; //0: SRC2, 1: shift7

    assign EQ = (SRC1 == SRC2);

    always @(*) begin
        case (FUNC_alu)
            2'b00: alu_out = SRC1 + SRC2;      
            2'b01: alu_out = ~(SRC1 & SRC2);
            2'b10: alu_out = SRC1; 
            2'b11: alu_out = {15'b0, EQ};
            default: alu_out = 16'd0;
        endcase
    end
endmodule
