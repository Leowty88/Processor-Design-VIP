//RISC-16 PC

module pc(
  input clk,
  input reset,
  input [1:0] sel,

  
  input signed [6:0] imm7,
  input [15:0] alu_out, 
  output reg [15:0] pc
);
  
  wire [15:0] pc_plus1 = pc + 16'd1;
  wire signed [15:0] imm7_ext = imm7;
  wire [15:0] pc_plus1_imm = pc_plus1 + imm7_ext;
  
  reg [15:0] next_pc;
  always @(*) begin
      case (sel)
        2'b00: next_pc = pc_plus1;      // normal
        2'b01: next_pc = pc_plus1_imm;  // branch
        2'b10: next_pc = alu_out;          // jalr
        default: next_pc = pc_plus1;
      endcase
    end
  
  always @(posedge clk or negedge reset) begin 
    if(!reset) pc <= 16'b0;
    else pc <= next_pc;
  end 
  
endmodule
