module DMA_2(input [64:0] RAM_address,input [64:0] Disk_address,input [63:0] amount,input read,input write,
input[31:0] RamDataOut,input[31:0] DiskDataOut,
output reg[31:0]RamDataIn,output reg[31:0]DiskDatain,
output reg[64:0]RamAddressIn,output reg[64:0]DiskAddressIn,
output reg finish,input start,input clock,output reg HOLD,input ACK);

reg [64:0] ram;
reg [64:0] disk;
reg [63:0] size;
reg [63:0] size2;
reg [31:0] data;
reg bebebe=0;
reg w,r;
reg[64:0] cond=0;
reg[64:0] count=0;
reg nulldata=32'b0000;

ClockGen C (CLK);
assign clock = CLK; 

always@(RAM_address or amount or Disk_address)
begin
ram<=RAM_address;
disk<=Disk_address;
size<=amount;
size2<=amount;
r<=read;
w<=write;
bebebe<=1;
end
always@(bebebe)
begin 
$write("\n");
$write("\n");
$write("\n");
$write("\n");
$write("LOADED ");
$write("remaining size is %d",size);
$write("\n");
$write("r  is %d",r);
$write("\n");
$write("w is %d",w);
$write("\n");
$write("ram is %d",ram);
$write("\n");
$write("disk  is %d",disk);
$write("\n");
$write("\n");
$write("\n");
$write("LOADING FINISHED");
end
always@(start)
begin 
HOLD<=1;
end
always@(ACK or cond or negedge clock )
#10
begin 
finish<=0;
if(w==1)
begin
DiskDatain<=RamDataOut;
RamAddressIn<=ram+size;
DiskAddressIn<=disk+size;

RamDataIn<=nulldata;

if(size>0 )
begin

size<=size-1;
cond<=cond+1;
end
end
if(r==1)
begin
RamDataIn<=DiskDataOut;
$write("remaining size is %d",size);
$write("\n");
RamAddressIn<=ram+size;
$write("RAM ADDRESS is %d",RamAddressIn);
$write("\n");
DiskAddressIn<=disk+size;
$write("DISK ADDRESS is %d",DiskAddressIn);
$write("\n");

$write("DATA in is %d",RamDataIn);
$write("\n");
DiskDatain<=nulldata;

if(size>0)
begin

size<=size-1;
cond<=cond+1;
end
//if(size==0 && RamDataIn!=1'bx)
//begin
//size<=size2;
//end
end
if(w==1 && r==1)
begin
end
if(w==0 && r==0)
begin
end
if(size==0 && start==1 )
begin
finish<=1;
HOLD<=0;
end
end

endmodule