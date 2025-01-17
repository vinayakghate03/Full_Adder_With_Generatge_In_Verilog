`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: -
// Engineer: Vinayak Ghate
// 
// Create Date: 17.01.2025 19:14:26
// Design Name: 
// Module Name: FULL_ADDER
// Project Name: Full adders with generate using instatiation modules
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


module FULL_ADDER(   // this is my sub module
             input X,Y,Z,
             output SUM, CARRY
    );
    

//    we are using continus assigment statement with for of implicity assigment statement for the
   assign SUM = X ^ Y ^ Z;
   assign CARRY = (X & Y)|(Y & Z)|(X & Z);

endmodule

//we are create the generate module to genertae the N-number of the instatiation for create the N-number of the adders 

module generator #(parameter N_FA = 0) // assign defult value
     (
       input a,b,c,
       output sum,carry);
       
//       we are using the generate veriable to generate the N number of the FULL Adders this is pass using parameters
  
      genvar  i ;// create the  veriable
       
       generate // keyword to generate N
        // this is for loop generator
          for( i = 0 ;i < N_FA; i = i + 1) begin
           
//         we are create instance for the N n umber of FULL ADDER generated which is know as the inner instacne 

             FULL_ADDER My_Ganerate_Instance(   // this is the Sub module instantiation
             
                    .X(a), .Y(b), .Z(c), .SUM(sum), .CARRY(carry)); // we connect the pins by port name oerde 
           end
       endgenerate
              
endmodule             
               
//we are create the top module as test bench for test the adders 

module top_test;
      reg A,B,C;
      wire SUM,CARRY;
      integer i ; // for value assign
//   we are create the top instance of the generate sub modules
    
    generator #(.N_FA(5))   // this is assign the number of the generate instacne inside of the top module
             Top_Instance(   // top moudle inst created with name port connections
               .a(A), .b(B), .c(C), .sum(SUM), .carry(CARRY));       
             
             
//          there using the inital block to assign the vlaues 

    initial begin
      
//      we are using for loop we assign the values in binary form
       for( i= 0 ; i <8; i = i + 1) begin
         {A,B,C} = i;   // this is the concatinations of the veriable to assign the vlaues 
           #10;   // time units
           display_add();
         end
         $finish;
 end                 
    
    initial 
     $display("\t FULL ADDER OUTPUT");
     
 
 // create the task for the display the value on the consul
   task display_add();
       begin
       $display("A = %d, B = %d, C = %d, SUM = %d, CARRY = %d",A,B,C,SUM,CARRY);
      end
    endtask
endmodule
