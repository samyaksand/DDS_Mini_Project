`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   15:22:12 12/16/2021
// Design Name:   full_subtractor
// Module Name:   /home/ise/Desktop/DDS_Project/fs1.v
// Project Name:  DDS_Project
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: full_subtractor
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module fs1;

	// Inputs
	reg A;
	reg B;
	reg Bin;
	
	reg _A;
	reg _B;
	reg _Bin;
	
	// Outputs
	wire D;
	wire Bout;
	
	reg _D;
	reg _Bout;
	
	reg flag;

	// Instantiate the Unit Under Test (UUT)
	full_subtractor uut (
		.A(A), 
		.B(B), 
		.Bin(Bin), 
		.D(D), 
		.Bout(Bout)
	);

	initial begin
	
	//Defining each expected output using the ideal case inputs
	assign _D=_A^_B^_Bin;
	assign _Bout=((~_A)&_B)|((~_A)&_Bin)|(_B&_Bin);
	
	//Implementing the SA0 faults by forcing a particular variable to 0
	//To run simulations, comment out the variables whhich should NOT be sa0
	force A = 0;
	force B = 0;
	force Bin = 0;
	
		// Initialize Inputs
		flag = 0;
		
		A = 0; B = 0; Bin = 0; _A = 0; _B = 0; _Bin = 0;
#50	A = 0; B = 0; Bin = 1; _A = 0; _B = 0; _Bin = 1;
#50	A = 0; B = 1; Bin = 0; _A = 0; _B = 1; _Bin = 0;
#50	A = 0; B = 1; Bin = 1; _A = 0; _B = 1; _Bin = 1;

#50	A = 1; B = 1; Bin = 1; _A = 1; _B = 1; _Bin = 1;
#10	if (D==0 && Bout==1) begin 
			$display("Fault error: A is stuck-at 0");
			assign flag = 1;
		end
		if (D==1 && Bout==0) begin
			$display("Fault error: Both B and Bin is stuck-at 0");
			assign flag = 1;
		end
		
#50	A = 1; B = 1; Bin = 0; _A = 1; _B = 1; _Bin = 0;
#10	if (flag != 1) begin 
			if (D==1 && Bout==0) begin
				$display("Fault error: B is stuck-at 0");
				assign flag = 1;
			end
			if (D==1 && Bout==1) begin
				$display("Fault error: Both A and Bin is stuck-at 0");
				assign flag = 1;
			end
		end
		
#50	A = 1; B = 0; Bin = 1; _A = 1; _B = 0; _Bin = 1;
#10	if (flag != 1) begin 
			if (D==1 && Bout==0) begin
				$display("Fault error: Bin is stuck-at 0");
				assign flag = 1;
			end
			if (D==1 && Bout==1) begin
				$display("Fault error: Both A and B is stuck-at 0");
				assign flag = 1;
			end
		end
		
#50	A = 1; B = 0; Bin = 0; _A = 1; _B = 0; _Bin = 0;
#10	if (flag != 1) begin
			if (D==0 && Bout==0) begin
				$display("Fault error: A, B and Bin is stuck-at 0");
				assign flag = 1;
			end
		end
		
#1		if (flag == 0) begin
			$display("No Stuck-at 0 faults in the inputs");
		end
		
		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here
	
	end

endmodule

