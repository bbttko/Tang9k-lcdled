module top (
        input Reset_Button,
        input CLK_27M,
        input User_Button,    // unused

        output LCD_CLK,
        output			LCD_HYNC,
        output			LCD_SYNC,
        output			LCD_DEN,
        output	[4:0]	LCD_R,
        output	[5:0]	LCD_G,
        output	[4:0]	LCD_B,

        output reg [5:0]   LED
    );

// not stable
//    reg CLK_SYS;
//    reg [1:0] clkcount;
//    always @(posedge CLK_27M or negedge Reset_Button) begin
//        if (!Reset_Button) begin
//            clkcount <= 2'b0;
//            CLK_SYS <= 1'b0;
//        end else begin
//            if (clkcount == 2'b11) begin
//                clkcount = 2'b0;
//                CLK_SYS <= !CLK_SYS;
//            end else 
//                clkcount = clkcount + 1'b1;
//        end
//    end
//    wire CLK_PIX = !CLK_SYS;

	wire		CLK_SYS;
	wire		CLK_PIX;
    Gowin_rPLL chip_pll (
        .clkin(CLK_27M), //input clk @27MHz
        .clkout(CLK_SYS), //system clock CLK_SYS @9 MHz
        .clkoutd(CLK_PIX) //pixel clock, inverted from CLK_SYS
    );


	VGAMod2	D1 (
		.CLK		(	CLK_SYS     ),
		.nRST		(	Reset_Button),

		.PixelClk	(	CLK_PIX		),
		.LCD_DE		(	LCD_DEN	 	),
		.LCD_HSYNC	(	LCD_HYNC 	),
    	.LCD_VSYNC	(	LCD_SYNC 	),

		.LCD_B		(	LCD_B		),
		.LCD_G		(	LCD_G		),
		.LCD_R		(	LCD_R		)
	);

	assign		LCD_CLK		=	CLK_PIX;



//LED drive
    reg     [31:0]  counter;


    always @(posedge CLK_27M or negedge Reset_Button) begin
    if (!Reset_Button)
        counter <= 0;
    else if (counter < 27_000_000 / 2)       // 0.5s delay
        counter <= counter + 1;
    else
        counter <= 24'd0;
    end

    always @(posedge CLK_27M or negedge Reset_Button) begin
    if (!Reset_Button)
        LED <= 6'b111110;       
    else if (counter == 27_000_000 / 2)       // 0.5s delay = ??
        LED[5:0] <= {LED[4:0],LED[5]};        
    else
        LED <= LED;
    end

endmodule
