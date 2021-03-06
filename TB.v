`include "RAM.v"
`include "DISK.v"
`include "ClockGen.v"
`include "DMA_2.v"

module tb2();
wire [31:0] data;
ClockGen C (clock);
reg [64:0] RAM;
reg [64:0] DISK;
reg [63:0] size;
wire[64:0] ramdmaadd;
wire[64:0] diskdmaadd;
wire[31:0] diskdatain;
wire[31:0] diskdataout;
wire[31:0] ramdatain;
wire[31:0] ramdataout;
reg r;
reg w;
wire finish;
reg start;
integer i=0;
wire HOLD;
wire ACK;
initial
begin
 size<=20;
 r<=1;
 w<=0;
 DISK<=0;
 RAM<=0;
#10 start<=1;

end

DISK disk(.en_w(w),.en_r(r),.address(diskdmaadd),.DataIn(diskdatain),.DataOut(diskdataout),.Clock(clock));
CPU cpu(clock,HOLD,ACK);

RAM ram(.en_w(r),.en_r(w),.address(ramdmaadd),.DataIn(ramdatain),.DataOut(ramdataout),.clock(clock));

DMA_2 D1(.RAM_address(RAM),.Disk_address(DISK),.amount(size),.read(r),.write(w),
.RamDataOut(ramdataout),.DiskDataOut(diskdataout),
.RamDataIn(ramdatain),.DiskDatain(diskdatain),
.RamAddressIn(ramdmaadd),.DiskAddressIn(diskdmaadd),
 .finish(finish),.start(start),.clock(clock),.HOLD(HOLD),.ACK(ACK));


endmodule