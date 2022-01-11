module ClockGen (Clock);
output Clock;
reg Clock;

initial
Clock = 0;

always
#1 Clock = ~Clock;

endmodule