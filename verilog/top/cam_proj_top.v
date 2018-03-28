// author: shvlad (email: shvladspb@gmail.com)
// synopsys translate_off
`timescale 1 ns / 1 ns
// synopsys translate_on

module cam_proj_top
(
	//clocks & reset
	input wire clk50,             
	input wire rst,
	input wire start_gray_kn,
	//OV7670
	input wire [7:0] data_cam,
	input wire VSYNC_cam,
	input wire HREF_cam,
	input wire PCLK_cam,
	output wire XCLK_cam,
	output reg res_cam,
	output reg on_off_cam,
	output wire sioc,
	output wire siod,
	//VGA
	output wire hsync, 
	output wire [4:0] r,  
	output wire [5:0] g,
	output wire [4:0] b, 	
	//SDRAM
	output wire cs_n,
	output wire ras_n,
	output wire cas_n,
	output wire we_n,
	output wire [1:0] dqm,
	output wire [11:0] sd_addr,
	output wire [1:0] ba,
	output wire Cke,
	inout wire [15:0] sd_data, 
	output wire sdram_clk, 
	//TFT
	input tft_sdo,
	output wire tft_sck, 
	output wire tft_sdi, 
	output wire tft_dc, 
	output wire tft_reset, 
	output wire tft_cs,
	//LED
	output [7:0] LED
);

wire fbClk;
wire rst_n;
wire clk25;
wire clk100;
wire clk120;
wire clk24;
wire clk143;
wire clk2;
wire clk12;
wire [9:0] input_wrusedw; 
wire wr_strobe;
wire rd_strobe;
wire write_strobe;
wire read_strobe;
wire wait_strobe;
wire idle_strobe;
wire wr_input_fifo;
wire rd_input_fifo;
wire wr_output_fifo;
wire rd_output_fifo;
wire valid_data;
wire [15:0] input_fifo_to_sdram;
wire rd_ena;
wire sd_ready;
wire p_VSYNC_cam;
wire conf_done;

assign rst_n = rst;

assign sdram_clk = clk143;
wire read_finish;
wire STOP_capt;
wire visible_out;
wire wrfull;
wire rdempty;
wire wrfull_TFT;
wire rdempty_TFT;
wire next_capt;
wire locked;
wire [11:0] output_rdusedw_TFT;
wire vsync_TFT;
wire start_image;
wire [3:0] RESULT;
reg GO_NEIROSET;
wire end_neiroset;
reg [3:0] RESULT_2;

wire ctrl_busy;
wire [23:0] wr_addr;
wire wr_enable;
reg rd_enable_tst;
wire rd_enable;
wire [15:0] rd_data;
reg [23:0] rd_addr;
wire rdempty_cam,wrfull_cam;
wire kadr;

///////////////////////////////////////

reg [28:0] perem;
reg [28:0] perem_rd;
reg [28:0] perem_wait;
reg [28:0] perem_idle;
reg [28:0] perem_wrfull_TFT;
reg [28:0] perem_rdempty_TFT;
reg [27:0] sh;
reg y_wr;
reg y_rd;
reg y_wait;
reg y_idle;
reg y_wrfull_TFT;
reg y_rdempty_TFT;

always @(posedge clk143 or negedge rst_n) 
begin
	if ( !rst_n )
	begin
		sh = 28'b0;
		perem = 29'b0;
		perem_rd = 29'b0;
		perem_wait = 29'b0;
		perem_idle = 29'b0;
		perem_wrfull_TFT = 29'b0;
		perem_rdempty_TFT = 29'b0;
		y_wr = 1'b0;
		y_rd = 1'b0;
		y_wait = 1'b0;
		y_idle = 1'b0;
		y_wrfull_TFT = 1'b0;
		y_rdempty_TFT = 1'b0;
	end
	else
	begin
		sh = sh + 1'b1;
		//if (write_strobe) perem = perem+1'b1;
		//if (read_strobe) perem_rd = perem_rd+1'b1;
		if (wrfull_cam) perem_wait = perem_wait + 1'b1;
		if (rdempty_cam) perem_idle = perem_idle + 1'b1;
		if (wrfull_TFT) perem_wrfull_TFT = perem_wrfull_TFT + 1'b1; //28
		if (rdempty_TFT) perem_rdempty_TFT = perem_rdempty_TFT + 1'b1;	//28
		if (sh == 28'hFFFFFFF)
		begin
			sh = 28'h0;
			if (perem != 29'b0) y_wr = 1'b1; else y_wr = 1'b0;
			if (perem_rd != 29'b0) y_rd = 1'b1; else y_rd = 1'b0;
			if (perem_wait != 29'b0) y_wait = 1'b1; else y_wait = 1'b0;
			if (perem_idle != 29'b0) y_idle = 1'b1; else y_idle = 1'b0;
			if (perem_wrfull_TFT != 29'b0) y_wrfull_TFT = 1'b1; else y_wrfull_TFT = 1'b0;
			if (perem_rdempty_TFT != 29'b0) y_rdempty_TFT = 1'b1; else y_rdempty_TFT = 1'b0;
			perem = 29'b0;
			perem_rd = 29'b0;
			perem_wait = 29'b0;
			perem_idle = 29'b0;
			perem_wrfull_TFT = 29'b0;
			perem_rdempty_TFT = 29'b0;
		end
	end
end

///////////////////////////////////////

//LED
assign LED[0] = wr_enable;
assign LED[1] = rd_enable;
assign LED[2] = y_wrfull_TFT;
assign LED[3] = y_rdempty_TFT;
assign LED[4] = y_wait;
assign LED[5] = y_idle;
assign LED[6] = end_gray;
assign LED[7] = end_neiroset;


// Clocks

pll pll_for_sdram_0
(
	.areset   ( !rst_n ),
	.inclk0   ( clk50 ),
	.c0       ( clk100 ),
	.c1       ( clk120 ),
	.c2       ( clk25 ),
	.c3       ( clk24 ),
	.locked   ( locked )
);

pll_for_disp pll2
(
	.areset   ( !rst_n ),
	.inclk0   ( clk50 ),
	.c0       ( clk143 ),
	.c1       ( clk2 ),
	.c2       ( clk12 )

);

// Process data from camera

cam_wrp cam_wrp_0
(
	.rst_n                ( rst_n ),
	.data_cam             ( data_cam ),
	.VSYNC_cam            ( VSYNC_cam ),
	.HREF_cam             ( HREF_cam ),
	.PCLK_cam             ( PCLK_cam ),
	.clk_sdram            ( clk143 ),
	.output_rdusedw       ( input_wrusedw ),
	.ctrl_busy            ( ctrl_busy ),
	.input_fifo_to_sdram  ( input_fifo_to_sdram ),
	.addr_sdram           ( wr_addr ),
	.wr_enable            ( wr_enable ),
	.rdempty_cam          ( rdempty_cam ),
	.wrfull_cam           ( wrfull_cam ),
	.flag_read            ( rd_enable ),
	.kadr                 ( kadr )
);

assign XCLK_cam = clk24;

//TFT display

hellosoc_top TFT(
	.tft_sdo            ( tft_sdo ), 
	.tft_sck            ( tft_sck ), 
	.tft_sdi            ( tft_sdi ), 
	.tft_dc             ( tft_dc ), 
	.tft_reset          ( tft_reset ), 
	.tft_cs             ( tft_cs ),
	.rst_n              ( rst_n ),
	.clk_sdram          ( clk143 ),
	.wr_fifo            ( rd_enable_tst && ready ),
	.sdram_data         ( rd_data ),
	.tft_clk            ( clk100 ),
	.p_VSYNC_cam        ( p_VSYNC_cam ),
	.wrfull             ( wrfull_TFT ),
	.rdempty            ( rdempty_TFT ),
	.next_capt          ( next_capt ),
	.output_rdusedw     ( output_rdusedw_TFT ),
	.vsync              ( vsync_TFT ),
	.fbClk              ( fbClk ),
	.r                  ( r ),
	.g                  ( g ),
	.b                  ( b ),
	.start_to_GPIO      ( start_TFT ),
	.flag_read          ( flag_read ),
	.start_28           ( start_image ),
	.end_neiroset       ( end_neiroset ),
	.RESULT             ( RESULT_2 )
);


reg ready;
reg my_wr_enable;
reg [23:0] my_addr;
reg [3:0] wtf2;
	

always @(posedge clk143 or negedge rst_n)
begin
	if (!rst_n)
	begin
		rd_addr = 320*160;
		wtf2 = 4'b0;
		ready = 1'b0;
	end
	else
	begin
		if ((!ctrl_busy) && (!wr_enable) && (ready))
		begin
			if (rd_addr < 24'd76799)	
			begin
				wtf2 = wtf2+1'b1;
				if (wtf2 != 4'b1111) 
				begin
					rd_enable_tst = 1'b0;
				end
				else
				begin
					rd_addr = rd_addr + 1'b1;
					rd_enable_tst = 1'b1;
				end
			end
			else rd_addr=24'd0;
		end
		if (output_rdusedw_TFT <= 3000) ready = 1'b1;
		else                            ready = 1'b0;
	end
end
	
	
sdram_controller SDRAM(
	.wr_addr       (wr_addr),
	.wr_data       (input_fifo_to_sdram),
	.wr_enable     (wr_enable),
	.rd_addr       (rd_addr),
	.rd_data       (rd_data),
	.rd_ready      (rd_ready),
	.rd_enable     (rd_enable_tst && (ready)/*fbClk && (!my_wr_enable)*/),
	.busy          (ctrl_busy), 
	.rst_n         (rst_n), 
	.clk           (clk143),
	/* SDRAM SIDE */
	.addr          (sd_addr), 
	.bank_addr     (ba), 
	.data          (sd_data), 
	.clock_enable  (Cke),	 
	.cs_n          (cs_n), 
	.ras_n         (ras_n), 
	.cas_n         (cas_n), 
	.we_n          (we_n),	
	.data_mask_low (dqm[0]), 
	.data_mask_high(dqm[1]) 
);


reg start_gray;
wire end_gray;
reg [9:0] x_gray, y_gray;
wire [4:0] i_gray, j_gray;
wire [12:0] out_data_gray;
wire start_gray_load_GPIO;
wire start_TFT;
wire wrreq_gray;

pre_v2 grayscale(
	.clk           (fbClk), 
	.rst_n         (rst_n),
	.start         (start_gray), 
	.data          ({r,g,b}), 
	.end_pre       (end_gray), 
	.output_data   (out_data_gray), 
	.x             (x_gray), 
	.y             (y_gray), 
	.i             (i_gray), 
	.j             (j_gray) ,
	.data_req      (wrreq_gray)
);


TOP neiroset (
	.clk                (clk50),
	.GO                 (GO_NEIROSET),
	.RESULT             (RESULT),
	.we_database        (wrreq_gray),
	.dp_database        (out_data_gray),
	.address_p_database (j_gray*28+i_gray),
	.STOP               (end_neiroset),
	.rst_n              (rst_n)
);


always @(posedge fbClk or negedge rst_n) 
begin
	if ( !rst_n )
	begin
		x_gray = 10'd0;
		y_gray = 10'd0;
		start_gray = 1'b0;
		//GO_NEIROSET = 1'b1;
	end
	else
	begin
		if (start_image)
			begin
				if (x_gray == 10'd319) 
				begin
					x_gray <= 10'd0;
					if (y_gray == 10'd239) 
					begin
						y_gray <= 10'd0;
					end
					else y_gray <= y_gray+1'b1;
				end
				else x_gray <= x_gray+1'b1;
			end
			
		//if (end_gray) begin	/*start_gray=1'b0; if (end_neiroset==1'b1) */GO_NEIROSET=1'b0; end
		//else begin GO_NEIROSET=1'b1; end
		if (/*(start_gray_load_GPIO)&&*/(GO_NEIROSET == 1'b1) && (x_gray == 10'd47) && (y_gray == 10'd239)/*&&(end_neiroset==1'b1)*/) start_gray = 1'b1;
		if (end_gray) start_gray = 1'b0;
	end
end	


always @(posedge clk50 or negedge rst_n) 
begin
	if ( !rst_n )
	begin
		RESULT_2 = 4'b1111;
		GO_NEIROSET = 1'b1;
	end
	else
	begin
		if (end_gray) begin GO_NEIROSET = 1'b0; end
		if (end_neiroset) begin GO_NEIROSET = 1'b1; RESULT_2 = RESULT; end
	end
end


assign start_gray_load_GPIO = !start_gray_kn;


// start camera inititalization
reg [2:0] strt;

always @(posedge clk25 or negedge rst_n)
	if (!rst_n)
		strt <= 3'h0;
	else
	begin
		if (locked)
			begin
				if ( &strt )
					strt	<= strt;
				else
					strt	<= strt + 1'h1;
			end
	end

// camera inititalization
camera_configure 
#(	
	.CLK_FREQ 	( 25000000 )
)
camera_configure_0
(
	.clk   ( clk25            ),	
	.start ( ( strt == 3'h6 ) ),
	.sioc  ( sioc             ),
	.siod  ( siod             ),
	.done  ( conf_done        )
);

// reset camera with overall reset from button
assign res_cam    = rst_n;
assign on_off_cam = !rst_n;

endmodule
