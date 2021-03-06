////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Interessengruppe fuer Mikroelektronik und Eingebettete Systeme (IMES)
// Fachhochschule Dortmund
//
// Filename     : prescalereg2.v
// Author       : Leduc
// Tool         : Mentor Graphics HDL Designer(TM) 2015.1b (Build 4)
// Description  : Prescaleregister m. reset Ausgang res_scale
// Commentary   :  
//
// Changelog:
// -------------------------------------------------------------------------------------------------
// Version | Author             | Date       | Changes
// -------------------------------------------------------------------------------------------------
// 0.9     | Leduc              | 15.05.2019 | created
// -------------------------------------------------------------------------------------------------
//
////////////////////////////////////////////////////////////////////////////////////////////////////

//`resetall
//`timescale 1ns/10ps
//`default_nettype none

module prescalereg2 (
  input wire clk,
  input wire rst,           // reset
  input wire cpu,           // CPU wuenscht Zugriff
  input wire [15:0] reginp, // CPU schreibt
  output wire [15:0] regout  // Prescaler liest --Beer 2018_06_18, erweitert auf 16bit
);

//tmrg default triplicate
//tmrg tmr_error false 

reg [15:0] register_i;

//triplication signals
wire [15:0] register_iVoted = register_i;
assign regout = register_iVoted;

always @(posedge clk)
begin
  if (rst == 1'b0) begin         // synchroner reset
    register_i <= 16'd0;
    end
  else if (cpu == 1'b1) begin
    register_i <= {8'd0,reginp[7:0]};
  end
  else
    register_i <= register_iVoted;
end 

endmodule
