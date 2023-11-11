`timescale 1ns / 1ps

module testbench;
	reg clk;
	reg reset;
	reg [31:12] Instr;
	reg [3:0] ALUFlags;
	wire PCWrite;
	wire MemWrite;
	wire RegWrite;
	wire IRWrite;
	wire AdrSrc;
	wire [1:0] RegSrc;
	wire [1:0] ALUSrcA;
	wire [1:0] ALUSrcB;
	wire [1:0] ResultSrc;
	wire [1:0] ImmSrc;
	wire [1:0] ALUControl;

  controller cont(
    .clk(clk),
	  .reset(reset),
	  .Instr(Instr),
	  .ALUFlags(ALUFlags),
	  .PCWrite(PCWrite),
	  .MemWrite(MemWrite),
	  .RegWrite(RegWrite),
	  .IRWrite(IRWrite),
	  .AdrSrc(AdrSrc),
	  .RegSrc(RegSrc),
	  .ALUSrcA(ALUSrcA),
	  .ALUSrcB(ALUSrcB),
	  .ResultSrc(ResultSrc),
	  .ImmSrc(ImmSrc),
	  .ALUControl(ALUControl)
  );

	always #5 clk = ~clk;

  initial begin
    clk = 0;
    reset = 1; #15
    reset = 0;
    $dumpfile("testbench.vcd");
    $dumpvars(0,testbench);

    Instr = 'hE04F0; // SUB
    ALUFlags = 4'b0000;
    #50
    Instr = 'hE2802; // ADD
    #50
    Instr = 'hE1874; // ORR
    #50
    Instr = 'hE0855; // AND
    #50
    Instr = 'h4A000; // BMI
    #50
    Instr = 'hE5802; // STR
    #50
    Instr = 'hE5902; // LDR
    ALUFlags = 4'b1111;
    #50
    Instr = 'h0A000; // BEQ
    #50
    $finish;
  end

endmodule
