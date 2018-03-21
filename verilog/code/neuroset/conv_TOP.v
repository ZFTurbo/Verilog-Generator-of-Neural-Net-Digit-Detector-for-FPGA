module conv_TOP(clk,conv_en,STOP,memstartp,memstartw,memstartzap,read_addressp,write_addressp,read_addresstp,write_addresstp,read_addressw,we,re_wb,re,we_t,re_t,qp,qtp,qw,dp,dtp,prov,matrix,matrix2,i_2,lvl,slvl,Y1,w15,w14,w16,w13,w17,w12,w18,w11,w19,/*w25,w24,w26,w23,w27,w22,w28,w21,w29,w35,w34,w36,w33,w37,w32,w38,w31,w39,w45,w44,w46,w43,w47,w42,w48,w41,w49,*/p1,p2,p3,p8,p7,p4,p5,p9,p6,go,num,filt,bias,globmaxp_en);

parameter SIZE=0;
parameter SIZE_2=0;
parameter SIZE_3=0;
parameter SIZE_4=0;
parameter SIZE_5=0;
parameter SIZE_6=0;
parameter SIZE_7=0;
parameter SIZE_8=0;
parameter SIZE_9=0;
parameter SIZE_address_pix=13;
parameter SIZE_address_pix_t=12;
parameter SIZE_address_wei=13;

input clk,conv_en,globmaxp_en;
input [1:0] prov;
input [4:0] matrix;
input [9:0] matrix2;
input [SIZE_address_pix-1:0] memstartp; 
input [SIZE_address_wei-1:0] memstartw;
input [SIZE_address_pix-1:0] memstartzap;                  																	
input [3:0] lvl;
input [1:0] slvl;
output reg [SIZE_address_pix-1:0] read_addressp;
output reg [SIZE_address_pix_t-1:0] read_addresstp;
output reg [SIZE_address_wei-1:0] read_addressw;
output reg [SIZE_address_pix-1:0] write_addressp;
output reg [SIZE_address_pix_t-1:0] write_addresstp;
output reg we,re,re_wb;
output reg we_t,re_t;
input signed [SIZE-1:0] qp;
input signed [SIZE+SIZE-2+1:0] qtp;
input signed [SIZE_9-1:0] qw;
output signed [SIZE-1:0] dp;
output signed [SIZE+SIZE-2+1:0] dtp;
output reg STOP;
output [9:0] i_2;
input signed [SIZE+SIZE-2:0] Y1;
output reg signed [SIZE-1:0]w11,w12,w13,w14,w15,w16,w17,w18,w19/*,w21,w22,w23,w24,w25,w26,w27,w28,w29,w31,w32,w33,w34,w35,w36,w37,w38,w39,w41,w42,w43,w44,w45,w46,w47,w48,w49*/;
output reg signed [SIZE-1:0]p1,p2,p3,p4,p5,p6,p7,p8,p9;
output reg go;
input [2:0] num;
input [2:0] filt;
input bias;

reg signed [SIZE-1:0] res_out_1/*,res2,res3,res4*/;
reg signed [SIZE+SIZE-2+1:0] res1/*,res2,res3,res4*/;
reg signed [SIZE+SIZE-2+1:0] res_old_1/*,res_old_2,res_old_3,res_old_4*/;
reg signed [SIZE-1:0] globmaxp_perem;

reg signed [SIZE-1:0] buff0 [2:0];
reg signed [SIZE-1:0] buff1 [2:0];
reg signed [SIZE-1:0] buff2 [2:0];

reg [3:0] marker;
reg zagryzka_weight;
reg [9:0] i;

reg signed [SIZE-1+1:0] res_bias_check;

initial zagryzka_weight=0;
initial marker=0;

always @(posedge clk)
begin
if (conv_en==1)        //enable convolution
	begin
		if (zagryzka_weight==0)        
		begin
		   case (marker)
				0: begin read_addressw=memstartw+2'd0; re_wb=1; end
				1: begin end
				2'd2: begin 
							w11=qw[SIZE-1:0]; 
							w12=qw[SIZE_2-1:SIZE]; 
							w13=qw[SIZE_3-1:SIZE_2]; 
							w14=qw[SIZE_4-1:SIZE_3]; 
							w15=qw[SIZE_5-1:SIZE_4]; 
							w16=qw[SIZE_6-1:SIZE_5]; 
							w17=qw[SIZE_7-1:SIZE_6]; 
							w18=qw[SIZE_8-1:SIZE_7]; 
							w19=qw[SIZE_9-1:SIZE_8]; 
						end
				2'd3: begin zagryzka_weight=1; re_wb=0; marker=-1; end
				default: $display("Check zagryzka_weight");
		endcase
		marker=marker+1;
		end
		else
		begin
			re=1;
			case (marker)
				0: begin		
								re_t=0;
								read_addressp=i+memstartp; 
								if ((i-1)<matrix2-matrix) 
								begin
								/*if ({lvl[1],lvl[0]}==2'b00) buff2[2]=qp[SIZE_4-1:SIZE_3];
								else if ({lvl[1],lvl[0]}==2'b01) buff2[2]=qp[SIZE_3-1:SIZE_2];
								else if ({lvl[1],lvl[0]}==2'b10) buff2[2]=qp[SIZE_2-1:SIZE];
								else if ({lvl[1],lvl[0]}==2'b11)*/ buff2[2]=qp[SIZE-1:0];
								end
								else buff2[2]=0;
								
								if (i>=2) go=1;
								
								
								p1=buff1[1];  //center
								p2=buff1[2];  //right
								p3=buff1[0];  //left
								p8=buff2[0];  //downright
								p7=buff0[2];  //up
								p4=buff2[1];  //downleft 
								p5=buff0[1];  //upright
								p9=buff2[2];  //upleft
								p6=buff0[0];  //down 
								
								
					end
				1: begin		if (i>=matrix-1) read_addressp=i-matrix+memstartp;
								/*res_old_1=qp[SIZE_4-1:SIZE_3];
								res_old_2=qp[SIZE_3-1:SIZE_2];
								res_old_3=qp[SIZE_2-1:SIZE];*/
								res_old_1=qtp;
								
								go=0;
								
								buff2[0]=buff2[1];
								buff1[0]=buff1[1];
								buff0[0]=buff0[1];
								buff2[1]=buff2[2];
								buff1[1]=buff1[2];
								buff0[1]=buff0[2];
					end
				2: begin    if (i<matrix2-matrix) read_addressp=i+matrix+memstartp;
								/*if ({lvl[1],lvl[0]}==2'b00) buff1[2]=qp[SIZE_4-1:SIZE_3];
								else if ({lvl[1],lvl[0]}==2'b01) buff1[2]=qp[SIZE_3-1:SIZE_2];
								else if ({lvl[1],lvl[0]}==2'b10) buff1[2]=qp[SIZE_2-1:SIZE];
								else if ({lvl[1],lvl[0]}==2'b11)*/ buff1[2]=qp[SIZE-1:0];
								
								if (i>=2) 
								begin
								we_t=1;
								write_addresstp=i-2+matrix2*num+slvl*((filt+1)*matrix2);
								if (globmaxp_en)  write_addressp=memstartzap;
								else	write_addressp=memstartzap+i-2;
								res1=Y1; if (lvl!=0) res1=res1+res_old_1; 
								if (bias==1) 
									begin  
										res_bias_check=res1[SIZE+SIZE-2+1:SIZE-1];
										if (res_bias_check>(2**(SIZE-1))-1) 
											begin
												$display("OVERFLOW in conv!");
												res_out_1=(2**(SIZE-1))-1;
												if (i==179) $display("res_out_1",res_out_1);
											end
										else res_out_1=res1[SIZE+SIZE-2:SIZE-1];
										if (res_out_1<0) res_out_1=0; 
										
										if (globmaxp_en)
											begin
												if (res_out_1>globmaxp_perem) globmaxp_perem=res_out_1;
										   end
										we=1;
									end
								end
								/*res2=Y2; if (lvl!=0) res2=res2+res_old_2; if (bias==1) begin res2=res2+bias2; if (res2<0) res2=0; end
								res3=Y3; if (lvl!=0) res3=res3+res_old_3; if (bias==1) begin res3=res3+bias3; if (res3<0) res3=0; end
								res4=Y4; if (lvl!=0) res4=res4+res_old_4; if (bias==1) begin res4=res4+bias4; if (res4<0) res4=0; end*/
					end
				3: begin		
								re_t=1;
								read_addresstp=i-1+matrix2*num+slvl*((filt+1)*matrix2);
								if (i>=matrix-1)
								begin
								/*if ({lvl[1],lvl[0]}==2'b00) buff0[2]=qp[SIZE_4-1:SIZE_3];
								else if ({lvl[1],lvl[0]}==2'b01) buff0[2]=qp[SIZE_3-1:SIZE_2];
								else if ({lvl[1],lvl[0]}==2'b10) buff0[2]=qp[SIZE_2-1:SIZE];
								else if ({lvl[1],lvl[0]}==2'b11)*/ buff0[2]=qp[SIZE-1:0];
								end
								else buff0[2]=0;
								
								we_t=0;
								we=0;
					end						
			default: $display("Check case conv_TOP");
			endcase
			
			if (marker!=3) marker=marker+1; 
			else begin 
					marker=0; 
					if (i<matrix2+1) i=i+1; 
					else STOP=1; 
				  end
		end
	end
else 
	begin
		i=0;
		zagryzka_weight=0;
		STOP=0;
		re=0;
		re_t=0;
		go=0;
		marker=0;
		globmaxp_perem=0;
	end
end
assign i_2=i-2;
assign dp=(globmaxp_en)?globmaxp_perem:res_out_1;
assign dtp={res1};
endmodule
