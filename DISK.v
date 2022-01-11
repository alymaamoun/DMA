
module DISK(en_w,en_r,address,DataIn,DataOut,Clock);
input Clock;
input en_w,en_r;
input [64:0] address;
input [31:0] DataIn;
output reg [31:0] DataOut;
reg [31:0]MEM[0:64];
reg [64:0] adr;
ClockGen C (CLK);
assign Clock = CLK; 
integer i=0;
initial
begin
MEM[0]=1;
MEM[1]=2;
MEM[2]=3;
MEM[3]=4;
MEM[4]=5;
MEM[5]=6;
MEM[6]=7;
MEM[7]=8;
MEM[8]=9;
MEM[9]=10;
MEM[10]=11;
MEM[11]=12;
MEM[12]=13;
MEM[13]=14;
MEM[14]=15;
MEM[15]=16;
MEM[16]=17;
MEM[17]=18;
MEM[18]=19;
MEM[19]=20;
MEM[20]=21;
$write("[DISK Init]    ");
        for(i = 0; i < 20; i = i + 1)begin
            $write("%d, ",MEM[i]);
        end
        $write("\n");
end

always@(negedge Clock )

begin
adr<=address;
if(en_r==1)
begin
DataOut<=MEM[adr];
end
if(en_w==1)
begin
MEM[adr]<=DataIn;
end
end
always@(posedge Clock)
begin
if(en_r==1)
begin
adr<=address;
$monitor("location %d has data %d",adr,MEM[adr]);
end
if(en_w==1)
begin
adr<=address;
$monitor("location %d has data %d",adr,MEM[adr]);
end
end
endmodule

