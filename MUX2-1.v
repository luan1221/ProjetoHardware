module MUX2-1(I0, I1, S, X);

	input wire I0, I1;
	input wire S;
	output wire X;
	wire S_inv, a1, b1;
	
	not u1(S_inv, S);
	and u2(a1, S_inv, I0);
	and u3(b1, S, I1);
	or u4(X, a1, b1);
	
endmodule	