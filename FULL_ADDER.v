`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: -
// Engineer: Vinayak Ghate
// 
// Create Date: 17.01.2025 19:14:26
// Design Name: 
// Module Name: FULL_ADDER
// Project Name: Full adders with generate using instantiation modules
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module FULL_ADDER(   // this is my submodule
             input X, Y, Z,
             output SUM, CARRY
    );
    

//We are using continuous assignment statement with for of implicity assignment statement for the
   assign SUM = X ^ Y ^ Z;
   assign CARRY = (X & Y)|(Y & Z)|(X & Z);

endmodule

//we are creating the generate module to generate the N-number of the instantiation for create the N-number of the adders 

module generator #(parameter N_FA = 0) // assign defult value
     (
       input a,b,c,
       output sum, carry);
       
//We are using the generate variable to generate the N number of the FULL Adders this is passed using parameters
  
      genvar  i ;// create the  variable
       
       generate // keyword to generate N
        //This is for-loop generator
          for( i = 0 ;i < N_FA; i = i + 1) begin
           
//         we are creating instance for the N number of FULL ADDER generated which is known as the inner instance 

             FULL_ADDER My_Ganerate_Instance(   // this is the Sub module instantiation
             
               .X(a), .Y(b), .Z(c), .SUM(sum), .CARRY(carry)); // we connect the pins by port name order 
           end
       endgenerate
              
endmodule             
               
//we are creating the top module as a test bench for testing the adders 

module top_test;
      reg A, B, C;
      wire SUM, CARRY;
      integer i ; // for value assign
//We are creating the top instance of the generated submodules
    
  generator #(.N_FA(5))   //This is assigned the number of the generated instance inside of the top module
  Top_Instance(   // top module inst created with name port connections
               .a(A), .b(B), .c(C), .sum(SUM), .carry(CARRY));       
             
             
//          there using the initial block to assign the values 

    initial begin
      
//We are using for loop we assign the values in binary form
       for( i= 0 ; i <8; i = i + 1) begin
         {A, B, C} = i;   //This is the concatenation of the variable to assign the values 
           #10;   // time units
           display_add();
         end
         $finish;
 end                 
    
    initial 
     $display("\t FULL ADDER OUTPUT");
     
 
 //Create the task for the display of the value on the consul
   task display_add();
       begin
         $display("A = %d, B = %d, C = %d, SUM = %d, CARRY = %d",A, B, C, SUM, CARRY);
      end
    endtask
endmodule
