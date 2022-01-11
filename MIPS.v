
module CPU (Clock,HOLD,ACK);
	input Clock;
	input HOLD;
	output reg ACK;
	reg [31:0] PC, IR, Imemory[0:1023], Dmemory[0:1023], Regs[31:0],ALUout;
	wire [5:0] opcode, funct;
	wire [4:0] rs, rt, rd;
	wire [31:0] Ain, Bin;
	reg hold;
	assign opcode = IR[31:26];
	assign rs = IR[25:21];
	assign rt = IR[20:16];
	assign rd = IR[15:11];
	assign funct = IR[5:0];
	assign Ain = Regs[rs];
	assign Bin = Regs[rt];
	
	ClockGen C (CLK);
	assign Clock = CLK;

	initial 
	begin
	   	PC = 0;
		Imemory[0] = 32'b000000_10000_10001_10010_00000_100000;
		Regs[16] = 5;
		Regs[17] = 6;		
		Imemory[1] = 32'b000000_10000_10001_10010_00000_100010;
		Imemory[2] = 32'b000000_10000_10001_10010_00000_100100;
		Imemory[3] = 32'b000000_10000_10001_10010_00000_100101;
	end
	always@(HOLD)
	begin
		hold<=HOLD;
	end
	always @(posedge Clock ) begin
	if(hold==1)
	begin
		ACK<=1;
	end
	if(hold==0)
	begin 
		ACK<=0;
	end

	IR <= Imemory[PC >> 2];
	PC <= PC +4;
	
	if(opcode == 0)
	begin
		case(funct)
		32: ALUout = Ain + Bin;
		34: ALUout = Ain - Bin;
		36: ALUout = Ain&Bin;
		37: ALUout = Ain|Bin;
		endcase
	end
	end

 endmodule	