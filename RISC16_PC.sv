//RISC-16 PC

module program_counter(
  input clk,
  input reset,
  input branch_en,
  input jalr_en,
  
  input signed [6:0] imm7,
  input [15:0] regB, 
  output reg [15:0] pc
);
  
  wire [15:0] pc_plus1 = pc + 16'd1;
  wire signed [15:0] imm7_ext = imm7;
  wire [15:0] pc_plus1_imm = pc_plus1 + imm7_ext;
  
  reg [15:0] next_pc;
  always @(*) begin 
    next_pc = pc_plus1;
    if (branch_en) next_pc = pc_plus1_imm;
    if (jalr_en) next_pc = regB;
  end
  
  always @(posedge clk) begin 
    if(reset) pc <= 16'b0;
    else pc <= next_pc;
  end 
  
endmodule
