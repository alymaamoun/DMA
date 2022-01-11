module RAM(input en_w,input en_r,input [64:0] address,input [31:0] DataIn,output reg [31:0] DataOut,input clock);
reg [31:0]MEM[0:64];
reg[64:0] adr;
ClockGen C (CLK);
assign clock = CLK;
integer i=0; 

initial
begin
MEM[0]=0;
MEM[1]=0;
MEM[2]=0;
MEM[3]=0;
MEM[4]=0;
MEM[5]=0;
MEM[6]=0;
MEM[7]=0;
MEM[8]=0;
MEM[9]=0;
MEM[10]=0;
MEM[11]=0;
MEM[12]=0;
MEM[13]=0;
MEM[14]=0;
MEM[15]=0;
MEM[16]=0;
MEM[17]=0;
MEM[18]=0;
MEM[19]=0;
MEM[20]=0;
$write("[Ram Init]    ");
        for(i = 0; i < 20; i = i + 1)begin
            $write("%d, ",MEM[i]);
        end
        $write("\n");

end

always@(negedge clock)
begin
if(en_r==1)
begin
DataOut<=MEM[adr];
end
if(en_w==1)
begin
MEM[adr]<=DataIn;
end
end
always@(posedge clock)
begin
if(en_r==1)
begin
adr<=address;
$monitor("location %d in RAM has data %d",adr,MEM[adr]);
end
if(en_w==1)
begin
adr<=address;
$monitor("location %d in RAM has data %d",adr,MEM[adr]);
end
end
endmodule

