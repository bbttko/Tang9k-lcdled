// for AT050TN33-Innolux.pdf
// pixel clock -ve edge @9MHz 
module VGAMod2 (
        input                   CLK, nRST, PixelClk,
        output                  LCD_DE, LCD_HSYNC, LCD_VSYNC,
        output          [4:0]   LCD_B,
        output          [5:0]   LCD_G,
        output          [4:0]   LCD_R
    );

    reg         [15:0]  HCount;
    reg         [15:0]  VCount;

    localparam  HBlanking = 16'd45;
    localparam  HActive   = 16'd480;
    localparam  HTotal    = HBlanking + HActive;

    localparam  VBlanking = 16'd16;
    localparam  VActive   = 16'd272;
    localparam  VTotal    = VBlanking + VActive;
	
 
    localparam      Width_bar   =   45;
    reg         [15:0]  BarCount;
	reg			[9:0]  Data_R;
	reg			[9:0]  Data_G;
	reg			[9:0]  Data_B;
    

    always @( posedge PixelClk or negedge nRST ) begin
        if (!nRST) begin
            HCount <=  16'b0;    
            VCount <=  16'b0;
			Data_R <= 9'b0;
			Data_G <= 9'b0;
			Data_B <= 9'b0;
            BarCount <=9'd5;
            end 
        else if( HCount == HTotal ) begin        // pixelcount = horizontal pixels
            HCount <= 16'b0;
            VCount <= VCount + 1'b1;
            end
        else if( VCount == VTotal ) begin
            VCount <= 16'b0;
            HCount <= 16'b0;
            end
        else
            HCount <= HCount + 1'b1;
    end

    assign  LCD_HSYNC = ( HCount <= HBlanking ) ? 1'b0 : 1'b1;
	assign  LCD_VSYNC = ( VCount <= VBlanking ) ? 1'b0 : 1'b1;
    assign  LCD_DE = ( LCD_HSYNC & LCD_VSYNC ) ? 1'b1 : 1'b0;


    assign  LCD_R = (HCount < 45 * 5) ? 5'b10000 :  5'b00000;

    assign  LCD_G = (HCount < 45 * 6) ? 6'b100000 : 6'b000000;

    assign  LCD_B = (HCount < 45 * 7) ? 5'b11000 :  5'b00000;

/*
    assign  LCD_R   =   (PixelCount<Width_bar*BarCount)? 5'b00000 :  
                        (PixelCount<(Width_bar*(BarCount+1)) ? 5'b00001 :    
                        (PixelCount<(Width_bar*(BarCount+2)) ? 5'b00010 :    
                        (PixelCount<(Width_bar*(BarCount+3)) ? 5'b00100 :    
                        (PixelCount<(Width_bar*(BarCount+4)) ? 5'b01000 :    
                        (PixelCount<(Width_bar*(BarCount+5)) ? 5'b10000 :
                        5'b00000 )))));

    assign  LCD_G   =   (PixelCount<(Width_bar*(BarCount+5)))? 6'b000000 : 
                        (PixelCount<(Width_bar*(BarCount+6)) ? 6'b000001 :    
                        (PixelCount<(Width_bar*(BarCount+7)) ? 6'b000010 :    
                        (PixelCount<(Width_bar*(BarCount+8)) ? 6'b000100 :    
                        (PixelCount<(Width_bar*(BarCount+9)) ? 6'b001000 :    
                        (PixelCount<(Width_bar*(BarCount+10)) ? 6'b010000 :  
                        (PixelCount<(Width_bar*(BarCount+11)) ? 6'b100000 : 
                        6'b000000 ))))));

    assign  LCD_B   =   (PixelCount<(Width_bar*(BarCount+11)))? 5'b00000 : 
                        (PixelCount<(Width_bar*(BarCount+12)) ? 5'b00001 :    
                        (PixelCount<(Width_bar*(BarCount+13)) ? 5'b00010 :    
                        (PixelCount<(Width_bar*(BarCount+14)) ? 5'b00100 :    
                        (PixelCount<(Width_bar*(BarCount+15)) ? 5'b01000 :    
                        (PixelCount<(Width_bar*(BarCount+16)) ? 5'b10000 :  
                        5'b00000 )))));
*/

endmodule
