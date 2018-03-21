//author: shvlad
//email: shvladspb@gmail.com
// synopsys translate_off
`timescale 1 ns / 100 ps
// synopsys translate_on
//`default_nettype none
module cam_wrp
//   #(	
		//parameter test = 1
//	)  	
(         
	input wire 					rst_n,
//
	input wire		[7:0]		data_cam,
	input wire					VSYNC_cam,
	input wire					HREF_cam,
	input wire					PCLK_cam,	
//
	input wire					clk_sdram,
	output wire		[9:0]		output_rdusedw,
	input wire					ctrl_busy,
	output wire		[15:0]	input_fifo_to_sdram,
	output reg 		[23:0]	addr_sdram,
	output reg					wr_enable,
	output rdempty_cam,
	output wrfull_cam,
	output reg		flag_read,
	output reg kadr
);
	reg		[15: 0]		data2fifo;	
	reg					sh_HREF_cam;
	reg 						wr_fifo;
	reg		[1:0]			wtf;
	
	always @( posedge PCLK_cam or negedge rst_n )
		if  ( ! rst_n )
			begin
				sh_HREF_cam	<= 1'h0;
			end			
		else
			begin
				sh_HREF_cam		<= HREF_cam;			
			end	

	always @( posedge PCLK_cam or negedge rst_n )
		if ( !rst_n )
			data2fifo	<= 16'h0;
		else
			if ( wr_fifo )
				data2fifo[7:0]	<= data_cam;
			else
				data2fifo[15:8]	<= data_cam;					

	always @( posedge PCLK_cam or negedge rst_n )
		if ( !rst_n )
			wr_fifo		<= 1'h0;
		else
			if ( HREF_cam )
				wr_fifo	<= !wr_fifo;
			else
				wr_fifo	<= 1'h0;
				
//assign wr_enable=((!ctrl_busy) && flag_read);			
			
	always @(negedge ctrl_busy or negedge rst_n)
		begin
			if (!rst_n)
				begin
					addr_sdram=24'd0;
					flag_read=1'b0;
					wr_enable=1'b0;
				end
			else
				begin
					if (output_rdusedw>100)	   flag_read=1'b1;
					else								flag_read=1'b0;
					if (flag_read)
						begin
							wr_enable=1'b1;
							if (addr_sdram<24'd76799)	addr_sdram=addr_sdram+1'b1;
							else 								addr_sdram=24'd0;
						end
					else							wr_enable=1'b0;
				end
		end
		
	
fifo_1024x16 input_fifo 
(	
	.aclr					  ( !rst_n							),	//
	.data					  ( data2fifo						),	//
	.rdclk              ( !ctrl_busy						),	//
	.rdreq              ( wr_enable 						),	//
	.wrclk              ( PCLK_cam						), //
	.wrreq              ( !wr_fifo && sh_HREF_cam	),	//
	.q                  ( input_fifo_to_sdram			),	//
	.rdempty            ( rdempty_cam					),
	.rdusedw            ( output_rdusedw				),				
	.wrfull             ( wrfull_cam						),
	.wrusedw            ( 									)
);

endmodule


