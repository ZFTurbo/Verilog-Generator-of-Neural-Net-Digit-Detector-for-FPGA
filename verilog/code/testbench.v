module test();

parameter SIZE=11;

  reg clk;
  reg GO;
  reg signed [SIZE-1:0] storage [0:783]; 
  
  reg we_database;
  reg [SIZE-1:0] dp_database;
  reg [12:0] address_p_database;
  
  reg [9:0] x;
  
  wire [3:0] RESULT;
  TOP TOP(
	.clk					(clk),
	.GO						(GO),
	.RESULT					(RESULT),
	.we_database			(we_database), 
	.dp_database			(dp_database), 
	.address_p_database		(address_p_database-1'b1),
	.STOP					(STOP)
  );
initial begin
  clk=0;
  address_p_database=0;
  x=0;
  we_database=1;
  #200 GO=1;
end
always #10 clk=~clk;
always @(posedge clk)
	begin
		if (we_database)
		begin
			if (address_p_database<=783) 
				begin
						dp_database = storage[address_p_database];
						address_p_database=address_p_database+1'b1;
				end
			else we_database=0;
		end
		if ((x<=28*28)&&(GO)) x=x+1;
		else GO=0;
	if (STOP==1)
	begin
		$display("RESULT: %d",RESULT);
		$finish;
	end
 end
 
initial
begin
	storage[0] =  10'b1001111000; // [0.6171875]
	storage[1] =  10'b1001111100; // [0.62109375]
	storage[2] =  10'b1010000000; // [0.625]
	storage[3] =  10'b1010001000; // [0.6328125]
	storage[4] =  10'b1010001100; // [0.63671875]
	storage[5] =  10'b1010001100; // [0.63671875]
	storage[6] =  10'b1010000100; // [0.62890625]
	storage[7] =  10'b1001101000; // [0.6015625]
	storage[8] =  10'b1000101100; // [0.54296875]
	storage[9] =  10'b0111101100; // [0.48046875]
	storage[10] =  10'b0110101100; // [0.41796875]
	storage[11] =  10'b0110010000; // [0.390625]
	storage[12] =  10'b0110001100; // [0.38671875]
	storage[13] =  10'b0110100000; // [0.40625]
	storage[14] =  10'b0111000000; // [0.4375]
	storage[15] =  10'b1000000100; // [0.50390625]
	storage[16] =  10'b1001010100; // [0.58203125]
	storage[17] =  10'b1010000100; // [0.62890625]
	storage[18] =  10'b1010010100; // [0.64453125]
	storage[19] =  10'b1010010100; // [0.64453125]
	storage[20] =  10'b1010011000; // [0.6484375]
	storage[21] =  10'b1010010000; // [0.640625]
	storage[22] =  10'b1010010000; // [0.640625]
	storage[23] =  10'b1010001100; // [0.63671875]
	storage[24] =  10'b1010001000; // [0.6328125]
	storage[25] =  10'b1010000100; // [0.62890625]
	storage[26] =  10'b1010000000; // [0.625]
	storage[27] =  10'b1001111000; // [0.6171875]
	storage[28] =  10'b1001110100; // [0.61328125]
	storage[29] =  10'b1001111100; // [0.62109375]
	storage[30] =  10'b1010000000; // [0.625]
	storage[31] =  10'b1010001000; // [0.6328125]
	storage[32] =  10'b1010001100; // [0.63671875]
	storage[33] =  10'b1010000100; // [0.62890625]
	storage[34] =  10'b1001011000; // [0.5859375]
	storage[35] =  10'b0111001000; // [0.4453125]
	storage[36] =  10'b0101001000; // [0.3203125]
	storage[37] =  10'b0100011100; // [0.27734375]
	storage[38] =  10'b0100001100; // [0.26171875]
	storage[39] =  10'b0100011100; // [0.27734375]
	storage[40] =  10'b0100011100; // [0.27734375]
	storage[41] =  10'b0100011100; // [0.27734375]
	storage[42] =  10'b0100011100; // [0.27734375]
	storage[43] =  10'b0101010000; // [0.328125]
	storage[44] =  10'b0111011000; // [0.4609375]
	storage[45] =  10'b1001011100; // [0.58984375]
	storage[46] =  10'b1010001000; // [0.6328125]
	storage[47] =  10'b1010010100; // [0.64453125]
	storage[48] =  10'b1010010100; // [0.64453125]
	storage[49] =  10'b1010010000; // [0.640625]
	storage[50] =  10'b1010010100; // [0.64453125]
	storage[51] =  10'b1010001100; // [0.63671875]
	storage[52] =  10'b1010001100; // [0.63671875]
	storage[53] =  10'b1010000100; // [0.62890625]
	storage[54] =  10'b1010000000; // [0.625]
	storage[55] =  10'b1001111000; // [0.6171875]
	storage[56] =  10'b1001110000; // [0.609375]
	storage[57] =  10'b1001111000; // [0.6171875]
	storage[58] =  10'b1010000000; // [0.625]
	storage[59] =  10'b1010000100; // [0.62890625]
	storage[60] =  10'b1010000000; // [0.625]
	storage[61] =  10'b1001100100; // [0.59765625]
	storage[62] =  10'b0111011100; // [0.46484375]
	storage[63] =  10'b0100101000; // [0.2890625]
	storage[64] =  10'b0011111100; // [0.24609375]
	storage[65] =  10'b0101000000; // [0.3125]
	storage[66] =  10'b0110110100; // [0.42578125]
	storage[67] =  10'b0111101100; // [0.48046875]
	storage[68] =  10'b0111000100; // [0.44140625]
	storage[69] =  10'b0101100100; // [0.34765625]
	storage[70] =  10'b0100100000; // [0.28125]
	storage[71] =  10'b0100001100; // [0.26171875]
	storage[72] =  10'b0101011000; // [0.3359375]
	storage[73] =  10'b0111111100; // [0.49609375]
	storage[74] =  10'b1001110000; // [0.609375]
	storage[75] =  10'b1010001100; // [0.63671875]
	storage[76] =  10'b1010010000; // [0.640625]
	storage[77] =  10'b1010010100; // [0.64453125]
	storage[78] =  10'b1010010000; // [0.640625]
	storage[79] =  10'b1010001100; // [0.63671875]
	storage[80] =  10'b1010001000; // [0.6328125]
	storage[81] =  10'b1010000100; // [0.62890625]
	storage[82] =  10'b1010000000; // [0.625]
	storage[83] =  10'b1001111100; // [0.62109375]
	storage[84] =  10'b1001110100; // [0.61328125]
	storage[85] =  10'b1001111000; // [0.6171875]
	storage[86] =  10'b1001111100; // [0.62109375]
	storage[87] =  10'b1001111100; // [0.62109375]
	storage[88] =  10'b1001101100; // [0.60546875]
	storage[89] =  10'b1000010000; // [0.515625]
	storage[90] =  10'b0100111100; // [0.30859375]
	storage[91] =  10'b0011111100; // [0.24609375]
	storage[92] =  10'b0101010100; // [0.33203125]
	storage[93] =  10'b1000000100; // [0.50390625]
	storage[94] =  10'b1001110000; // [0.609375]
	storage[95] =  10'b1010000100; // [0.62890625]
	storage[96] =  10'b1001110000; // [0.609375]
	storage[97] =  10'b1000011100; // [0.52734375]
	storage[98] =  10'b0110010000; // [0.390625]
	storage[99] =  10'b0100101000; // [0.2890625]
	storage[100] =  10'b0100100100; // [0.28515625]
	storage[101] =  10'b0110100100; // [0.41015625]
	storage[102] =  10'b1001000000; // [0.5625]
	storage[103] =  10'b1010000000; // [0.625]
	storage[104] =  10'b1010001100; // [0.63671875]
	storage[105] =  10'b1010010100; // [0.64453125]
	storage[106] =  10'b1010010000; // [0.640625]
	storage[107] =  10'b1010010000; // [0.640625]
	storage[108] =  10'b1010001000; // [0.6328125]
	storage[109] =  10'b1010000100; // [0.62890625]
	storage[110] =  10'b1010000000; // [0.625]
	storage[111] =  10'b1001111100; // [0.62109375]
	storage[112] =  10'b1001110100; // [0.61328125]
	storage[113] =  10'b1001110100; // [0.61328125]
	storage[114] =  10'b1001111000; // [0.6171875]
	storage[115] =  10'b1001110100; // [0.61328125]
	storage[116] =  10'b1001000000; // [0.5625]
	storage[117] =  10'b0101110000; // [0.359375]
	storage[118] =  10'b0100000000; // [0.25]
	storage[119] =  10'b0100101100; // [0.29296875]
	storage[120] =  10'b0111101100; // [0.48046875]
	storage[121] =  10'b1001111000; // [0.6171875]
	storage[122] =  10'b1010010100; // [0.64453125]
	storage[123] =  10'b1010011100; // [0.65234375]
	storage[124] =  10'b1010100000; // [0.65625]
	storage[125] =  10'b1001110100; // [0.61328125]
	storage[126] =  10'b1000000100; // [0.50390625]
	storage[127] =  10'b0101101100; // [0.35546875]
	storage[128] =  10'b0100101000; // [0.2890625]
	storage[129] =  10'b0101011100; // [0.33984375]
	storage[130] =  10'b1000001000; // [0.5078125]
	storage[131] =  10'b1001110000; // [0.609375]
	storage[132] =  10'b1010001000; // [0.6328125]
	storage[133] =  10'b1010010000; // [0.640625]
	storage[134] =  10'b1010010100; // [0.64453125]
	storage[135] =  10'b1010010000; // [0.640625]
	storage[136] =  10'b1010001100; // [0.63671875]
	storage[137] =  10'b1010001000; // [0.6328125]
	storage[138] =  10'b1010000000; // [0.625]
	storage[139] =  10'b1001111100; // [0.62109375]
	storage[140] =  10'b1001110100; // [0.61328125]
	storage[141] =  10'b1001111000; // [0.6171875]
	storage[142] =  10'b1001110100; // [0.61328125]
	storage[143] =  10'b1001100000; // [0.59375]
	storage[144] =  10'b0111100100; // [0.47265625]
	storage[145] =  10'b0100011100; // [0.27734375]
	storage[146] =  10'b0100011000; // [0.2734375]
	storage[147] =  10'b0110110000; // [0.421875]
	storage[148] =  10'b1001011100; // [0.58984375]
	storage[149] =  10'b1010001100; // [0.63671875]
	storage[150] =  10'b1010100000; // [0.65625]
	storage[151] =  10'b1010110000; // [0.671875]
	storage[152] =  10'b1010101000; // [0.6640625]
	storage[153] =  10'b1010100000; // [0.65625]
	storage[154] =  10'b1001100100; // [0.59765625]
	storage[155] =  10'b0111101100; // [0.48046875]
	storage[156] =  10'b0101100100; // [0.34765625]
	storage[157] =  10'b0101001100; // [0.32421875]
	storage[158] =  10'b0111010100; // [0.45703125]
	storage[159] =  10'b1001100000; // [0.59375]
	storage[160] =  10'b1010001100; // [0.63671875]
	storage[161] =  10'b1010011000; // [0.6484375]
	storage[162] =  10'b1010011000; // [0.6484375]
	storage[163] =  10'b1010011000; // [0.6484375]
	storage[164] =  10'b1010010100; // [0.64453125]
	storage[165] =  10'b1010001100; // [0.63671875]
	storage[166] =  10'b1010000100; // [0.62890625]
	storage[167] =  10'b1001111100; // [0.62109375]
	storage[168] =  10'b1001110100; // [0.61328125]
	storage[169] =  10'b1001110100; // [0.61328125]
	storage[170] =  10'b1001110000; // [0.609375]
	storage[171] =  10'b1000111100; // [0.55859375]
	storage[172] =  10'b0101111000; // [0.3671875]
	storage[173] =  10'b0100100000; // [0.28125]
	storage[174] =  10'b0110001000; // [0.3828125]
	storage[175] =  10'b1001000000; // [0.5625]
	storage[176] =  10'b1010001000; // [0.6328125]
	storage[177] =  10'b1010011100; // [0.65234375]
	storage[178] =  10'b1010110000; // [0.671875]
	storage[179] =  10'b1010110100; // [0.67578125]
	storage[180] =  10'b1010110000; // [0.671875]
	storage[181] =  10'b1010101100; // [0.66796875]
	storage[182] =  10'b1010011100; // [0.65234375]
	storage[183] =  10'b1001010000; // [0.578125]
	storage[184] =  10'b0111000100; // [0.44140625]
	storage[185] =  10'b0101011100; // [0.33984375]
	storage[186] =  10'b0110110100; // [0.42578125]
	storage[187] =  10'b1001001100; // [0.57421875]
	storage[188] =  10'b1010001000; // [0.6328125]
	storage[189] =  10'b1010100000; // [0.65625]
	storage[190] =  10'b1010100000; // [0.65625]
	storage[191] =  10'b1010100000; // [0.65625]
	storage[192] =  10'b1010011000; // [0.6484375]
	storage[193] =  10'b1010010000; // [0.640625]
	storage[194] =  10'b1010001000; // [0.6328125]
	storage[195] =  10'b1001111100; // [0.62109375]
	storage[196] =  10'b1001110100; // [0.61328125]
	storage[197] =  10'b1001111000; // [0.6171875]
	storage[198] =  10'b1001100100; // [0.59765625]
	storage[199] =  10'b0111111100; // [0.49609375]
	storage[200] =  10'b0100111000; // [0.3046875]
	storage[201] =  10'b0101000000; // [0.3125]
	storage[202] =  10'b0111101100; // [0.48046875]
	storage[203] =  10'b1001111100; // [0.62109375]
	storage[204] =  10'b1010011000; // [0.6484375]
	storage[205] =  10'b1010101100; // [0.66796875]
	storage[206] =  10'b1010111100; // [0.68359375]
	storage[207] =  10'b1010111100; // [0.68359375]
	storage[208] =  10'b1010111000; // [0.6796875]
	storage[209] =  10'b1010110100; // [0.67578125]
	storage[210] =  10'b1010101100; // [0.66796875]
	storage[211] =  10'b1010000000; // [0.625]
	storage[212] =  10'b1000000000; // [0.5]
	storage[213] =  10'b0101110100; // [0.36328125]
	storage[214] =  10'b0110101000; // [0.4140625]
	storage[215] =  10'b1001000000; // [0.5625]
	storage[216] =  10'b1010001000; // [0.6328125]
	storage[217] =  10'b1010100000; // [0.65625]
	storage[218] =  10'b1010101000; // [0.6640625]
	storage[219] =  10'b1010100000; // [0.65625]
	storage[220] =  10'b1010100000; // [0.65625]
	storage[221] =  10'b1010010000; // [0.640625]
	storage[222] =  10'b1010001100; // [0.63671875]
	storage[223] =  10'b1010000000; // [0.625]
	storage[224] =  10'b1001111000; // [0.6171875]
	storage[225] =  10'b1001110100; // [0.61328125]
	storage[226] =  10'b1001010100; // [0.58203125]
	storage[227] =  10'b0110110100; // [0.42578125]
	storage[228] =  10'b0100100000; // [0.28125]
	storage[229] =  10'b0101110100; // [0.36328125]
	storage[230] =  10'b1000110100; // [0.55078125]
	storage[231] =  10'b1010001100; // [0.63671875]
	storage[232] =  10'b1010101100; // [0.66796875]
	storage[233] =  10'b1010111000; // [0.6796875]
	storage[234] =  10'b1011000000; // [0.6875]
	storage[235] =  10'b1011000000; // [0.6875]
	storage[236] =  10'b1011000000; // [0.6875]
	storage[237] =  10'b1010111100; // [0.68359375]
	storage[238] =  10'b1010110000; // [0.671875]
	storage[239] =  10'b1010010100; // [0.64453125]
	storage[240] =  10'b1000100000; // [0.53125]
	storage[241] =  10'b0110001000; // [0.3828125]
	storage[242] =  10'b0110010100; // [0.39453125]
	storage[243] =  10'b1000110000; // [0.546875]
	storage[244] =  10'b1010000100; // [0.62890625]
	storage[245] =  10'b1010100100; // [0.66015625]
	storage[246] =  10'b1010101000; // [0.6640625]
	storage[247] =  10'b1010101100; // [0.66796875]
	storage[248] =  10'b1010011100; // [0.65234375]
	storage[249] =  10'b1010011000; // [0.6484375]
	storage[250] =  10'b1010001100; // [0.63671875]
	storage[251] =  10'b1010000000; // [0.625]
	storage[252] =  10'b1001110000; // [0.609375]
	storage[253] =  10'b1001110000; // [0.609375]
	storage[254] =  10'b1000111100; // [0.55859375]
	storage[255] =  10'b0101111100; // [0.37109375]
	storage[256] =  10'b0100100000; // [0.28125]
	storage[257] =  10'b0110110100; // [0.42578125]
	storage[258] =  10'b1001101100; // [0.60546875]
	storage[259] =  10'b1010011100; // [0.65234375]
	storage[260] =  10'b1010110100; // [0.67578125]
	storage[261] =  10'b1011000000; // [0.6875]
	storage[262] =  10'b1011000000; // [0.6875]
	storage[263] =  10'b1011000000; // [0.6875]
	storage[264] =  10'b1011000000; // [0.6875]
	storage[265] =  10'b1011000000; // [0.6875]
	storage[266] =  10'b1010111000; // [0.6796875]
	storage[267] =  10'b1010100000; // [0.65625]
	storage[268] =  10'b1000110000; // [0.546875]
	storage[269] =  10'b0110011000; // [0.3984375]
	storage[270] =  10'b0101110000; // [0.359375]
	storage[271] =  10'b1000011000; // [0.5234375]
	storage[272] =  10'b1001111100; // [0.62109375]
	storage[273] =  10'b1010100000; // [0.65625]
	storage[274] =  10'b1010101000; // [0.6640625]
	storage[275] =  10'b1010100100; // [0.66015625]
	storage[276] =  10'b1010100000; // [0.65625]
	storage[277] =  10'b1010011000; // [0.6484375]
	storage[278] =  10'b1010001000; // [0.6328125]
	storage[279] =  10'b1010000100; // [0.62890625]
	storage[280] =  10'b1001110000; // [0.609375]
	storage[281] =  10'b1001101000; // [0.6015625]
	storage[282] =  10'b1000011000; // [0.5234375]
	storage[283] =  10'b0101001100; // [0.32421875]
	storage[284] =  10'b0100110100; // [0.30078125]
	storage[285] =  10'b0111101000; // [0.4765625]
	storage[286] =  10'b1010000000; // [0.625]
	storage[287] =  10'b1010100000; // [0.65625]
	storage[288] =  10'b1010111000; // [0.6796875]
	storage[289] =  10'b1010111100; // [0.68359375]
	storage[290] =  10'b1011000000; // [0.6875]
	storage[291] =  10'b1011000000; // [0.6875]
	storage[292] =  10'b1011000100; // [0.69140625]
	storage[293] =  10'b1011000000; // [0.6875]
	storage[294] =  10'b1010111000; // [0.6796875]
	storage[295] =  10'b1010100100; // [0.66015625]
	storage[296] =  10'b1000111100; // [0.55859375]
	storage[297] =  10'b0110100000; // [0.40625]
	storage[298] =  10'b0101011100; // [0.33984375]
	storage[299] =  10'b1000001000; // [0.5078125]
	storage[300] =  10'b1001111000; // [0.6171875]
	storage[301] =  10'b1010011100; // [0.65234375]
	storage[302] =  10'b1010101000; // [0.6640625]
	storage[303] =  10'b1010100100; // [0.66015625]
	storage[304] =  10'b1010011100; // [0.65234375]
	storage[305] =  10'b1010011000; // [0.6484375]
	storage[306] =  10'b1010001000; // [0.6328125]
	storage[307] =  10'b1010000000; // [0.625]
	storage[308] =  10'b1001110100; // [0.61328125]
	storage[309] =  10'b1001100000; // [0.59375]
	storage[310] =  10'b0111110000; // [0.484375]
	storage[311] =  10'b0100110000; // [0.296875]
	storage[312] =  10'b0101001100; // [0.32421875]
	storage[313] =  10'b1000100100; // [0.53515625]
	storage[314] =  10'b1010001000; // [0.6328125]
	storage[315] =  10'b1010101000; // [0.6640625]
	storage[316] =  10'b1010110100; // [0.67578125]
	storage[317] =  10'b1010111000; // [0.6796875]
	storage[318] =  10'b1010111000; // [0.6796875]
	storage[319] =  10'b1011000000; // [0.6875]
	storage[320] =  10'b1011000000; // [0.6875]
	storage[321] =  10'b1011000000; // [0.6875]
	storage[322] =  10'b1010111000; // [0.6796875]
	storage[323] =  10'b1010100100; // [0.66015625]
	storage[324] =  10'b1000111000; // [0.5546875]
	storage[325] =  10'b0110100000; // [0.40625]
	storage[326] =  10'b0101011000; // [0.3359375]
	storage[327] =  10'b1000000000; // [0.5]
	storage[328] =  10'b1001110100; // [0.61328125]
	storage[329] =  10'b1010011000; // [0.6484375]
	storage[330] =  10'b1010100000; // [0.65625]
	storage[331] =  10'b1010100000; // [0.65625]
	storage[332] =  10'b1010011100; // [0.65234375]
	storage[333] =  10'b1010010000; // [0.640625]
	storage[334] =  10'b1010000100; // [0.62890625]
	storage[335] =  10'b1001111100; // [0.62109375]
	storage[336] =  10'b1001110000; // [0.609375]
	storage[337] =  10'b1001010000; // [0.578125]
	storage[338] =  10'b0110111100; // [0.43359375]
	storage[339] =  10'b0100011100; // [0.27734375]
	storage[340] =  10'b0101110000; // [0.359375]
	storage[341] =  10'b1000111100; // [0.55859375]
	storage[342] =  10'b1010010000; // [0.640625]
	storage[343] =  10'b1010100100; // [0.66015625]
	storage[344] =  10'b1010110000; // [0.671875]
	storage[345] =  10'b1010110000; // [0.671875]
	storage[346] =  10'b1010110100; // [0.67578125]
	storage[347] =  10'b1010111000; // [0.6796875]
	storage[348] =  10'b1010111000; // [0.6796875]
	storage[349] =  10'b1010111000; // [0.6796875]
	storage[350] =  10'b1010101100; // [0.66796875]
	storage[351] =  10'b1010011000; // [0.6484375]
	storage[352] =  10'b1000110100; // [0.55078125]
	storage[353] =  10'b0110011000; // [0.3984375]
	storage[354] =  10'b0101010100; // [0.33203125]
	storage[355] =  10'b1000001000; // [0.5078125]
	storage[356] =  10'b1001110100; // [0.61328125]
	storage[357] =  10'b1010010000; // [0.640625]
	storage[358] =  10'b1010100000; // [0.65625]
	storage[359] =  10'b1010011100; // [0.65234375]
	storage[360] =  10'b1010010100; // [0.64453125]
	storage[361] =  10'b1010001100; // [0.63671875]
	storage[362] =  10'b1010000100; // [0.62890625]
	storage[363] =  10'b1001111000; // [0.6171875]
	storage[364] =  10'b1001101000; // [0.6015625]
	storage[365] =  10'b1001000000; // [0.5625]
	storage[366] =  10'b0110010000; // [0.390625]
	storage[367] =  10'b0100011100; // [0.27734375]
	storage[368] =  10'b0110011000; // [0.3984375]
	storage[369] =  10'b1001010100; // [0.58203125]
	storage[370] =  10'b1010001100; // [0.63671875]
	storage[371] =  10'b1010100000; // [0.65625]
	storage[372] =  10'b1010101100; // [0.66796875]
	storage[373] =  10'b1010101100; // [0.66796875]
	storage[374] =  10'b1010101100; // [0.66796875]
	storage[375] =  10'b1010110000; // [0.671875]
	storage[376] =  10'b1010110100; // [0.67578125]
	storage[377] =  10'b1010101100; // [0.66796875]
	storage[378] =  10'b1010100100; // [0.66015625]
	storage[379] =  10'b1010001100; // [0.63671875]
	storage[380] =  10'b1000101000; // [0.5390625]
	storage[381] =  10'b0110001000; // [0.3828125]
	storage[382] =  10'b0101011100; // [0.33984375]
	storage[383] =  10'b1000011000; // [0.5234375]
	storage[384] =  10'b1001111000; // [0.6171875]
	storage[385] =  10'b1010010100; // [0.64453125]
	storage[386] =  10'b1010010100; // [0.64453125]
	storage[387] =  10'b1010010100; // [0.64453125]
	storage[388] =  10'b1010010000; // [0.640625]
	storage[389] =  10'b1010001000; // [0.6328125]
	storage[390] =  10'b1010000000; // [0.625]
	storage[391] =  10'b1001111000; // [0.6171875]
	storage[392] =  10'b1001100100; // [0.59765625]
	storage[393] =  10'b1000110000; // [0.546875]
	storage[394] =  10'b0101111100; // [0.37109375]
	storage[395] =  10'b0100011100; // [0.27734375]
	storage[396] =  10'b0110110000; // [0.421875]
	storage[397] =  10'b1001100000; // [0.59375]
	storage[398] =  10'b1010010000; // [0.640625]
	storage[399] =  10'b1010011100; // [0.65234375]
	storage[400] =  10'b1010100100; // [0.66015625]
	storage[401] =  10'b1010101000; // [0.6640625]
	storage[402] =  10'b1010110000; // [0.671875]
	storage[403] =  10'b1010110000; // [0.671875]
	storage[404] =  10'b1010110000; // [0.671875]
	storage[405] =  10'b1010101100; // [0.66796875]
	storage[406] =  10'b1010100100; // [0.66015625]
	storage[407] =  10'b1001111100; // [0.62109375]
	storage[408] =  10'b1000000000; // [0.5]
	storage[409] =  10'b0101011100; // [0.33984375]
	storage[410] =  10'b0101101000; // [0.3515625]
	storage[411] =  10'b1000101000; // [0.5390625]
	storage[412] =  10'b1001111100; // [0.62109375]
	storage[413] =  10'b1010010100; // [0.64453125]
	storage[414] =  10'b1010010100; // [0.64453125]
	storage[415] =  10'b1010010100; // [0.64453125]
	storage[416] =  10'b1010001100; // [0.63671875]
	storage[417] =  10'b1010000100; // [0.62890625]
	storage[418] =  10'b1001111100; // [0.62109375]
	storage[419] =  10'b1001110100; // [0.61328125]
	storage[420] =  10'b1001100100; // [0.59765625]
	storage[421] =  10'b1000101000; // [0.5390625]
	storage[422] =  10'b0101111100; // [0.37109375]
	storage[423] =  10'b0100101000; // [0.2890625]
	storage[424] =  10'b0110110100; // [0.42578125]
	storage[425] =  10'b1001100100; // [0.59765625]
	storage[426] =  10'b1010001100; // [0.63671875]
	storage[427] =  10'b1010011100; // [0.65234375]
	storage[428] =  10'b1010100000; // [0.65625]
	storage[429] =  10'b1010100100; // [0.66015625]
	storage[430] =  10'b1010101000; // [0.6640625]
	storage[431] =  10'b1010101000; // [0.6640625]
	storage[432] =  10'b1010101100; // [0.66796875]
	storage[433] =  10'b1010101100; // [0.66796875]
	storage[434] =  10'b1010100100; // [0.66015625]
	storage[435] =  10'b1001101000; // [0.6015625]
	storage[436] =  10'b0111010000; // [0.453125]
	storage[437] =  10'b0100110000; // [0.296875]
	storage[438] =  10'b0101110000; // [0.359375]
	storage[439] =  10'b1000110100; // [0.55078125]
	storage[440] =  10'b1010000000; // [0.625]
	storage[441] =  10'b1010010000; // [0.640625]
	storage[442] =  10'b1010010000; // [0.640625]
	storage[443] =  10'b1010010000; // [0.640625]
	storage[444] =  10'b1010001000; // [0.6328125]
	storage[445] =  10'b1010000000; // [0.625]
	storage[446] =  10'b1001111000; // [0.6171875]
	storage[447] =  10'b1001110100; // [0.61328125]
	storage[448] =  10'b1001100000; // [0.59375]
	storage[449] =  10'b1000110000; // [0.546875]
	storage[450] =  10'b0110010000; // [0.390625]
	storage[451] =  10'b0100101000; // [0.2890625]
	storage[452] =  10'b0110100100; // [0.41015625]
	storage[453] =  10'b1001010000; // [0.578125]
	storage[454] =  10'b1010001000; // [0.6328125]
	storage[455] =  10'b1010010000; // [0.640625]
	storage[456] =  10'b1010011100; // [0.65234375]
	storage[457] =  10'b1010011000; // [0.6484375]
	storage[458] =  10'b1010011100; // [0.65234375]
	storage[459] =  10'b1010101000; // [0.6640625]
	storage[460] =  10'b1010101000; // [0.6640625]
	storage[461] =  10'b1010101000; // [0.6640625]
	storage[462] =  10'b1010011100; // [0.65234375]
	storage[463] =  10'b1000111100; // [0.55859375]
	storage[464] =  10'b0110001000; // [0.3828125]
	storage[465] =  10'b0100011000; // [0.2734375]
	storage[466] =  10'b0110001000; // [0.3828125]
	storage[467] =  10'b1001000000; // [0.5625]
	storage[468] =  10'b1010000000; // [0.625]
	storage[469] =  10'b1010001100; // [0.63671875]
	storage[470] =  10'b1010001100; // [0.63671875]
	storage[471] =  10'b1010001000; // [0.6328125]
	storage[472] =  10'b1010000000; // [0.625]
	storage[473] =  10'b1001111100; // [0.62109375]
	storage[474] =  10'b1001111000; // [0.6171875]
	storage[475] =  10'b1001110000; // [0.609375]
	storage[476] =  10'b1001101000; // [0.6015625]
	storage[477] =  10'b1001000100; // [0.56640625]
	storage[478] =  10'b0111000100; // [0.44140625]
	storage[479] =  10'b0100110000; // [0.296875]
	storage[480] =  10'b0110011000; // [0.3984375]
	storage[481] =  10'b1001001000; // [0.5703125]
	storage[482] =  10'b1010000000; // [0.625]
	storage[483] =  10'b1010010100; // [0.64453125]
	storage[484] =  10'b1010010100; // [0.64453125]
	storage[485] =  10'b1010011100; // [0.65234375]
	storage[486] =  10'b1010100000; // [0.65625]
	storage[487] =  10'b1010101000; // [0.6640625]
	storage[488] =  10'b1010101100; // [0.66796875]
	storage[489] =  10'b1010100100; // [0.66015625]
	storage[490] =  10'b1001111000; // [0.6171875]
	storage[491] =  10'b0111100100; // [0.47265625]
	storage[492] =  10'b0100110100; // [0.30078125]
	storage[493] =  10'b0100010000; // [0.265625]
	storage[494] =  10'b0111001000; // [0.4453125]
	storage[495] =  10'b1001100000; // [0.59375]
	storage[496] =  10'b1010001100; // [0.63671875]
	storage[497] =  10'b1010010000; // [0.640625]
	storage[498] =  10'b1010010100; // [0.64453125]
	storage[499] =  10'b1010001100; // [0.63671875]
	storage[500] =  10'b1010000100; // [0.62890625]
	storage[501] =  10'b1001111100; // [0.62109375]
	storage[502] =  10'b1001111000; // [0.6171875]
	storage[503] =  10'b1001110100; // [0.61328125]
	storage[504] =  10'b1001101100; // [0.60546875]
	storage[505] =  10'b1001010000; // [0.578125]
	storage[506] =  10'b0111110100; // [0.48828125]
	storage[507] =  10'b0101001000; // [0.3203125]
	storage[508] =  10'b0110001000; // [0.3828125]
	storage[509] =  10'b1000111000; // [0.5546875]
	storage[510] =  10'b1001111100; // [0.62109375]
	storage[511] =  10'b1010001100; // [0.63671875]
	storage[512] =  10'b1010010100; // [0.64453125]
	storage[513] =  10'b1010011000; // [0.6484375]
	storage[514] =  10'b1010100000; // [0.65625]
	storage[515] =  10'b1010101000; // [0.6640625]
	storage[516] =  10'b1010101000; // [0.6640625]
	storage[517] =  10'b1010100000; // [0.65625]
	storage[518] =  10'b1000110100; // [0.55078125]
	storage[519] =  10'b0101111100; // [0.37109375]
	storage[520] =  10'b0100000000; // [0.25]
	storage[521] =  10'b0100100000; // [0.28125]
	storage[522] =  10'b1000001100; // [0.51171875]
	storage[523] =  10'b1001110100; // [0.61328125]
	storage[524] =  10'b1010010000; // [0.640625]
	storage[525] =  10'b1010011000; // [0.6484375]
	storage[526] =  10'b1010001100; // [0.63671875]
	storage[527] =  10'b1010001100; // [0.63671875]
	storage[528] =  10'b1010000100; // [0.62890625]
	storage[529] =  10'b1001111100; // [0.62109375]
	storage[530] =  10'b1001111000; // [0.6171875]
	storage[531] =  10'b1001110000; // [0.609375]
	storage[532] =  10'b1001100100; // [0.59765625]
	storage[533] =  10'b1001010100; // [0.58203125]
	storage[534] =  10'b1000011000; // [0.5234375]
	storage[535] =  10'b0101111000; // [0.3671875]
	storage[536] =  10'b0101011100; // [0.33984375]
	storage[537] =  10'b1000001000; // [0.5078125]
	storage[538] =  10'b1001110000; // [0.609375]
	storage[539] =  10'b1010000100; // [0.62890625]
	storage[540] =  10'b1010001100; // [0.63671875]
	storage[541] =  10'b1010010100; // [0.64453125]
	storage[542] =  10'b1010011000; // [0.6484375]
	storage[543] =  10'b1010100100; // [0.66015625]
	storage[544] =  10'b1010100100; // [0.66015625]
	storage[545] =  10'b1001111100; // [0.62109375]
	storage[546] =  10'b0111110000; // [0.484375]
	storage[547] =  10'b0100101100; // [0.29296875]
	storage[548] =  10'b0011101000; // [0.2265625]
	storage[549] =  10'b0101001000; // [0.3203125]
	storage[550] =  10'b1000101100; // [0.54296875]
	storage[551] =  10'b1001111100; // [0.62109375]
	storage[552] =  10'b1010010100; // [0.64453125]
	storage[553] =  10'b1010001100; // [0.63671875]
	storage[554] =  10'b1010001000; // [0.6328125]
	storage[555] =  10'b1010000000; // [0.625]
	storage[556] =  10'b1001111000; // [0.6171875]
	storage[557] =  10'b1001110100; // [0.61328125]
	storage[558] =  10'b1001110000; // [0.609375]
	storage[559] =  10'b1001101100; // [0.60546875]
	storage[560] =  10'b1001011100; // [0.58984375]
	storage[561] =  10'b1001011000; // [0.5859375]
	storage[562] =  10'b1000110100; // [0.55078125]
	storage[563] =  10'b0110111100; // [0.43359375]
	storage[564] =  10'b0101010000; // [0.328125]
	storage[565] =  10'b0111001000; // [0.4453125]
	storage[566] =  10'b1001011100; // [0.58984375]
	storage[567] =  10'b1001111100; // [0.62109375]
	storage[568] =  10'b1010001000; // [0.6328125]
	storage[569] =  10'b1010001100; // [0.63671875]
	storage[570] =  10'b1010011100; // [0.65234375]
	storage[571] =  10'b1010011100; // [0.65234375]
	storage[572] =  10'b1010100000; // [0.65625]
	storage[573] =  10'b1001011100; // [0.58984375]
	storage[574] =  10'b0110110100; // [0.42578125]
	storage[575] =  10'b0100001000; // [0.2578125]
	storage[576] =  10'b0011101000; // [0.2265625]
	storage[577] =  10'b0110000100; // [0.37890625]
	storage[578] =  10'b1001001100; // [0.57421875]
	storage[579] =  10'b1010000100; // [0.62890625]
	storage[580] =  10'b1010010100; // [0.64453125]
	storage[581] =  10'b1010001000; // [0.6328125]
	storage[582] =  10'b1010000000; // [0.625]
	storage[583] =  10'b1001111100; // [0.62109375]
	storage[584] =  10'b1001111000; // [0.6171875]
	storage[585] =  10'b1001110000; // [0.609375]
	storage[586] =  10'b1001101000; // [0.6015625]
	storage[587] =  10'b1001100100; // [0.59765625]
	storage[588] =  10'b1001011100; // [0.58984375]
	storage[589] =  10'b1001011100; // [0.58984375]
	storage[590] =  10'b1001001100; // [0.57421875]
	storage[591] =  10'b1000001000; // [0.5078125]
	storage[592] =  10'b0101110000; // [0.359375]
	storage[593] =  10'b0110001100; // [0.38671875]
	storage[594] =  10'b1000101000; // [0.5390625]
	storage[595] =  10'b1001110100; // [0.61328125]
	storage[596] =  10'b1010000100; // [0.62890625]
	storage[597] =  10'b1010001100; // [0.63671875]
	storage[598] =  10'b1010010000; // [0.640625]
	storage[599] =  10'b1010010100; // [0.64453125]
	storage[600] =  10'b1001111100; // [0.62109375]
	storage[601] =  10'b1000000000; // [0.5]
	storage[602] =  10'b0101001000; // [0.3203125]
	storage[603] =  10'b0011100100; // [0.22265625]
	storage[604] =  10'b0100000000; // [0.25]
	storage[605] =  10'b0111011000; // [0.4609375]
	storage[606] =  10'b1001101000; // [0.6015625]
	storage[607] =  10'b1010001000; // [0.6328125]
	storage[608] =  10'b1010001100; // [0.63671875]
	storage[609] =  10'b1010000100; // [0.62890625]
	storage[610] =  10'b1010000000; // [0.625]
	storage[611] =  10'b1001111100; // [0.62109375]
	storage[612] =  10'b1001110100; // [0.61328125]
	storage[613] =  10'b1001101100; // [0.60546875]
	storage[614] =  10'b1001100100; // [0.59765625]
	storage[615] =  10'b1001011100; // [0.58984375]
	storage[616] =  10'b1001011000; // [0.5859375]
	storage[617] =  10'b1001011000; // [0.5859375]
	storage[618] =  10'b1001011000; // [0.5859375]
	storage[619] =  10'b1000110100; // [0.55078125]
	storage[620] =  10'b0111001100; // [0.44921875]
	storage[621] =  10'b0101010100; // [0.33203125]
	storage[622] =  10'b0110111000; // [0.4296875]
	storage[623] =  10'b1001000000; // [0.5625]
	storage[624] =  10'b1001110000; // [0.609375]
	storage[625] =  10'b1010000000; // [0.625]
	storage[626] =  10'b1010000000; // [0.625]
	storage[627] =  10'b1001111000; // [0.6171875]
	storage[628] =  10'b1000100000; // [0.53125]
	storage[629] =  10'b0101100100; // [0.34765625]
	storage[630] =  10'b0011101000; // [0.2265625]
	storage[631] =  10'b0011101000; // [0.2265625]
	storage[632] =  10'b0101010100; // [0.33203125]
	storage[633] =  10'b1000100000; // [0.53125]
	storage[634] =  10'b1001110000; // [0.609375]
	storage[635] =  10'b1010000000; // [0.625]
	storage[636] =  10'b1010000000; // [0.625]
	storage[637] =  10'b1001111100; // [0.62109375]
	storage[638] =  10'b1001110100; // [0.61328125]
	storage[639] =  10'b1001110000; // [0.609375]
	storage[640] =  10'b1001101000; // [0.6015625]
	storage[641] =  10'b1001011100; // [0.58984375]
	storage[642] =  10'b1001011000; // [0.5859375]
	storage[643] =  10'b1001010100; // [0.58203125]
	storage[644] =  10'b1001010000; // [0.578125]
	storage[645] =  10'b1001010000; // [0.578125]
	storage[646] =  10'b1001011000; // [0.5859375]
	storage[647] =  10'b1001001100; // [0.57421875]
	storage[648] =  10'b1000010000; // [0.515625]
	storage[649] =  10'b0101110000; // [0.359375]
	storage[650] =  10'b0100110000; // [0.296875]
	storage[651] =  10'b0110000000; // [0.375]
	storage[652] =  10'b0111111000; // [0.4921875]
	storage[653] =  10'b1001000100; // [0.56640625]
	storage[654] =  10'b1001001100; // [0.57421875]
	storage[655] =  10'b1000010000; // [0.515625]
	storage[656] =  10'b0101111100; // [0.37109375]
	storage[657] =  10'b0011111000; // [0.2421875]
	storage[658] =  10'b0011100100; // [0.22265625]
	storage[659] =  10'b0100110100; // [0.30078125]
	storage[660] =  10'b0111101000; // [0.4765625]
	storage[661] =  10'b1001100000; // [0.59375]
	storage[662] =  10'b1001111000; // [0.6171875]
	storage[663] =  10'b1001111000; // [0.6171875]
	storage[664] =  10'b1001111000; // [0.6171875]
	storage[665] =  10'b1001110100; // [0.61328125]
	storage[666] =  10'b1001110000; // [0.609375]
	storage[667] =  10'b1001101000; // [0.6015625]
	storage[668] =  10'b1001100000; // [0.59375]
	storage[669] =  10'b1001011100; // [0.58984375]
	storage[670] =  10'b1001011000; // [0.5859375]
	storage[671] =  10'b1001001100; // [0.57421875]
	storage[672] =  10'b1001001100; // [0.57421875]
	storage[673] =  10'b1001010100; // [0.58203125]
	storage[674] =  10'b1001011000; // [0.5859375]
	storage[675] =  10'b1001011000; // [0.5859375]
	storage[676] =  10'b1000111100; // [0.55859375]
	storage[677] =  10'b0111011100; // [0.46484375]
	storage[678] =  10'b0100101100; // [0.29296875]
	storage[679] =  10'b0011110100; // [0.23828125]
	storage[680] =  10'b0100100000; // [0.28125]
	storage[681] =  10'b0101010000; // [0.328125]
	storage[682] =  10'b0101010100; // [0.33203125]
	storage[683] =  10'b0100100000; // [0.28125]
	storage[684] =  10'b0011110000; // [0.234375]
	storage[685] =  10'b0011110100; // [0.23828125]
	storage[686] =  10'b0101001000; // [0.3203125]
	storage[687] =  10'b0111101000; // [0.4765625]
	storage[688] =  10'b1001011100; // [0.58984375]
	storage[689] =  10'b1001110100; // [0.61328125]
	storage[690] =  10'b1001111000; // [0.6171875]
	storage[691] =  10'b1001110000; // [0.609375]
	storage[692] =  10'b1001110100; // [0.61328125]
	storage[693] =  10'b1001110000; // [0.609375]
	storage[694] =  10'b1001101000; // [0.6015625]
	storage[695] =  10'b1001100100; // [0.59765625]
	storage[696] =  10'b1001011100; // [0.58984375]
	storage[697] =  10'b1001011000; // [0.5859375]
	storage[698] =  10'b1001010100; // [0.58203125]
	storage[699] =  10'b1001001000; // [0.5703125]
	storage[700] =  10'b1001000100; // [0.56640625]
	storage[701] =  10'b1001001100; // [0.57421875]
	storage[702] =  10'b1001010100; // [0.58203125]
	storage[703] =  10'b1001011000; // [0.5859375]
	storage[704] =  10'b1001010000; // [0.578125]
	storage[705] =  10'b1000110000; // [0.546875]
	storage[706] =  10'b0111000000; // [0.4375]
	storage[707] =  10'b0100100000; // [0.28125]
	storage[708] =  10'b0011011100; // [0.21484375]
	storage[709] =  10'b0011010100; // [0.20703125]
	storage[710] =  10'b0011011000; // [0.2109375]
	storage[711] =  10'b0011110000; // [0.234375]
	storage[712] =  10'b0100100000; // [0.28125]
	storage[713] =  10'b0110010000; // [0.390625]
	storage[714] =  10'b1000010000; // [0.515625]
	storage[715] =  10'b1001100000; // [0.59375]
	storage[716] =  10'b1001110000; // [0.609375]
	storage[717] =  10'b1001110000; // [0.609375]
	storage[718] =  10'b1001110000; // [0.609375]
	storage[719] =  10'b1001101100; // [0.60546875]
	storage[720] =  10'b1001101100; // [0.60546875]
	storage[721] =  10'b1001101000; // [0.6015625]
	storage[722] =  10'b1001100100; // [0.59765625]
	storage[723] =  10'b1001011100; // [0.58984375]
	storage[724] =  10'b1001010100; // [0.58203125]
	storage[725] =  10'b1001010000; // [0.578125]
	storage[726] =  10'b1001001100; // [0.57421875]
	storage[727] =  10'b1001000000; // [0.5625]
	storage[728] =  10'b1000111100; // [0.55859375]
	storage[729] =  10'b1001001000; // [0.5703125]
	storage[730] =  10'b1001001100; // [0.57421875]
	storage[731] =  10'b1001010000; // [0.578125]
	storage[732] =  10'b1001010100; // [0.58203125]
	storage[733] =  10'b1001010000; // [0.578125]
	storage[734] =  10'b1000110000; // [0.546875]
	storage[735] =  10'b0111011100; // [0.46484375]
	storage[736] =  10'b0101101000; // [0.3515625]
	storage[737] =  10'b0100101000; // [0.2890625]
	storage[738] =  10'b0100111100; // [0.30859375]
	storage[739] =  10'b0110010100; // [0.39453125]
	storage[740] =  10'b1000000100; // [0.50390625]
	storage[741] =  10'b1001001100; // [0.57421875]
	storage[742] =  10'b1001101100; // [0.60546875]
	storage[743] =  10'b1001110000; // [0.609375]
	storage[744] =  10'b1001101100; // [0.60546875]
	storage[745] =  10'b1001101100; // [0.60546875]
	storage[746] =  10'b1001101000; // [0.6015625]
	storage[747] =  10'b1001101000; // [0.6015625]
	storage[748] =  10'b1001101000; // [0.6015625]
	storage[749] =  10'b1001100100; // [0.59765625]
	storage[750] =  10'b1001011100; // [0.58984375]
	storage[751] =  10'b1001010100; // [0.58203125]
	storage[752] =  10'b1001010000; // [0.578125]
	storage[753] =  10'b1001001100; // [0.57421875]
	storage[754] =  10'b1001000100; // [0.56640625]
	storage[755] =  10'b1000111000; // [0.5546875]
	storage[756] =  10'b1000110100; // [0.55078125]
	storage[757] =  10'b1000111100; // [0.55859375]
	storage[758] =  10'b1001001000; // [0.5703125]
	storage[759] =  10'b1001010000; // [0.578125]
	storage[760] =  10'b1001011000; // [0.5859375]
	storage[761] =  10'b1001011100; // [0.58984375]
	storage[762] =  10'b1001100000; // [0.59375]
	storage[763] =  10'b1001010000; // [0.578125]
	storage[764] =  10'b1000110000; // [0.546875]
	storage[765] =  10'b1000011000; // [0.5234375]
	storage[766] =  10'b1000101000; // [0.5390625]
	storage[767] =  10'b1001010000; // [0.578125]
	storage[768] =  10'b1001101000; // [0.6015625]
	storage[769] =  10'b1001110000; // [0.609375]
	storage[770] =  10'b1001110000; // [0.609375]
	storage[771] =  10'b1001101100; // [0.60546875]
	storage[772] =  10'b1001101000; // [0.6015625]
	storage[773] =  10'b1001100100; // [0.59765625]
	storage[774] =  10'b1001100100; // [0.59765625]
	storage[775] =  10'b1001100100; // [0.59765625]
	storage[776] =  10'b1001100000; // [0.59375]
	storage[777] =  10'b1001011100; // [0.58984375]
	storage[778] =  10'b1001010100; // [0.58203125]
	storage[779] =  10'b1001010000; // [0.578125]
	storage[780] =  10'b1001001100; // [0.57421875]
	storage[781] =  10'b1001001000; // [0.5703125]
	storage[782] =  10'b1001000000; // [0.5625]
	storage[783] =  10'b1000110100; // [0.55078125]
end
endmodule