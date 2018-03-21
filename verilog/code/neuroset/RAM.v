module RAM(qp,qtp,qw,dp,dtp,dw,write_addressp,read_addressp,write_addresstp,read_addresstp,write_addressw,read_addressw,we_p,we_tp,we_w,re_p,re_tp,re_w,clk);
parameter picture_storage_limit=784;	
parameter SIZE=13;
parameter SIZE_4=SIZE*4;
parameter SIZE_9=SIZE*9;
parameter SIZE_address_pix=13;
parameter SIZE_address_pix_t=12;
parameter SIZE_address_wei=13;

output reg signed [SIZE-1:0] qp;       //read data
output reg signed [SIZE+SIZE-2+1:0] qtp;       //read data
output reg signed [SIZE_9-1:0] qw;      //read weight
input signed [SIZE-1:0] dp;   //write data
input signed [SIZE+SIZE-2+1:0] dtp;   //write data
input signed [SIZE_9-1:0] dw;   //write weight
input [SIZE_address_pix-1:0] write_addressp, read_addressp;
input [SIZE_address_pix_t-1:0] write_addresstp, read_addresstp;
input [SIZE_address_wei-1:0] write_addressw, read_addressw;
input we_p;
input we_tp;
input we_w;
input re_p;
input re_tp;
input re_w;
input clk;		

reg signed [SIZE-1:0] mem [0:picture_storage_limit*8+picture_storage_limit-1];
reg signed [SIZE+SIZE-2+1:0] mem_t [0:picture_storage_limit*4-1];
reg signed [SIZE_9-1:0] weight [0:351];   
always @ (posedge clk) 
    begin
        if (we_p) mem[write_addressp] <= dp;
		  if (we_tp)mem_t[write_addresstp] <= dtp;
		  if (we_w) weight[write_addressw] <= dw;
    end
always @ (posedge clk)
    begin
        if (re_p) qp <= mem[read_addressp];
		  if (re_tp)qtp <= mem_t[read_addresstp];
        if (re_w) qw <= weight[read_addressw];
    end
endmodule