// RISC-16 Register File

module register_file(
    input clk,
    input WE_rf,             
    input [1:0] MUX_tgt,          
    input MUX_rf,            
    input [15:0] alu_out,
    input [15:0] mem_out,
    input [15:0] pc,
    input [2:0] rA, rB, rC,      
    output [15:0] reg_out1,         
    output [15:0] reg_out2      
);

    reg [15:0] regs [7:0];

    integer i;
    initial begin
        for (i = 0; i < 8; i = i + 1)
            regs[i] = 16'd0;
    end

    reg [15:0] write_data;
    always @(*) begin
        case (MUX_tgt)
            2'b00: write_data = mem_out;
            2'b01: write_data = alu_out; 
            2'b10: write_data = pc + 16'd1;   
            default: write_data = 16'd0;
        endcase
    end

    wire [2:0] tgt_reg = rA;

    assign reg_out1 = regs[rB];                 
    assign reg_out2 = WE_rf ? regs[rC] : regs[rA];   

    always @(posedge clk) begin
        regs[0] <= 16'd0;                   
        if (WE_rf && (tgt_reg != 3'd0))
          regs[tgt_reg] <= write_data;
    end

endmodule
