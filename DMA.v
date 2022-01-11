


module DMA(input [64:0] RAM_address,input [64:0] Disk_address,input [64:0] amount,input read,input write,output reg finish,input start,input clock);
reg [64:0] ram;
reg [64:0] disk;
reg [64:0] size;
reg [31:0] data;
reg [31:0]datadi,datado,datari,dataro;
wire[31:0] ddataro,ddatado;

reg w,r;
reg wd,wr,rd,rr,started;
reg[64:0] cond=0;
reg[64:0] count=0;
reg nulldata=32'b0000;
 RAM R1(.en_w(wr),.en_r(rr),.address(ram+count),.DataIn(datari),.DataOut(ddataro),.clock(clock));
 DISK D1(.en_w(wd),.en_r(rd),.address(disk+count),.DataIn(datadi),.DataOut(ddatado),.Clock(clock));
	ClockGen C (CLK);
	assign clock = CLK; 


always@(RAM_address or Disk_address or amount)
begin
ram<=RAM_address;
disk<=Disk_address;
size<=amount;
r<=read;
w<=write;
end

always@(start or cond )
begin
started<=1;
if(write==1)
#20
begin
wr<=0;
rr<=1;
wd<=1;
rd<=0;
datari<=nulldata;
datadi<=ddataro;
datado<=nulldata;
count<=count+1;
$monitor("Size now fetching in DMA  is %d",size);
size<=size-1;
if(size>=0)
begin
cond<=cond+1;
finish<=0;
end
else
begin
finish<=1;
end
end
else 
#20
begin
wr<=1;
rr<=0;
wd<=0;
rd<=1;
datadi<=nulldata;

datadi<=ddatado;
count<=count+1;
size<=size-1;
$monitor("Size now fetching in DMA  is %d",size);
if(size>=0)
begin
cond<=cond+1;
finish<=0;
end
else
begin
finish<=1;
end
end
if(size<1)
finish<=1;
end

endmodule

