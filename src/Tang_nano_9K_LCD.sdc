//Copyright (C)2014-2021 GOWIN Semiconductor Corporation.
//All rights reserved.
//File Title: Timing Constraints file
//GOWIN Version: 1.9.6.02 Beta
//Created Time: 2021-11-04 19:03:59
create_clock -name CLK_27M -period 37.037 -waveform {0 18.518} [get_ports {CLK_27M}] -add
create_clock -name LCD_CLK -period 111.11 -waveform {0 55.555} [get_ports {LCD_CLK}] -add
