`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:16:48 12/16/2021 
// Design Name: 
// Module Name:    full_subtractor 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////

//Program to build the full-subtractor model
module full_subtractor(
	 input A,B,Bin,
    output D,Bout
    );
	 
//Defining each output variable with it's corresponding full-subtractor logic
assign D=A^(B^Bin);
assign Bout=((~A)&B)|((~A)&Bin)|(Bin&B);

endmodule
