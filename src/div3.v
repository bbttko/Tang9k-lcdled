module div3 (
		input clk_i,
		output clk_o, clk_o_inv
	);
	
    reg CLK_SYS = 0 ;
    reg [1:0] clkcount = 0;
    always @(posedge clk_i) begin
		if (clkcount == 2) begin
			clkcount = 0;
			CLK_SYS <= !CLK_SYS;
		end else 
			clkcount = clkcount + 1'b1;
    end
	assign clk_o = CLK_SYS;
    assign clk_o_inv = !CLK_SYS;
	
endmodule

