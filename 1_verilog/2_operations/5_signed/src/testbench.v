`timescale 1ns/1ps

module testbench ();
   
   // DECLARE SIGNALS
   reg clk;     
   reg signed [2:0] a;  
   reg        [3:0] b;  
   reg        [4:0] c;
   
   integer clk_count = 0;   
   
   // INITIAL SIGNAL CONFIGURATION:
   initial begin
      clk = 0;      
      a   = 0;
      b   = 0;
      c   = 0;
   end

   // GENERATE CLOCK:
   initial forever #10 clk = ~clk;

   always @(a) begin
      b = a;
      c = b;
   end

   // CREATE STIMULI:
   always @(posedge clk) begin
      a <= a + 1;
   end

   // WRITE OUTPUT TO CONSOLE:
   integer fid;
   initial fid = $fopen("test_result.txt", "w");
   
   always @(posedge clk) begin
      $write("clk:  %d", clk_count);      
      $write("\ta:  %b(%d)", a,a);
      $write("\tb:  %b(%d)", b,b);
      $write("\tc:  %b(%d)", c,c);
      $write("\n");
      
      $fwrite(fid,"clk:  %d", clk_count);      
      $fwrite(fid,"\ta:  %b(%d)", a,a);
      $fwrite(fid,"\tb:  %b(%d)", b,b);
      $fwrite(fid,"\tc:  %c(%d)", c,c);
      $fwrite(fid,"\n");
   end

   // DEFINE WHEN TO TERMINATE SIMULATION:
   always @(posedge clk) begin
      clk_count <= clk_count + 1;
      if (clk_count == 8) begin
	 $fclose(fid);
	 $finish;
      end
   end

   
endmodule // testbench
