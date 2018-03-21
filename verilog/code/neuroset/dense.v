module dense(clk,dense_en,STOP,in,out,we,re_p,re_w,read_addressp,read_addressw,write_addressp,memstartp,memstartzap,qp,qw,res,Y1,w11,w12,w13,w14,w15,w16,w17,w18,w19,p11,p12,p13,p14,p15,p16,p17,p18,p19,go,nozero);

parameter num_conv=0;

parameter SIZE=0;
parameter SIZE_2=0;
parameter SIZE_3=0;
parameter SIZE_4=0;
parameter SIZE_5=0;
parameter SIZE_6=0;
parameter SIZE_7=0;
parameter SIZE_8=0;
parameter SIZE_9=0;
parameter SIZE_address_pix=0;
parameter SIZE_address_wei=0;

input clk,dense_en;
output reg STOP;
input [8:0] in;
input [6:0] out;
output reg we,re_p,re_w;
output reg [SIZE_address_pix-1:0] read_addressp;
output reg [SIZE_address_wei-1:0] read_addressw;
output reg [SIZE_address_pix-1:0] write_addressp;
input [SIZE_address_pix-1:0] memstartp,memstartzap;
input signed [SIZE-1:0] qp;
input signed [SIZE_9-1:0] qw;
output reg signed [SIZE-1:0] res;
input signed [SIZE+SIZE-2:0] Y1;
output reg signed [SIZE-1:0] w11,w12,w13,w14,w15,w16,w17,w18,w19;
output reg signed [SIZE-1:0] p11,p12,p13,p14,p15,p16,p17,p18,p19;
output reg go;
input nozero;

reg [3:0] marker;
reg [6:0] lvl;
reg [8:0] i;
reg [8:0] j;
reg sh;
reg signed [SIZE+SIZE-2+1:0] dp;
reg signed [SIZE-1:0] dp_shift;
reg signed [SIZE-1+1:0]dp_check;

always @(posedge clk)           //in=98
begin
if (dense_en==1)
begin
re_p=1;
case (marker)
0:begin p18=qp[SIZE-1:0]; we=0; end
1:begin p19=qp[SIZE-1:0]; if (i!=1) begin go=1; j=j+1; end end
2:begin p11=qp[SIZE-1:0]; go=0; end
3:begin read_addressw=0+j*1; re_w=1; p12=qp[SIZE-1:0]; if (i!=3) dp=Y1+dp; end
4:begin re_w=0; p13=qp[SIZE-1:0];end
5:begin  p14=qp[SIZE-1:0]; w11=qw[SIZE_9-1:SIZE_8]; w12=qw[SIZE_8-1:SIZE_7]; w13=qw[SIZE_7-1:SIZE_6]; w14=qw[SIZE_6-1:SIZE_5]; w15=qw[SIZE_5-1:SIZE_4]; w16=qw[SIZE_4-1:SIZE_3]; w17=qw[SIZE_3-1:SIZE_2]; w18=qw[SIZE_2-1:SIZE]; w19=qw[SIZE-1:0]; end
6:begin  p15=qp[SIZE-1:0]; end
7:begin 	p16=qp[SIZE-1:0]; end
8:begin 	p17=qp[SIZE-1:0]; end
default: $display("Check case dense");
endcase

read_addressp=memstartp+i;

if (marker!=8) marker=marker+1; else marker=0;
i=i+1; 
if ((i>in+4)&&(marker==4)) 
	begin  
	   write_addressp=memstartzap+((lvl+1)>>(num_conv>>1))-1;  
		dp_check=dp[SIZE+SIZE-2+1:SIZE-1]; 
		if (dp_check>2**(SIZE-1)-1) 
			begin
				$display("OVERFLOW in dense!");
				dp_shift=2**(SIZE-1)-1;
			end
		else dp_shift=dp[SIZE+SIZE-2:SIZE-1];
		if ((dp_shift<0)&&(nozero==0)) dp_shift=0;  
		if (sh==0) begin res=0; res[SIZE-1:0]=dp_shift; end
		lvl=lvl+1; 
		i=0; 
		dp=0; 
		marker=0; 
		sh=sh+1; if (sh==num_conv) sh=0;  
		if ((sh==0)||(lvl==out)) we=1;
		if (lvl==out) begin STOP=1; if (sh!=0) write_addressp=write_addressp+1; end
	end
end
else 
begin
marker=0;
i=0;
j=0;
sh=0;
we=0;
dp=0;
res=0;
re_p=0;
re_w=0;
STOP=0;
lvl=0;
end
end
endmodule
