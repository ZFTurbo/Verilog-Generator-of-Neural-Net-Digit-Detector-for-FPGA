module hellosoc_top(
	input tft_sdo, 
	output wire tft_sck, 
	output wire tft_sdi, 
	output wire tft_dc, 
	output wire tft_reset, 
	output wire tft_cs,
	input			rst_n,
	input 		clk_sdram,
	input			wr_fifo,
	input [15:0] sdram_data,
	input tft_clk,
	input p_VSYNC_cam,
	output wrfull,
	output rdempty,
	output next_capt,
	output [11:0] output_rdusedw,
	output reg vsync,
	output fbClk,
	output [4:0] r,
	output [5:0] g,
	output [4:0] b,
	output reg start_to_GPIO,
	input flag_read,
	output reg start_28,
	input end_neiroset,
	input [3:0] RESULT,
	output [23:0] address_sdram
	);
	reg start;
	wire [15:0] q;
	assign r={q[15],q[14],q[13],q[12],q[11]};
	assign g={q[10],q[9],q[8],q[7],q[6],q[5]};
	assign b={q[4],q[3],q[2],q[1],q[0]};
	//assign r={sdram_data[15],sdram_data[14],sdram_data[13],sdram_data[12],sdram_data[11]};
	//assign g={sdram_data[10],sdram_data[9],sdram_data[8],sdram_data[7],sdram_data[6],sdram_data[5]};
	//assign b={sdram_data[4],sdram_data[3],sdram_data[2],sdram_data[1],sdram_data[0]};
	assign address_sdram=y*320+x_out;
	// X,Y calc
	reg [9:0] x;
	reg [9:0] y;
	
	wire [15:0] data2fifo_test;
	reg [15:0] one;
	initial one=16'b0000011111100000;
	reg [15:0] two;
	initial two=16'b0000000000011111;
	assign data2fifo_test=(x<=10)?one:(((x>=100)&&(x<=200))?one:two);
	

	fifo_big fifo_tft
(
	.aclr				( !rst_n			),
	.data				( /*data2fifo_test*/ sdram_data	),
	.rdclk              ( fbClk		),
	.rdreq              ( start 	),
	.wrclk              ( clk_sdram			),
	.wrreq              ( wr_fifo  ),  //load_pixels  ), 
	.q                  ( q					),
	.rdempty            ( rdempty					),
	.rdusedw            ( output_rdusedw	),
	.wrfull             ( wrfull					),
	.wrusedw            ( 					)
);
	

	wire valid;
	reg [9:0] str;
	reg [8:0] x_out;
	reg [8:0] y_out;
	initial x_out=9'd239;
	initial y_out=9'd319;
	//assign  valid=(((x>=199)&&(x<439)) && ((y>=79)&&(y<399)))?1'b1:1'b0;//блокировать лишнюю инфу по х и у
	always @ (posedge clk_sdram or negedge rst_n) 
	begin
		if ( !rst_n )
			begin
					x=10'd319;
					y=10'd239;
					start=1'b0;
					vsync=1'b0;
					start_28=1'b0;
			end
		else
			begin
				if (wr_fifo)
					begin
						if (x==10'd319) 
						begin
							x<=10'd0;
							if (y==10'd239) 
								begin
									y<=10'd0;
								end
							else y<=y+1'b1;
						end
						else x<=x+1'b1;
					end
				if ((wr_fifo)&&(x==10'd318)&&(y==10'd239)) vsync=1'b1;
				else vsync=1'b0;
					
					
				if ((x_out==9'd13)&&(y_out==9'd47)) start=1'b1;
				if ((x_out==9'd260)&&(y_out==9'd47)) start_28=1'b1;
				
				
				if ((x==10'd319)&&(y==10'd239)) next_capt=1'b1;
			end	
	end	
	

	always @(posedge fbClk or negedge rst_n) begin
		if ( !rst_n )
			begin
				start_to_GPIO=1'b0;
			end
		else
			begin
				if (x_out==9'd319) 
						begin
							x_out<=9'd0;
							if (y_out==9'd239) 
								begin
									y_out<=9'd0;
								end
							else y_out<=y_out+1'b1;
						end
				else x_out<=x_out+1'b1;
				
				if ((x_out==9'd240)&&(y_out==9'd48)&&(flag_read==1'b1)) start_to_GPIO=1'b1; 
		
			end
		
		end
		
		
	//assign framebufferIndex=(480*y)+x;
	
	//rbg
	//16'b0 00 0000 0 0000 0 100 - green
	//16'b0 00 0000 0 1000 0 000 - blue
	//16'b0 00 1000 0 0000 0 000 - red
	wire [15:0] currentPixel;
	wire RES_0,RES_1,RES_2,RES_3,RES_4,RES_5,RES_6,RES_7,RES_8,RES_9,RES_10;
	assign RES_0=(((x_out>250)&&(x_out<254)&&(y_out>5)&&(y_out<43))||((x_out>274)&&(x_out<278)&&(y_out>5)&&(y_out<43))||((x_out>253)&&(x_out<275)&&(y_out>5)&&(y_out<9))||((x_out>253)&&(x_out<275)&&(y_out>39)&&(y_out<43)))?1'b1:1'b0;
	
	assign RES_1=(((x_out>274)&&(x_out<278)&&(y_out>5)&&(y_out<43))||((y_out>5)&&(y_out<26)&&((x_out==240-y_out+43)||(x_out==240-y_out-1+43)||(x_out==240-y_out-2+43)||(x_out==240-y_out-3+43))))?1'b1:1'b0;
	
	assign RES_2=(((x_out>250)&&(x_out<254)&&(y_out>22)&&(y_out<43))||((x_out>274)&&(x_out<278)&&(y_out>5)&&(y_out<26))||((x_out>250)&&(x_out<275)&&(y_out>5)&&(y_out<9))||((x_out>253)&&(x_out<278)&&(y_out>39)&&(y_out<43))||((x_out>253)&&(x_out<275)&&(y_out>22)&&(y_out<26)))?1'b1:1'b0;
	assign RES_3=(((x_out>274)&&(x_out<278)&&(y_out>5)&&(y_out<43))||((x_out>250)&&(x_out<275)&&(y_out>5)&&(y_out<9))||((x_out>250)&&(x_out<275)&&(y_out>39)&&(y_out<43))||((x_out>250)&&(x_out<275)&&(y_out>22)&&(y_out<26)))?1'b1:1'b0;
	assign RES_4=(((x_out>250)&&(x_out<254)&&(y_out>5)&&(y_out<26))||((x_out>274)&&(x_out<278)&&(y_out>5)&&(y_out<43))||((x_out>253)&&(x_out<275)&&(y_out>22)&&(y_out<26)))?1'b1:1'b0;
	assign RES_5=(((x_out>250)&&(x_out<254)&&(y_out>5)&&(y_out<26))||((x_out>274)&&(x_out<278)&&(y_out>22)&&(y_out<43))||((x_out>253)&&(x_out<278)&&(y_out>5)&&(y_out<9))||((x_out>250)&&(x_out<275)&&(y_out>39)&&(y_out<43))||((x_out>253)&&(x_out<275)&&(y_out>22)&&(y_out<26)))?1'b1:1'b0;
	assign RES_6=(((x_out>250)&&(x_out<254)&&(y_out>5)&&(y_out<43))||((x_out>274)&&(x_out<278)&&(y_out>22)&&(y_out<43))||((x_out>253)&&(x_out<278)&&(y_out>5)&&(y_out<9))||((x_out>253)&&(x_out<275)&&(y_out>39)&&(y_out<43))||((x_out>253)&&(x_out<275)&&(y_out>22)&&(y_out<26)))?1'b1:1'b0;
	assign RES_7=(((x_out>274)&&(x_out<278)&&(y_out>5)&&(y_out<43))||((x_out>250)&&(x_out<275)&&(y_out>5)&&(y_out<9)))?1'b1:1'b0;
	assign RES_8=(((x_out>250)&&(x_out<254)&&(y_out>5)&&(y_out<43))||((x_out>274)&&(x_out<278)&&(y_out>5)&&(y_out<43))||((x_out>253)&&(x_out<275)&&(y_out>5)&&(y_out<9))||((x_out>253)&&(x_out<275)&&(y_out>39)&&(y_out<43))||((x_out>253)&&(x_out<275)&&(y_out>22)&&(y_out<26)))?1'b1:1'b0;
	assign RES_9=(((x_out>250)&&(x_out<254)&&(y_out>5)&&(y_out<26))||((x_out>274)&&(x_out<278)&&(y_out>5)&&(y_out<43))||((x_out>253)&&(x_out<275)&&(y_out>5)&&(y_out<9))||((x_out>250)&&(x_out<275)&&(y_out>39)&&(y_out<43))||((x_out>253)&&(x_out<275)&&(y_out>22)&&(y_out<26)))?1'b1:1'b0;
	assign RES_10=((x_out>254)&&(x_out<274)&&(y_out>22)&&(y_out<26))?1'b1:1'b0;
	assign currentPixel = ((x_out<288)&&(x_out>240)&&(y_out>=0)&&(y_out<47))?( ((RESULT==4'd10)?((RES_10)?16'h0:16'hFFFF):((RESULT==4'd0)?((RES_0)?16'h0:16'hFFFF):((RESULT==4'd1)?((RES_1)?16'h0:16'hFFFF):((RESULT==4'd2)?((RES_2)?16'h0:16'hFFFF):((RESULT==4'd3)?((RES_3)?16'h0:16'hFFFF):((RESULT==4'd4)?((RES_4)?16'h0:16'hFFFF):((RESULT==4'd5)?((RES_5)?16'h0:16'hFFFF):((RESULT==4'd6)?((RES_6)?16'h0:16'hFFFF):((RESULT==4'd7)?((RES_7)?16'h0:16'hFFFF):((RESULT==4'd8)?((RES_8)?16'h0:16'hFFFF):((RESULT==4'd9)?((RES_9)?16'h0:16'hFFFF):(16'hFFFF))))))))))))                            ):(((((y_out==9'd56)||(y_out==9'd40))&&(((x_out>=9'd288)&&(x_out<=9'd320))||((x_out>=9'd0)&&(x_out<=9'd192))))||(x_out==9'd192)||(x_out==288))?16'b0001111100000000:{g[2],g[1],g[0],r[4],r[3],r[2],r[1],r[0],b[4],b[3],b[2],b[1],b[0],g[5],g[4],g[3]})/*:((RESULT==4'd10)?((RES_10)?16'h0:16'hFFFF):((RESULT==4'd0)?((RES_0)?16'h0:16'hFFFF):((RESULT==4'd1)?((RES_1)?16'h0:16'hFFFF):((RESULT==4'd2)?((RES_2)?16'h0:16'hFFFF):((RESULT==4'd3)?((RES_3)?16'h0:16'hFFFF):((RESULT==4'd4)?((RES_4)?16'h0:16'hFFFF):((RESULT==4'd5)?((RES_5)?16'h0:16'hFFFF):((RESULT==4'd6)?((RES_6)?16'h0:16'hFFFF):((RESULT==4'd7)?((RES_7)?16'h0:16'hFFFF):((RESULT==4'd8)?((RES_8)?16'h0:16'hFFFF):((RESULT==4'd9)?((RES_9)?16'h0:16'hFFFF):(16'hFFFF))))))))))))*/; 
	//assign currentPixel = {g_reg[4][0],1'b0,1'b0,r_reg[4][3],r_reg[4][2],r_reg[4][1],r_reg[4][0],1'b0,b_reg[4][3],b_reg[4][2],b_reg[4][1],b_reg[4][0],1'b0,g_reg[4][3],g_reg[4][2],g_reg[4][1]}; 

	// *************************** TFT Module
	tft_ili9341 #(.INPUT_CLK_MHZ(100)) tft(tft_clk, tft_sdo, tft_sck, tft_sdi, tft_dc, tft_reset, tft_cs, currentPixel, fbClk);

endmodule
