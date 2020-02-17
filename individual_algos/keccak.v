/*
 * Copyright (c) 2018 Sprocket
 *
 * This is free software: you can redistribute it and/or modify
 * it under the terms of the GNU Affero General Public License with
 * additional permissions to the one published by the Free Software
 * Foundation, either version 3 of the License, or (at your option)
 * any later version. For more information see LICENSE.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU Affero General Public License for more details.
 *
 * You should have received a copy of the GNU Affero General Public License
 * along with this program. If not, see <http://www.gnu.org/licenses/>.
 */

module keccak512 (
	input clk,
	input [511:0] data,
	output [511:0] hash
);

	reg [511:0] h;
	
	reg [1599:0] msg;
	wire [1599:0] data_le;
	wire [1599:0] o0,o1,o2,o3,o4,o5,o6,o7,o8,o9,o10,o11,o12,o13,o14,o15,o16,o17,o18,o19,o20,o21,o22,o23,o24;
	reg [1599:0] i0,i1,i2,i3,i4,i5,i6,i7,i8,i9,i10,i11,i12,i13,i14,i15,i16,i17,i18,i19,i20,i21,i22,i23;

	genvar i,j;
	generate
		for( i=0; i<25; i=i+1) begin: DATA_REVERSE
			for( j=0; j<8; j=j+1) begin: DATA_REVERSE2
				assign data_le[1536-(i*64)+56-(j*8) +: 8] = msg[1536-(i*64)+56-((7-j)*8) +: 8];
			end
		end
	endgenerate

	generate
		for( i=0; i<8; i=i+1) begin: DATA_REVERSE3
			for( j=0; j<8; j=j+1) begin: DATA_REVERSE4
				assign hash[448-(i*64)+56-(j*8) +: 8] = h[448-(i*64)+56-((7-j)*8) +: 8];
			end
		end
	endgenerate
 	
	keccak_round r0  (clk, i0,  o0);
	keccak_round r1  (clk, i1,  o1);
	keccak_round r2  (clk, i2,  o2);
	keccak_round r3  (clk, i3,  o3);
	keccak_round r4  (clk, i4,  o4);
	keccak_round r5  (clk, i5,  o5);
	keccak_round r6  (clk, i6,  o6);
	keccak_round r7  (clk, i7,  o7);
	keccak_round r8  (clk, i8,  o8);
	keccak_round r9  (clk, i9,  o9);
	keccak_round r10 (clk, i10, o10);
	keccak_round r11 (clk, i11, o11);
	keccak_round r12 (clk, i12, o12);
	keccak_round r13 (clk, i13, o13);
	keccak_round r14 (clk, i14, o14);
	keccak_round r15 (clk, i15, o15);
	keccak_round r16 (clk, i16, o16);
	keccak_round r17 (clk, i17, o17);
	keccak_round r18 (clk, i18, o18);
	keccak_round r19 (clk, i19, o19);
	keccak_round r20 (clk, i20, o20);
	keccak_round r21 (clk, i21, o21);
	keccak_round r22 (clk, i22, o22);
	keccak_round r23 (clk, i23, o23);

	always @ (posedge clk) begin
	
		msg <= { data, 576'h010000000000008000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000, 512'd0 };

		i0 <= data_le;
		i1[1599:1536] <= o0[1599:1536] ^ 64'h0000000000000001;
		i1[1535:   0] <= o0[1535:   0];
		i2[1599:1536] <= o1[1599:1536] ^ 64'h0000000000008082;
		i2[1535:   0] <= o1[1535:   0];
		i3[1599:1536] <= o2[1599:1536] ^ 64'h800000000000808a;
		i3[1535:   0] <= o2[1535:   0];
		i4[1599:1536] <= o3[1599:1536] ^ 64'h8000000080008000;
		i4[1535:   0] <= o3[1535:   0];
		i5[1599:1536] <= o4[1599:1536] ^ 64'h000000000000808b;
		i5[1535:   0] <= o4[1535:   0];
		i6[1599:1536] <= o5[1599:1536] ^ 64'h0000000080000001;
		i6[1535:   0] <= o5[1535:   0];
		i7[1599:1536] <= o6[1599:1536] ^ 64'h8000000080008081;
		i7[1535:   0] <= o6[1535:   0];
		i8[1599:1536] <= o7[1599:1536] ^ 64'h8000000000008009;
		i8[1535:   0] <= o7[1535:   0];
		i9[1599:1536] <= o8[1599:1536] ^ 64'h000000000000008a;
		i9[1535:   0] <= o8[1535:   0];
		i10[1599:1536] <= o9[1599:1536] ^ 64'h0000000000000088;
		i10[1535:   0] <= o9[1535:   0];
		i11[1599:1536] <= o10[1599:1536] ^ 64'h0000000080008009;
		i11[1535:   0] <= o10[1535:   0];
		i12[1599:1536] <= o11[1599:1536] ^ 64'h000000008000000a;
		i12[1535:   0] <= o11[1535:   0];
		i13[1599:1536] <= o12[1599:1536] ^ 64'h000000008000808b;
		i13[1535:   0] <= o12[1535:   0];
		i14[1599:1536] <= o13[1599:1536] ^ 64'h800000000000008b;
		i14[1535:   0] <= o13[1535:   0];
		i15[1599:1536] <= o14[1599:1536] ^ 64'h8000000000008089;
		i15[1535:   0] <= o14[1535:   0];
		i16[1599:1536] <= o15[1599:1536] ^ 64'h8000000000008003;
		i16[1535:   0] <= o15[1535:   0];
		i17[1599:1536] <= o16[1599:1536] ^ 64'h8000000000008002;
		i17[1535:   0] <= o16[1535:   0];
		i18[1599:1536] <= o17[1599:1536] ^ 64'h8000000000000080;
		i18[1535:   0] <= o17[1535:   0];
		i19[1599:1536] <= o18[1599:1536] ^ 64'h000000000000800a;
		i19[1535:   0] <= o18[1535:   0];
		i20[1599:1536] <= o19[1599:1536] ^ 64'h800000008000000a;
		i20[1535:   0] <= o19[1535:   0];
		i21[1599:1536] <= o20[1599:1536] ^ 64'h8000000080008081;
		i21[1535:   0] <= o20[1535:   0];
		i22[1599:1536] <= o21[1599:1536] ^ 64'h8000000000008080;
		i22[1535:   0] <= o21[1535:   0];
		i23[1599:1536] <= o22[1599:1536] ^ 64'h0000000080000001;
		i23[1535:   0] <= o22[1535:   0];

		h[511:448] <= o23[1599:1536] ^ 64'h8000000080008008;
		h[447:  0] <= o23[1535:1088];

	end
	
endmodule

module keccak_round (
	input clk,
	input [1599:0] in,
	output [1599:0] out
);

	reg [1599:0] i;
	reg [1599:0] s0;
	reg [1599:0] s1;
	reg [1599:0] s2;
	reg [1599:0] s3;
	reg [1599:0] s4;
	
	assign out = s4;

	reg [63:0] b00,b01,b02,b03,b04;
	reg [63:0] t00,t01,t02,t03,t04;
	
	reg [63:0] r0,r1,r2,r3,r4,r5,r6,r7,r8,r9,r10,r11,r12,r13,r14,r15,r16,r17,r18,r19,r20,r21,r22,r23,r24;

	always @ (posedge clk) begin

		i <= in;

	end

	always @ (*) begin

		b00 <= i[(1536-( 0*64)) +: 64] ^ i[(1536-( 5*64)) +: 64] ^ i[(1536-(10*64)) +: 64] ^ i[(1536-(15*64)) +: 64] ^ i[(1536-(20*64)) +: 64];
		b01 <= i[(1536-( 1*64)) +: 64] ^ i[(1536-( 6*64)) +: 64] ^ i[(1536-(11*64)) +: 64] ^ i[(1536-(16*64)) +: 64] ^ i[(1536-(21*64)) +: 64];
		b02 <= i[(1536-( 2*64)) +: 64] ^ i[(1536-( 7*64)) +: 64] ^ i[(1536-(12*64)) +: 64] ^ i[(1536-(17*64)) +: 64] ^ i[(1536-(22*64)) +: 64];
		b03 <= i[(1536-( 3*64)) +: 64] ^ i[(1536-( 8*64)) +: 64] ^ i[(1536-(13*64)) +: 64] ^ i[(1536-(18*64)) +: 64] ^ i[(1536-(23*64)) +: 64];
		b04 <= i[(1536-( 4*64)) +: 64] ^ i[(1536-( 9*64)) +: 64] ^ i[(1536-(14*64)) +: 64] ^ i[(1536-(19*64)) +: 64] ^ i[(1536-(24*64)) +: 64];

	end
	
	always @ (posedge clk) begin

		t00 <= b04 ^ { b01[62:0], b01[63] };
		t01 <= b00 ^ { b02[62:0], b02[63] };
		t02 <= b01 ^ { b03[62:0], b03[63] };
		t03 <= b02 ^ { b04[62:0], b04[63] };
		t04 <= b03 ^ { b00[62:0], b00[63] };
		
		s0 <= i;

	end
	
	always @ (*) begin

		s1[(1536-( 0*64)) +: 64] <= s0[(1536-( 0*64)) +: 64] ^ t00;
		s1[(1536-( 5*64)) +: 64] <= s0[(1536-( 5*64)) +: 64] ^ t00;
		s1[(1536-(10*64)) +: 64] <= s0[(1536-(10*64)) +: 64] ^ t00;
		s1[(1536-(15*64)) +: 64] <= s0[(1536-(15*64)) +: 64] ^ t00;
		s1[(1536-(20*64)) +: 64] <= s0[(1536-(20*64)) +: 64] ^ t00;

		s1[(1536-( 1*64)) +: 64] <= s0[(1536-( 1*64)) +: 64] ^ t01;
		s1[(1536-( 6*64)) +: 64] <= s0[(1536-( 6*64)) +: 64] ^ t01;
		s1[(1536-(11*64)) +: 64] <= s0[(1536-(11*64)) +: 64] ^ t01;
		s1[(1536-(16*64)) +: 64] <= s0[(1536-(16*64)) +: 64] ^ t01;
		s1[(1536-(21*64)) +: 64] <= s0[(1536-(21*64)) +: 64] ^ t01;

		s1[(1536-( 2*64)) +: 64] <= s0[(1536-( 2*64)) +: 64] ^ t02;
		s1[(1536-( 7*64)) +: 64] <= s0[(1536-( 7*64)) +: 64] ^ t02;
		s1[(1536-(12*64)) +: 64] <= s0[(1536-(12*64)) +: 64] ^ t02;
		s1[(1536-(17*64)) +: 64] <= s0[(1536-(17*64)) +: 64] ^ t02;
		s1[(1536-(22*64)) +: 64] <= s0[(1536-(22*64)) +: 64] ^ t02;

		s1[(1536-( 3*64)) +: 64] <= s0[(1536-( 3*64)) +: 64] ^ t03;
		s1[(1536-( 8*64)) +: 64] <= s0[(1536-( 8*64)) +: 64] ^ t03;
		s1[(1536-(13*64)) +: 64] <= s0[(1536-(13*64)) +: 64] ^ t03;
		s1[(1536-(18*64)) +: 64] <= s0[(1536-(18*64)) +: 64] ^ t03;
		s1[(1536-(23*64)) +: 64] <= s0[(1536-(23*64)) +: 64] ^ t03;

		s1[(1536-( 4*64)) +: 64] <= s0[(1536-( 4*64)) +: 64] ^ t04;
		s1[(1536-( 9*64)) +: 64] <= s0[(1536-( 9*64)) +: 64] ^ t04;
		s1[(1536-(14*64)) +: 64] <= s0[(1536-(14*64)) +: 64] ^ t04;
		s1[(1536-(19*64)) +: 64] <= s0[(1536-(19*64)) +: 64] ^ t04;
		s1[(1536-(24*64)) +: 64] <= s0[(1536-(24*64)) +: 64] ^ t04;

	end
	
	always @ (*) begin

		r0  <= s1[(1536-( 1*64)) +: 64];
		r1  <= s1[(1536-(10*64)) +: 64];
		r2  <= s1[(1536-( 7*64)) +: 64];
		r3  <= s1[(1536-(11*64)) +: 64];
		r4  <= s1[(1536-(17*64)) +: 64];
		r5  <= s1[(1536-(18*64)) +: 64];
		r6  <= s1[(1536-( 3*64)) +: 64];
		r7  <= s1[(1536-( 5*64)) +: 64];
		r8  <= s1[(1536-(16*64)) +: 64];
		r9  <= s1[(1536-( 8*64)) +: 64];
		r10 <= s1[(1536-(21*64)) +: 64];
		r11 <= s1[(1536-(24*64)) +: 64];
		r12 <= s1[(1536-( 4*64)) +: 64];
		r13 <= s1[(1536-(15*64)) +: 64];
		r14 <= s1[(1536-(23*64)) +: 64];
		r15 <= s1[(1536-(19*64)) +: 64];
		r16 <= s1[(1536-(13*64)) +: 64];
		r17 <= s1[(1536-(12*64)) +: 64];
		r18 <= s1[(1536-( 2*64)) +: 64];
		r19 <= s1[(1536-(20*64)) +: 64];
		r20 <= s1[(1536-(14*64)) +: 64];
		r21 <= s1[(1536-(22*64)) +: 64];
		r22 <= s1[(1536-( 9*64)) +: 64];
		r23 <= s1[(1536-( 6*64)) +: 64];
		r24 <= s1[(1536-( 0*64)) +: 64];

	end
	
	always @ (*) begin

		s2[(1536-(10*64)) +: 64] <= { r0[62:0], r0[63:63] };
		s2[(1536-( 7*64)) +: 64] <= { r1[60:0], r1[63:61] };
		s2[(1536-(11*64)) +: 64] <= { r2[57:0], r2[63:58] };
		s2[(1536-(17*64)) +: 64] <= { r3[53:0], r3[63:54] };
		s2[(1536-(18*64)) +: 64] <= { r4[48:0], r4[63:49] };
		s2[(1536-( 3*64)) +: 64] <= { r5[42:0], r5[63:43] };
		s2[(1536-( 5*64)) +: 64] <= { r6[35:0], r6[63:36] };
		s2[(1536-(16*64)) +: 64] <= { r7[27:0], r7[63:28] };
		s2[(1536-( 8*64)) +: 64] <= { r8[18:0], r8[63:19] };
		s2[(1536-(21*64)) +: 64] <= { r9[ 8:0], r9[63:9] };
		s2[(1536-(24*64)) +: 64] <= { r10[61:0],r10[63:62] };
		s2[(1536-( 4*64)) +: 64] <= { r11[49:0],r11[63:50] };
		s2[(1536-(15*64)) +: 64] <= { r12[36:0],r12[63:37] };
		s2[(1536-(23*64)) +: 64] <= { r13[22:0],r13[63:23] };
		s2[(1536-(19*64)) +: 64] <= { r14[ 7:0],r14[63:8] };
		s2[(1536-(13*64)) +: 64] <= { r15[55:0],r15[63:56] };
		s2[(1536-(12*64)) +: 64] <= { r16[38:0],r16[63:39] };
		s2[(1536-( 2*64)) +: 64] <= { r17[20:0],r17[63:21] };
		s2[(1536-(20*64)) +: 64] <= { r18[ 1:0],r18[63:2] };
		s2[(1536-(14*64)) +: 64] <= { r19[45:0],r19[63:46] };
		s2[(1536-(22*64)) +: 64] <= { r20[24:0],r20[63:25] };
		s2[(1536-( 9*64)) +: 64] <= { r21[ 2:0],r21[63:3] };
		s2[(1536-( 6*64)) +: 64] <= { r22[43:0],r22[63:44] };
		s2[(1536-( 1*64)) +: 64] <= { r23[19:0],r23[63:20] };
		s2[(1536-( 0*64)) +: 64] <= r24;

	end
	
	always @ (*) begin

		s3[(1536-( 0*64)) +: 64] <= s2[(1536-( 0*64)) +: 64] ^ (~s2[(1536-( 1*64)) +: 64]) & s2[(1536-( 2*64)) +: 64];
		s3[(1536-( 1*64)) +: 64] <= s2[(1536-( 1*64)) +: 64] ^ (~s2[(1536-( 2*64)) +: 64]) & s2[(1536-( 3*64)) +: 64];
		s3[(1536-( 2*64)) +: 64] <= s2[(1536-( 2*64)) +: 64] ^ (~s2[(1536-( 3*64)) +: 64]) & s2[(1536-( 4*64)) +: 64];
		s3[(1536-( 3*64)) +: 64] <= s2[(1536-( 3*64)) +: 64] ^ (~s2[(1536-( 4*64)) +: 64]) & s2[(1536-( 0*64)) +: 64];
		s3[(1536-( 4*64)) +: 64] <= s2[(1536-( 4*64)) +: 64] ^ (~s2[(1536-( 0*64)) +: 64]) & s2[(1536-( 1*64)) +: 64];

		s3[(1536-( 5*64)) +: 64] <= s2[(1536-( 5*64)) +: 64] ^ (~s2[(1536-( 6*64)) +: 64]) & s2[(1536-( 7*64)) +: 64];
		s3[(1536-( 6*64)) +: 64] <= s2[(1536-( 6*64)) +: 64] ^ (~s2[(1536-( 7*64)) +: 64]) & s2[(1536-( 8*64)) +: 64];
		s3[(1536-( 7*64)) +: 64] <= s2[(1536-( 7*64)) +: 64] ^ (~s2[(1536-( 8*64)) +: 64]) & s2[(1536-( 9*64)) +: 64];
		s3[(1536-( 8*64)) +: 64] <= s2[(1536-( 8*64)) +: 64] ^ (~s2[(1536-( 9*64)) +: 64]) & s2[(1536-( 5*64)) +: 64];
		s3[(1536-( 9*64)) +: 64] <= s2[(1536-( 9*64)) +: 64] ^ (~s2[(1536-( 5*64)) +: 64]) & s2[(1536-( 6*64)) +: 64];

		s3[(1536-(10*64)) +: 64] <= s2[(1536-(10*64)) +: 64] ^ (~s2[(1536-(11*64)) +: 64]) & s2[(1536-(12*64)) +: 64];
		s3[(1536-(11*64)) +: 64] <= s2[(1536-(11*64)) +: 64] ^ (~s2[(1536-(12*64)) +: 64]) & s2[(1536-(13*64)) +: 64];
		s3[(1536-(12*64)) +: 64] <= s2[(1536-(12*64)) +: 64] ^ (~s2[(1536-(13*64)) +: 64]) & s2[(1536-(14*64)) +: 64];
		s3[(1536-(13*64)) +: 64] <= s2[(1536-(13*64)) +: 64] ^ (~s2[(1536-(14*64)) +: 64]) & s2[(1536-(10*64)) +: 64];
		s3[(1536-(14*64)) +: 64] <= s2[(1536-(14*64)) +: 64] ^ (~s2[(1536-(10*64)) +: 64]) & s2[(1536-(11*64)) +: 64];

		s3[(1536-(15*64)) +: 64] <= s2[(1536-(15*64)) +: 64] ^ (~s2[(1536-(16*64)) +: 64]) & s2[(1536-(17*64)) +: 64];
		s3[(1536-(16*64)) +: 64] <= s2[(1536-(16*64)) +: 64] ^ (~s2[(1536-(17*64)) +: 64]) & s2[(1536-(18*64)) +: 64];
		s3[(1536-(17*64)) +: 64] <= s2[(1536-(17*64)) +: 64] ^ (~s2[(1536-(18*64)) +: 64]) & s2[(1536-(19*64)) +: 64];
		s3[(1536-(18*64)) +: 64] <= s2[(1536-(18*64)) +: 64] ^ (~s2[(1536-(19*64)) +: 64]) & s2[(1536-(15*64)) +: 64];
		s3[(1536-(19*64)) +: 64] <= s2[(1536-(19*64)) +: 64] ^ (~s2[(1536-(15*64)) +: 64]) & s2[(1536-(16*64)) +: 64];

		s3[(1536-(20*64)) +: 64] <= s2[(1536-(20*64)) +: 64] ^ (~s2[(1536-(21*64)) +: 64]) & s2[(1536-(22*64)) +: 64];
		s3[(1536-(21*64)) +: 64] <= s2[(1536-(21*64)) +: 64] ^ (~s2[(1536-(22*64)) +: 64]) & s2[(1536-(23*64)) +: 64];
		s3[(1536-(22*64)) +: 64] <= s2[(1536-(22*64)) +: 64] ^ (~s2[(1536-(23*64)) +: 64]) & s2[(1536-(24*64)) +: 64];
		s3[(1536-(23*64)) +: 64] <= s2[(1536-(23*64)) +: 64] ^ (~s2[(1536-(24*64)) +: 64]) & s2[(1536-(20*64)) +: 64];
		s3[(1536-(24*64)) +: 64] <= s2[(1536-(24*64)) +: 64] ^ (~s2[(1536-(20*64)) +: 64]) & s2[(1536-(21*64)) +: 64];

	end
	
	always @ (posedge clk) begin

		s4 <= s3;

	end

endmodule
