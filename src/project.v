/*
 * Copyright (c) 2024 Luca Collini
 * SPDX-License-Identifier: Apache-2.0
 */

`define default_netname none

module tt_um_lucaz97_monobit (
    input  wire [7:0] ui_in,    // Dedicated inputs
    output wire [7:0] uo_out,   // Dedicated outputs
    input  wire [7:0] uio_in,   // IOs: Input path
    output wire [7:0] uio_out,  // IOs: Output path
    output wire [7:0] uio_oe,   // IOs: Enable path (active high: 0=input, 1=output)
    input  wire       ena,      // will go high when the design is enabled
    input  wire       clk,      // clock
    input  wire       rst_n     // reset_n - low to reset
);

  monobit monobit_inst (
      .clk(clk),
      .rst_n(rst_n),
      .is_random_rsc_dat(uo_out[0]),
      .is_random_triosy_lz(),
      .valid_rsc_dat(uo_out[1]),
      .valid_triosy_lz(),
      .epsilon_rsc_dat(ui_in[0]),
      .epsilon_triosy_lz()
    );

    monobit_block monobit_block_inst (
      .clk(clk),
      .rst_n(rst_n),
      .is_random_rsc_dat(uo_out[6]),
      .is_random_triosy_lz(),
      .valid_rsc_dat(uo_out[7]),
      .valid_triosy_lz(),
      .epsilon_rsc_dat(ui_in[0]),
      .epsilon_triosy_lz()
    );

    cusums cusums_inst (.clk(clk),
      .rst_n(rst_n),
      .is_random_rsc_dat(uo_out[2]),
      .is_random_triosy_lz(),
      .valid_rsc_dat(uo_out[3]),
      .valid_triosy_lz(),
      .epsilon_rsc_dat(ui_in[0]),
      .epsilon_triosy_lz());

    runs runs_inst (.clk(clk),
      .rst_n(rst_n),
      .is_random_rsc_dat(uo_out[4]),
      .is_random_triosy_lz(),
      .valid_rsc_dat(uo_out[5]),
      .valid_triosy_lz(),
      .epsilon_rsc_dat(ui_in[0]),
      .epsilon_triosy_lz());

      excursions excursions_inst (
      .clk(clk),
      .rst_n(rst_n),
      .is_random_rsc_dat(uio_out[0]),
      .is_random_triosy_lz(),
      .valid_rsc_dat(uio_out[1]),
      .valid_triosy_lz(),
      .epsilon_rsc_dat(ui_in[0]),
      .epsilon_triosy_lz()
    );
  // All output pins must be assigned. If not used, assign to 0.
  //assign uo_out[7:6] = 0;  // Example: ou_out is the sum of ui_in and uio_in
  assign uio_out[7:2] = 0;
  assign uio_oe[7:2]  = 0;
  assign uio_oe[1:0]  = 2'b11;
endmodule



//------> /eda/mentor/Siemens_EDA/Catapult_Synthesis_2023.1_2/Mgc_home/pkgs/siflibs/ccs_out_v1.v 
//------------------------------------------------------------------------------
// Catapult Synthesis - Sample I/O Port Library
//
// Copyright (c) 2003-2015 Mentor Graphics Corp.
//       All Rights Reserved
//
// This document may be used and distributed without restriction provided that
// this copyright statement is not removed from the file and that any derivative
// work contains this copyright notice.
//
// The design information contained in this file is intended to be an example
// of the functionality which the end user may study in preparation for creating
// their own custom interfaces. This design does not necessarily present a 
// complete implementation of the named protocol or standard.
//
//------------------------------------------------------------------------------

module ccs_out_v1 (dat, idat);

  parameter integer rscid = 1;
  parameter integer width = 8;

  output   [width-1:0] dat;
  input    [width-1:0] idat;

  wire     [width-1:0] dat;

  assign dat = idat;

endmodule




//------> /eda/mentor/Siemens_EDA/Catapult_Synthesis_2023.1_2/Mgc_home/pkgs/siflibs/ccs_in_v1.v 
//------------------------------------------------------------------------------
// Catapult Synthesis - Sample I/O Port Library
//
// Copyright (c) 2003-2017 Mentor Graphics Corp.
//       All Rights Reserved
//
// This document may be used and distributed without restriction provided that
// this copyright statement is not removed from the file and that any derivative
// work contains this copyright notice.
//
// The design information contained in this file is intended to be an example
// of the functionality which the end user may study in preparation for creating
// their own custom interfaces. This design does not necessarily present a 
// complete implementation of the named protocol or standard.
//
//------------------------------------------------------------------------------


module ccs_in_v1 (idat, dat);

  parameter integer rscid = 1;
  parameter integer width = 8;

  output [width-1:0] idat;
  input  [width-1:0] dat;

  wire   [width-1:0] idat;

  assign idat = dat;

endmodule


//------> /eda/mentor/Siemens_EDA/Catapult_Synthesis_2023.1_2/Mgc_home/pkgs/siflibs/mgc_io_sync_v2.v 
//------------------------------------------------------------------------------
// Catapult Synthesis - Sample I/O Port Library
//
// Copyright (c) 2003-2017 Mentor Graphics Corp.
//       All Rights Reserved
//
// This document may be used and distributed without restriction provided that
// this copyright statement is not removed from the file and that any derivative
// work contains this copyright notice.
//
// The design information contained in this file is intended to be an example
// of the functionality which the end user may study in preparation for creating
// their own custom interfaces. This design does not necessarily present a 
// complete implementation of the named protocol or standard.
//
//------------------------------------------------------------------------------


module mgc_io_sync_v2 (ld, lz);
    parameter valid = 0;

    input  ld;
    output lz;

    wire   lz;

    assign lz = ld;

endmodule


//------> /eda/mentor/Siemens_EDA/Catapult_Synthesis_2023.1_2/Mgc_home/pkgs/siflibs/mgc_shift_bl_beh_v5.v 
module mgc_shift_bl_v5(a,s,z);
   parameter    width_a = 4;
   parameter    signd_a = 1;
   parameter    width_s = 2;
   parameter    width_z = 8;

   input [width_a-1:0] a;
   input [width_s-1:0] s;
   output [width_z -1:0] z;

   generate if ( signd_a )
   begin: SGNED
     assign z = fshl_s(a,s,a[width_a-1]);
   end
   else
   begin: UNSGNED
     assign z = fshl_s(a,s,1'b0);
   end
   endgenerate

   //Shift-left - unsigned shift argument one bit more
   function [width_z-1:0] fshl_u_1;
      input [width_a  :0] arg1;
      input [width_s-1:0] arg2;
      input sbit;
      parameter olen = width_z;
      parameter ilen = width_a+1;
      parameter len = (ilen >= olen) ? ilen : olen;
      reg [len-1:0] result;
      reg [len-1:0] result_t;
      begin
        result_t = {(len){sbit}};
        result_t[ilen-1:0] = arg1;
        result = result_t <<< arg2;
        fshl_u_1 =  result[olen-1:0];
      end
   endfunction // fshl_u

   //Shift-left - unsigned shift argument
   function [width_z-1:0] fshl_u;
      input [width_a-1:0] arg1;
      input [width_s-1:0] arg2;
      input sbit;
      fshl_u = fshl_u_1({sbit,arg1} ,arg2, sbit);
   endfunction // fshl_u

   //Shift right - unsigned shift argument
   function [width_z-1:0] fshr_u;
      input [width_a-1:0] arg1;
      input [width_s-1:0] arg2;
      input sbit;
      parameter olen = width_z;
      parameter ilen = signd_a ? width_a : width_a+1;
      parameter len = (ilen >= olen) ? ilen : olen;
      reg signed [len-1:0] result;
      reg signed [len-1:0] result_t;
      begin
        result_t = $signed( {(len){sbit}} );
        result_t[width_a-1:0] = arg1;
        result = result_t >>> arg2;
        fshr_u =  result[olen-1:0];
      end
   endfunction // fshl_u

   //Shift left - signed shift argument
   function [width_z-1:0] fshl_s;
      input [width_a-1:0] arg1;
      input [width_s-1:0] arg2;
      input sbit;
      reg [width_a:0] sbit_arg1;
      begin
        // Ignoring the possibility that arg2[width_s-1] could be X
        // because of customer complaints regarding X'es in simulation results
        if ( arg2[width_s-1] == 1'b0 )
        begin
          sbit_arg1[width_a:0] = {(width_a+1){1'b0}};
          fshl_s = fshl_u(arg1, arg2, sbit);
        end
        else
        begin
          sbit_arg1[width_a] = sbit;
          sbit_arg1[width_a-1:0] = arg1;
          fshl_s = fshr_u(sbit_arg1[width_a:1], ~arg2, sbit);
        end
      end
   endfunction

endmodule

//------> /eda/mentor/Siemens_EDA/Catapult_Synthesis_2023.1_2/Mgc_home/pkgs/siflibs/mgc_shift_l_beh_v5.v 
module mgc_shift_l_v5(a,s,z);
   parameter    width_a = 4;
   parameter    signd_a = 1;
   parameter    width_s = 2;
   parameter    width_z = 8;

   input [width_a-1:0] a;
   input [width_s-1:0] s;
   output [width_z -1:0] z;

   generate
   if (signd_a)
   begin: SGNED
      assign z = fshl_u(a,s,a[width_a-1]);
   end
   else
   begin: UNSGNED
      assign z = fshl_u(a,s,1'b0);
   end
   endgenerate

   //Shift-left - unsigned shift argument one bit more
   function [width_z-1:0] fshl_u_1;
      input [width_a  :0] arg1;
      input [width_s-1:0] arg2;
      input sbit;
      parameter olen = width_z;
      parameter ilen = width_a+1;
      parameter len = (ilen >= olen) ? ilen : olen;
      reg [len-1:0] result;
      reg [len-1:0] result_t;
      begin
        result_t = {(len){sbit}};
        result_t[ilen-1:0] = arg1;
        result = result_t <<< arg2;
        fshl_u_1 =  result[olen-1:0];
      end
   endfunction // fshl_u

   //Shift-left - unsigned shift argument
   function [width_z-1:0] fshl_u;
      input [width_a-1:0] arg1;
      input [width_s-1:0] arg2;
      input sbit;
      fshl_u = fshl_u_1({sbit,arg1} ,arg2, sbit);
   endfunction // fshl_u

endmodule

//------> ../td_ccore_solutions/leading_sign_20_0_cece25dae2d00b43c3b124ab661316c967d1_0/rtl.v 
// ----------------------------------------------------------------------
//  HLS HDL:        Verilog Netlister
//  HLS Version:    2023.1_2/1049935 Production Release
//  HLS Date:       Sat Jun 10 10:53:51 PDT 2023
// 
//  Generated by:   lc4976@hansolo.poly.edu
//  Generated date: Fri Mar 29 18:01:13 2024
// ----------------------------------------------------------------------

// 
// ------------------------------------------------------------------
//  Design Unit:    leading_sign_20_0
// ------------------------------------------------------------------


module leading_sign_20_0 (
  mantissa, rtn
);
  input [19:0] mantissa;
  output [4:0] rtn;


  // Interconnect Declarations
  wire ac_math_ac_normalize_20_20_false_AC_TRN_AC_WRAP_leading_1_leading_sign_20_0_rtn_wrs_c_6_2_sdt_2;
  wire ac_math_ac_normalize_20_20_false_AC_TRN_AC_WRAP_leading_1_leading_sign_20_0_rtn_wrs_c_18_3_sdt_3;
  wire ac_math_ac_normalize_20_20_false_AC_TRN_AC_WRAP_leading_1_leading_sign_20_0_rtn_wrs_c_26_2_sdt_2;
  wire ac_math_ac_normalize_20_20_false_AC_TRN_AC_WRAP_leading_1_leading_sign_20_0_rtn_wrs_c_42_4_sdt_4;
  wire ac_math_ac_normalize_20_20_false_AC_TRN_AC_WRAP_leading_1_leading_sign_20_0_rtn_wrs_c_6_2_sdt_1;
  wire ac_math_ac_normalize_20_20_false_AC_TRN_AC_WRAP_leading_1_leading_sign_20_0_rtn_wrs_c_14_2_sdt_1;
  wire ac_math_ac_normalize_20_20_false_AC_TRN_AC_WRAP_leading_1_leading_sign_20_0_rtn_wrs_c_26_2_sdt_1;
  wire ac_math_ac_normalize_20_20_false_AC_TRN_AC_WRAP_leading_1_leading_sign_20_0_rtn_wrs_c_34_2_sdt_1;
  wire ac_math_ac_normalize_20_20_false_AC_TRN_AC_WRAP_leading_1_leading_sign_20_0_rtn_wrs_c_50_2_sdt_1;
  wire c_h_1_2;
  wire c_h_1_5;
  wire c_h_1_6;
  wire c_h_1_8;
  wire ac_math_ac_normalize_20_20_false_AC_TRN_AC_WRAP_leading_1_leading_sign_20_0_rtn_and_75_ssc;

  wire ac_math_ac_normalize_20_20_false_AC_TRN_AC_WRAP_leading_1_leading_sign_20_0_rtn_ac_math_ac_normalize_20_20_false_AC_TRN_AC_WRAP_leading_1_leading_sign_20_0_rtn_and_nl;
  wire ac_math_ac_normalize_20_20_false_AC_TRN_AC_WRAP_leading_1_leading_sign_20_0_rtn_ac_math_ac_normalize_20_20_false_AC_TRN_AC_WRAP_leading_1_leading_sign_20_0_rtn_or_1_nl;
  wire ac_math_ac_normalize_20_20_false_AC_TRN_AC_WRAP_leading_1_leading_sign_20_0_rtn_ac_math_ac_normalize_20_20_false_AC_TRN_AC_WRAP_leading_1_leading_sign_20_0_rtn_and_2_nl;
  wire ac_math_ac_normalize_20_20_false_AC_TRN_AC_WRAP_leading_1_leading_sign_20_0_rtn_ac_math_ac_normalize_20_20_false_AC_TRN_AC_WRAP_leading_1_leading_sign_20_0_rtn_ac_math_ac_normalize_20_20_false_AC_TRN_AC_WRAP_leading_1_leadi000000;

  // Interconnect Declarations for Component Instantiations 
  assign ac_math_ac_normalize_20_20_false_AC_TRN_AC_WRAP_leading_1_leading_sign_20_0_rtn_wrs_c_6_2_sdt_2
      = ~((mantissa[17:16]!=2'b00));
  assign ac_math_ac_normalize_20_20_false_AC_TRN_AC_WRAP_leading_1_leading_sign_20_0_rtn_wrs_c_6_2_sdt_1
      = ~((mantissa[19:18]!=2'b00));
  assign ac_math_ac_normalize_20_20_false_AC_TRN_AC_WRAP_leading_1_leading_sign_20_0_rtn_wrs_c_14_2_sdt_1
      = ~((mantissa[15:14]!=2'b00));
  assign c_h_1_2 = ac_math_ac_normalize_20_20_false_AC_TRN_AC_WRAP_leading_1_leading_sign_20_0_rtn_wrs_c_6_2_sdt_1
      & ac_math_ac_normalize_20_20_false_AC_TRN_AC_WRAP_leading_1_leading_sign_20_0_rtn_wrs_c_6_2_sdt_2;
  assign ac_math_ac_normalize_20_20_false_AC_TRN_AC_WRAP_leading_1_leading_sign_20_0_rtn_wrs_c_18_3_sdt_3
      = (mantissa[13:12]==2'b00) & ac_math_ac_normalize_20_20_false_AC_TRN_AC_WRAP_leading_1_leading_sign_20_0_rtn_wrs_c_14_2_sdt_1;
  assign ac_math_ac_normalize_20_20_false_AC_TRN_AC_WRAP_leading_1_leading_sign_20_0_rtn_wrs_c_26_2_sdt_2
      = ~((mantissa[9:8]!=2'b00));
  assign ac_math_ac_normalize_20_20_false_AC_TRN_AC_WRAP_leading_1_leading_sign_20_0_rtn_wrs_c_26_2_sdt_1
      = ~((mantissa[11:10]!=2'b00));
  assign ac_math_ac_normalize_20_20_false_AC_TRN_AC_WRAP_leading_1_leading_sign_20_0_rtn_wrs_c_34_2_sdt_1
      = ~((mantissa[7:6]!=2'b00));
  assign c_h_1_5 = ac_math_ac_normalize_20_20_false_AC_TRN_AC_WRAP_leading_1_leading_sign_20_0_rtn_wrs_c_26_2_sdt_1
      & ac_math_ac_normalize_20_20_false_AC_TRN_AC_WRAP_leading_1_leading_sign_20_0_rtn_wrs_c_26_2_sdt_2;
  assign c_h_1_6 = c_h_1_2 & ac_math_ac_normalize_20_20_false_AC_TRN_AC_WRAP_leading_1_leading_sign_20_0_rtn_wrs_c_18_3_sdt_3;
  assign ac_math_ac_normalize_20_20_false_AC_TRN_AC_WRAP_leading_1_leading_sign_20_0_rtn_wrs_c_42_4_sdt_4
      = (mantissa[5:4]==2'b00) & ac_math_ac_normalize_20_20_false_AC_TRN_AC_WRAP_leading_1_leading_sign_20_0_rtn_wrs_c_34_2_sdt_1
      & c_h_1_5;
  assign ac_math_ac_normalize_20_20_false_AC_TRN_AC_WRAP_leading_1_leading_sign_20_0_rtn_wrs_c_50_2_sdt_1
      = ~((mantissa[3:2]!=2'b00));
  assign c_h_1_8 = c_h_1_6 & ac_math_ac_normalize_20_20_false_AC_TRN_AC_WRAP_leading_1_leading_sign_20_0_rtn_wrs_c_42_4_sdt_4;
  assign ac_math_ac_normalize_20_20_false_AC_TRN_AC_WRAP_leading_1_leading_sign_20_0_rtn_and_75_ssc
      = (mantissa[1:0]==2'b00) & ac_math_ac_normalize_20_20_false_AC_TRN_AC_WRAP_leading_1_leading_sign_20_0_rtn_wrs_c_50_2_sdt_1
      & c_h_1_8;
  assign ac_math_ac_normalize_20_20_false_AC_TRN_AC_WRAP_leading_1_leading_sign_20_0_rtn_ac_math_ac_normalize_20_20_false_AC_TRN_AC_WRAP_leading_1_leading_sign_20_0_rtn_and_nl
      = c_h_1_6 & (~ ac_math_ac_normalize_20_20_false_AC_TRN_AC_WRAP_leading_1_leading_sign_20_0_rtn_wrs_c_42_4_sdt_4);
  assign ac_math_ac_normalize_20_20_false_AC_TRN_AC_WRAP_leading_1_leading_sign_20_0_rtn_ac_math_ac_normalize_20_20_false_AC_TRN_AC_WRAP_leading_1_leading_sign_20_0_rtn_or_1_nl
      = (c_h_1_2 & (c_h_1_5 | (~ ac_math_ac_normalize_20_20_false_AC_TRN_AC_WRAP_leading_1_leading_sign_20_0_rtn_wrs_c_18_3_sdt_3))
      & (~ c_h_1_8)) | ac_math_ac_normalize_20_20_false_AC_TRN_AC_WRAP_leading_1_leading_sign_20_0_rtn_and_75_ssc;
  assign ac_math_ac_normalize_20_20_false_AC_TRN_AC_WRAP_leading_1_leading_sign_20_0_rtn_ac_math_ac_normalize_20_20_false_AC_TRN_AC_WRAP_leading_1_leading_sign_20_0_rtn_and_2_nl
      = ac_math_ac_normalize_20_20_false_AC_TRN_AC_WRAP_leading_1_leading_sign_20_0_rtn_wrs_c_6_2_sdt_1
      & (ac_math_ac_normalize_20_20_false_AC_TRN_AC_WRAP_leading_1_leading_sign_20_0_rtn_wrs_c_14_2_sdt_1
      | (~ ac_math_ac_normalize_20_20_false_AC_TRN_AC_WRAP_leading_1_leading_sign_20_0_rtn_wrs_c_6_2_sdt_2))
      & (~((~(ac_math_ac_normalize_20_20_false_AC_TRN_AC_WRAP_leading_1_leading_sign_20_0_rtn_wrs_c_26_2_sdt_1
      & (ac_math_ac_normalize_20_20_false_AC_TRN_AC_WRAP_leading_1_leading_sign_20_0_rtn_wrs_c_34_2_sdt_1
      | (~ ac_math_ac_normalize_20_20_false_AC_TRN_AC_WRAP_leading_1_leading_sign_20_0_rtn_wrs_c_26_2_sdt_2))))
      & c_h_1_6)) & (ac_math_ac_normalize_20_20_false_AC_TRN_AC_WRAP_leading_1_leading_sign_20_0_rtn_wrs_c_50_2_sdt_1
      | (~ c_h_1_8)) & (~ ac_math_ac_normalize_20_20_false_AC_TRN_AC_WRAP_leading_1_leading_sign_20_0_rtn_and_75_ssc);
  assign ac_math_ac_normalize_20_20_false_AC_TRN_AC_WRAP_leading_1_leading_sign_20_0_rtn_ac_math_ac_normalize_20_20_false_AC_TRN_AC_WRAP_leading_1_leading_sign_20_0_rtn_ac_math_ac_normalize_20_20_false_AC_TRN_AC_WRAP_leading_1_leadi000000
      = ~((mantissa[19]) | (~((mantissa[18:17]!=2'b01))) | (((mantissa[15]) | (~((mantissa[14:13]!=2'b01))))
      & c_h_1_2) | ((~((~((mantissa[11]) | (~((mantissa[10:9]!=2'b01))))) & (~(((mantissa[7])
      | (~((mantissa[6:5]!=2'b01)))) & c_h_1_5)))) & c_h_1_6) | (((mantissa[3]) |
      (~((mantissa[2:1]!=2'b01)))) & c_h_1_8) | ac_math_ac_normalize_20_20_false_AC_TRN_AC_WRAP_leading_1_leading_sign_20_0_rtn_and_75_ssc);
  assign rtn = {c_h_1_8 , ac_math_ac_normalize_20_20_false_AC_TRN_AC_WRAP_leading_1_leading_sign_20_0_rtn_ac_math_ac_normalize_20_20_false_AC_TRN_AC_WRAP_leading_1_leading_sign_20_0_rtn_and_nl
      , ac_math_ac_normalize_20_20_false_AC_TRN_AC_WRAP_leading_1_leading_sign_20_0_rtn_ac_math_ac_normalize_20_20_false_AC_TRN_AC_WRAP_leading_1_leading_sign_20_0_rtn_or_1_nl
      , ac_math_ac_normalize_20_20_false_AC_TRN_AC_WRAP_leading_1_leading_sign_20_0_rtn_ac_math_ac_normalize_20_20_false_AC_TRN_AC_WRAP_leading_1_leading_sign_20_0_rtn_and_2_nl
      , ac_math_ac_normalize_20_20_false_AC_TRN_AC_WRAP_leading_1_leading_sign_20_0_rtn_ac_math_ac_normalize_20_20_false_AC_TRN_AC_WRAP_leading_1_leading_sign_20_0_rtn_ac_math_ac_normalize_20_20_false_AC_TRN_AC_WRAP_leading_1_leadi000000};
endmodule



//------> ./rtl.v 
// ----------------------------------------------------------------------
//  HLS HDL:        Verilog Netlister
//  HLS Version:    2023.1_2/1049935 Production Release
//  HLS Date:       Sat Jun 10 10:53:51 PDT 2023
// 
//  Generated by:   lc4976@hansolo.poly.edu
//  Generated date: Tue Mar 19 12:57:15 2024
// ----------------------------------------------------------------------

// 
// ------------------------------------------------------------------
//  Design Unit:    monobit_core
// ------------------------------------------------------------------


module monobit_core (
  clk, rst_n, is_random_rsc_dat, is_random_triosy_lz, valid_rsc_dat, valid_triosy_lz,
      epsilon_rsc_dat, epsilon_triosy_lz
);
  input clk;
  input rst_n;
  output is_random_rsc_dat;
  output is_random_triosy_lz;
  output valid_rsc_dat;
  output valid_triosy_lz;
  input epsilon_rsc_dat;
  output epsilon_triosy_lz;


  // Interconnect Declarations
  reg is_random_rsci_idat;
  reg valid_rsci_idat;
  wire epsilon_rsci_idat;
  reg reg_epsilon_triosy_obj_ld_cse;
  reg [16:0] sum_sva;
  reg [15:0] bit_count_sva;
  wire [16:0] nl_bit_count_sva;
  wire [16:0] sum_sva_2;
  wire [17:0] nl_sum_sva_2;
  wire unequal_tmp_1;

  wire[15:0] operator_17_true_acc_nl;
  wire[16:0] nl_operator_17_true_acc_nl;
  wire[16:0] operator_17_true_acc_nl_1;
  wire[17:0] nl_operator_17_true_acc_nl_1;

  // Interconnect Declarations for Component Instantiations 
  ccs_out_v1 #(.rscid(32'sd1),
  .width(32'sd1)) is_random_rsci (
      .idat(is_random_rsci_idat),
      .dat(is_random_rsc_dat)
    );
  ccs_out_v1 #(.rscid(32'sd2),
  .width(32'sd1)) valid_rsci (
      .idat(valid_rsci_idat),
      .dat(valid_rsc_dat)
    );
  ccs_in_v1 #(.rscid(32'sd3),
  .width(32'sd1)) epsilon_rsci (
      .dat(epsilon_rsc_dat),
      .idat(epsilon_rsci_idat)
    );
  mgc_io_sync_v2 #(.valid(32'sd0)) is_random_triosy_obj (
      .ld(reg_epsilon_triosy_obj_ld_cse),
      .lz(is_random_triosy_lz)
    );
  mgc_io_sync_v2 #(.valid(32'sd0)) valid_triosy_obj (
      .ld(reg_epsilon_triosy_obj_ld_cse),
      .lz(valid_triosy_lz)
    );
  mgc_io_sync_v2 #(.valid(32'sd0)) epsilon_triosy_obj (
      .ld(reg_epsilon_triosy_obj_ld_cse),
      .lz(epsilon_triosy_lz)
    );
  assign nl_sum_sva_2 = sum_sva + conv_s2s_2_17({(~ epsilon_rsci_idat) , 1'b1});
  assign sum_sva_2 = nl_sum_sva_2[16:0];
  assign unequal_tmp_1 = ~((bit_count_sva==16'b1111111111111111));
  always @(posedge clk) begin
    if ( ~ rst_n ) begin
      reg_epsilon_triosy_obj_ld_cse <= 1'b0;
      valid_rsci_idat <= 1'b0;
      is_random_rsci_idat <= 1'b0;
      bit_count_sva <= 16'b0000000000000000;
      sum_sva <= 17'b00000000000000000;
    end
    else begin
      reg_epsilon_triosy_obj_ld_cse <= 1'b1;
      valid_rsci_idat <= ~ unequal_tmp_1;
      is_random_rsci_idat <= ~((readslicef_16_1_15(operator_17_true_acc_nl)) | (readslicef_17_1_16(operator_17_true_acc_nl_1))
          | unequal_tmp_1);
      bit_count_sva <= nl_bit_count_sva[15:0];
      sum_sva <= sum_sva_2;
    end
  end
  assign nl_operator_17_true_acc_nl = conv_s2u_15_16(~ (sum_sva_2[16:2])) + 16'b0000000010100101;
  assign operator_17_true_acc_nl = nl_operator_17_true_acc_nl[15:0];
  assign nl_operator_17_true_acc_nl_1 = conv_s2u_16_17(sum_sva_2[16:1]) + 17'b00000000101001001;
  assign operator_17_true_acc_nl_1 = nl_operator_17_true_acc_nl_1[16:0];
  assign nl_bit_count_sva  = bit_count_sva + 16'b0000000000000001;

  function automatic [0:0] readslicef_16_1_15;
    input [15:0] vector;
    reg [15:0] tmp;
  begin
    tmp = vector >> 15;
    readslicef_16_1_15 = tmp[0:0];
  end
  endfunction


  function automatic [0:0] readslicef_17_1_16;
    input [16:0] vector;
    reg [16:0] tmp;
  begin
    tmp = vector >> 16;
    readslicef_17_1_16 = tmp[0:0];
  end
  endfunction


  function automatic [16:0] conv_s2s_2_17 ;
    input [1:0]  vector ;
  begin
    conv_s2s_2_17 = {{15{vector[1]}}, vector};
  end
  endfunction


  function automatic [15:0] conv_s2u_15_16 ;
    input [14:0]  vector ;
  begin
    conv_s2u_15_16 = {vector[14], vector};
  end
  endfunction


  function automatic [16:0] conv_s2u_16_17 ;
    input [15:0]  vector ;
  begin
    conv_s2u_16_17 = {vector[15], vector};
  end
  endfunction

endmodule

// ------------------------------------------------------------------
//  Design Unit:    monobit
// ------------------------------------------------------------------


module monobit (
  clk, rst_n, is_random_rsc_dat, is_random_triosy_lz, valid_rsc_dat, valid_triosy_lz,
      epsilon_rsc_dat, epsilon_triosy_lz
);
  input clk;
  input rst_n;
  output is_random_rsc_dat;
  output is_random_triosy_lz;
  output valid_rsc_dat;
  output valid_triosy_lz;
  input epsilon_rsc_dat;
  output epsilon_triosy_lz;



  // Interconnect Declarations for Component Instantiations 
  monobit_core monobit_core_inst (
      .clk(clk),
      .rst_n(rst_n),
      .is_random_rsc_dat(is_random_rsc_dat),
      .is_random_triosy_lz(is_random_triosy_lz),
      .valid_rsc_dat(valid_rsc_dat),
      .valid_triosy_lz(valid_triosy_lz),
      .epsilon_rsc_dat(epsilon_rsc_dat),
      .epsilon_triosy_lz(epsilon_triosy_lz)
    );
endmodule


//------> ./rtl.v 
// ----------------------------------------------------------------------
//  HLS HDL:        Verilog Netlister
//  HLS Version:    2023.1_2/1049935 Production Release
//  HLS Date:       Sat Jun 10 10:53:51 PDT 2023
// 
//  Generated by:   lc4976@hansolo.poly.edu
//  Generated date: Tue Mar 19 15:34:03 2024
// ----------------------------------------------------------------------

// 
// ------------------------------------------------------------------
//  Design Unit:    cusums_core
// ------------------------------------------------------------------


module cusums_core (
  clk, rst_n, epsilon_rsc_dat, epsilon_triosy_lz, is_random_rsc_dat, is_random_triosy_lz,
      valid_rsc_dat, valid_triosy_lz
);
  input clk;
  input rst_n;
  input epsilon_rsc_dat;
  output epsilon_triosy_lz;
  output is_random_rsc_dat;
  output is_random_triosy_lz;
  output valid_rsc_dat;
  output valid_triosy_lz;


  // Interconnect Declarations
  wire epsilon_rsci_idat;
  reg is_random_rsci_idat;
  reg valid_rsci_idat;
  wire [14:0] acc_2_tmp;
  wire [15:0] nl_acc_2_tmp;
  reg [15:0] inf_sva;
  reg [15:0] sup_sva;
  reg reg_valid_triosy_obj_ld_cse;
  wire [15:0] z_out;
  wire [16:0] nl_z_out;
  reg [15:0] S_sva;
  reg operator_16_true_slc_32_svs;
  reg count_sva_14;
  reg [1:0] count_sva_13_12;
  reg [2:0] count_sva_11_9;
  reg [2:0] count_sva_8_6;
  reg count_sva_5;
  reg [4:0] count_sva_4_0;
  wire [15:0] sup_sva_dfm_mx0;
  wire [15:0] inf_sva_dfm_mx0;
  wire operator_16_true_slc_32_svs_mx0;
  wire unequal_tmp_1;
  wire and_20_cse;
  wire nor_4_cse;
  wire acc_itm_16;
  wire acc_1_itm_16;

  wire[14:0] operator_16_true_acc_nl;
  wire[15:0] nl_operator_16_true_acc_nl;
  wire[16:0] acc_nl;
  wire[17:0] nl_acc_nl;
  wire[15:0] if_acc_nl;
  wire[16:0] nl_if_acc_nl;
  wire[16:0] acc_1_nl;
  wire[17:0] nl_acc_1_nl;
  wire[15:0] if_1_acc_nl;
  wire[16:0] nl_if_1_acc_nl;
  wire[16:0] operator_16_true_acc_nl_1;
  wire[17:0] nl_operator_16_true_acc_nl_1;
  wire or_13_nl;

  // Interconnect Declarations for Component Instantiations 
  ccs_in_v1 #(.rscid(32'sd1),
  .width(32'sd1)) epsilon_rsci (
      .dat(epsilon_rsc_dat),
      .idat(epsilon_rsci_idat)
    );
  ccs_out_v1 #(.rscid(32'sd2),
  .width(32'sd1)) is_random_rsci (
      .idat(is_random_rsci_idat),
      .dat(is_random_rsc_dat)
    );
  ccs_out_v1 #(.rscid(32'sd3),
  .width(32'sd1)) valid_rsci (
      .idat(valid_rsci_idat),
      .dat(valid_rsc_dat)
    );
  mgc_io_sync_v2 #(.valid(32'sd0)) epsilon_triosy_obj (
      .ld(reg_valid_triosy_obj_ld_cse),
      .lz(epsilon_triosy_lz)
    );
  mgc_io_sync_v2 #(.valid(32'sd0)) is_random_triosy_obj (
      .ld(reg_valid_triosy_obj_ld_cse),
      .lz(is_random_triosy_lz)
    );
  mgc_io_sync_v2 #(.valid(32'sd0)) valid_triosy_obj (
      .ld(reg_valid_triosy_obj_ld_cse),
      .lz(valid_triosy_lz)
    );
  assign nor_4_cse = ~((acc_2_tmp[8:7]!=2'b00));
  assign and_20_cse = (~((acc_2_tmp[1:0]!=2'b00))) & (~((acc_2_tmp[3:2]!=2'b00)))
      & (~((acc_2_tmp[4]) | (acc_2_tmp[6]))) & nor_4_cse & (~((acc_2_tmp[13:12]!=2'b00)))
      & (acc_2_tmp[5]) & (acc_2_tmp[9]) & (acc_2_tmp[10]) & (acc_2_tmp[11]) & (acc_2_tmp[14]);
  assign nl_acc_nl = conv_s2u_16_17(sup_sva) - conv_s2u_16_17(z_out);
  assign acc_nl = nl_acc_nl[16:0];
  assign acc_itm_16 = readslicef_17_1_16(acc_nl);
  assign nl_if_acc_nl = sup_sva + 16'b0000000000000001;
  assign if_acc_nl = nl_if_acc_nl[15:0];
  assign sup_sva_dfm_mx0 = MUX_v_16_2_2(sup_sva, if_acc_nl, acc_itm_16);
  assign nl_acc_1_nl = conv_s2u_16_17(z_out) - conv_s2u_16_17(inf_sva);
  assign acc_1_nl = nl_acc_1_nl[16:0];
  assign acc_1_itm_16 = readslicef_17_1_16(acc_1_nl);
  assign nl_if_1_acc_nl = inf_sva + 16'b1111111111111111;
  assign if_1_acc_nl = nl_if_1_acc_nl[15:0];
  assign inf_sva_dfm_mx0 = MUX_v_16_2_2(inf_sva, if_1_acc_nl, acc_1_itm_16);
  assign nl_operator_16_true_acc_nl_1 = conv_s2s_16_17(sup_sva_dfm_mx0) + 17'b11111111001110011;
  assign operator_16_true_acc_nl_1 = nl_operator_16_true_acc_nl_1[16:0];
  assign or_13_nl = (acc_2_tmp!=15'b100111000100000);
  assign operator_16_true_slc_32_svs_mx0 = MUX_s_1_2_2((readslicef_17_1_16(operator_16_true_acc_nl_1)),
      operator_16_true_slc_32_svs, or_13_nl);
  assign unequal_tmp_1 = ~((acc_2_tmp==15'b100111000100000));
  assign nl_acc_2_tmp = ({count_sva_14 , count_sva_13_12 , count_sva_11_9 , count_sva_8_6
      , count_sva_5 , count_sva_4_0}) + 15'b000000000000001;
  assign acc_2_tmp = nl_acc_2_tmp[14:0];
  always @(posedge clk) begin
    if ( ~ rst_n ) begin
      S_sva <= 16'b0000000000000000;
      reg_valid_triosy_obj_ld_cse <= 1'b0;
      valid_rsci_idat <= 1'b0;
      is_random_rsci_idat <= 1'b0;
      count_sva_14 <= 1'b0;
      count_sva_13_12 <= 2'b00;
      count_sva_11_9 <= 3'b000;
      count_sva_8_6 <= 3'b000;
      count_sva_5 <= 1'b0;
      count_sva_4_0 <= 5'b00000;
    end
    else begin
      S_sva <= MUX_v_16_2_2(16'b0000000000000000, z_out, unequal_tmp_1);
      reg_valid_triosy_obj_ld_cse <= 1'b1;
      valid_rsci_idat <= ~ unequal_tmp_1;
      is_random_rsci_idat <= (readslicef_15_1_14(operator_16_true_acc_nl)) & operator_16_true_slc_32_svs_mx0
          & (~ unequal_tmp_1);
      count_sva_14 <= (acc_2_tmp[14]) & unequal_tmp_1;
      count_sva_13_12 <= acc_2_tmp[13:12];
      count_sva_11_9 <= MUX_v_3_2_2(3'b000, (acc_2_tmp[11:9]), unequal_tmp_1);
      count_sva_8_6 <= acc_2_tmp[8:6];
      count_sva_5 <= (acc_2_tmp[5]) & unequal_tmp_1;
      count_sva_4_0 <= acc_2_tmp[4:0];
    end
  end
  always @(posedge clk) begin
    if ( ~ rst_n ) begin
      sup_sva <= 16'b0000000000000000;
    end
    else if ( and_20_cse | acc_itm_16 ) begin
      sup_sva <= MUX_v_16_2_2(16'b0000000000000000, sup_sva_dfm_mx0, unequal_tmp_1);
    end
  end
  always @(posedge clk) begin
    if ( ~ rst_n ) begin
      inf_sva <= 16'b0000000000000000;
    end
    else if ( and_20_cse | acc_1_itm_16 ) begin
      inf_sva <= MUX_v_16_2_2(16'b0000000000000000, inf_sva_dfm_mx0, unequal_tmp_1);
    end
  end
  always @(posedge clk) begin
    if ( ~ rst_n ) begin
      operator_16_true_slc_32_svs <= 1'b0;
    end
    else if ( (acc_2_tmp[14:9]==6'b100111) & nor_4_cse & (acc_2_tmp[6:0]==7'b0100000)
        ) begin
      operator_16_true_slc_32_svs <= operator_16_true_slc_32_svs_mx0;
    end
  end
  assign nl_operator_16_true_acc_nl = conv_s2u_14_15(~ (inf_sva_dfm_mx0[15:2])) +
      15'b111111110011101;
  assign operator_16_true_acc_nl = nl_operator_16_true_acc_nl[14:0];
  assign nl_z_out = S_sva + conv_s2u_2_16({(~ epsilon_rsci_idat) , 1'b1});
  assign z_out = nl_z_out[15:0];

  function automatic  MUX_s_1_2_2;
    input  input_0;
    input  input_1;
    input  sel;
    reg  result;
  begin
    case (sel)
      1'b0 : begin
        result = input_0;
      end
      default : begin
        result = input_1;
      end
    endcase
    MUX_s_1_2_2 = result;
  end
  endfunction


  function automatic [15:0] MUX_v_16_2_2;
    input [15:0] input_0;
    input [15:0] input_1;
    input  sel;
    reg [15:0] result;
  begin
    case (sel)
      1'b0 : begin
        result = input_0;
      end
      default : begin
        result = input_1;
      end
    endcase
    MUX_v_16_2_2 = result;
  end
  endfunction


  function automatic [2:0] MUX_v_3_2_2;
    input [2:0] input_0;
    input [2:0] input_1;
    input  sel;
    reg [2:0] result;
  begin
    case (sel)
      1'b0 : begin
        result = input_0;
      end
      default : begin
        result = input_1;
      end
    endcase
    MUX_v_3_2_2 = result;
  end
  endfunction


  function automatic [0:0] readslicef_15_1_14;
    input [14:0] vector;
    reg [14:0] tmp;
  begin
    tmp = vector >> 14;
    readslicef_15_1_14 = tmp[0:0];
  end
  endfunction


  function automatic [0:0] readslicef_17_1_16;
    input [16:0] vector;
    reg [16:0] tmp;
  begin
    tmp = vector >> 16;
    readslicef_17_1_16 = tmp[0:0];
  end
  endfunction


  function automatic [16:0] conv_s2s_16_17 ;
    input [15:0]  vector ;
  begin
    conv_s2s_16_17 = {vector[15], vector};
  end
  endfunction


  function automatic [15:0] conv_s2u_2_16 ;
    input [1:0]  vector ;
  begin
    conv_s2u_2_16 = {{14{vector[1]}}, vector};
  end
  endfunction


  function automatic [14:0] conv_s2u_14_15 ;
    input [13:0]  vector ;
  begin
    conv_s2u_14_15 = {vector[13], vector};
  end
  endfunction


  function automatic [16:0] conv_s2u_16_17 ;
    input [15:0]  vector ;
  begin
    conv_s2u_16_17 = {vector[15], vector};
  end
  endfunction

endmodule

// ------------------------------------------------------------------
//  Design Unit:    cusums
// ------------------------------------------------------------------


module cusums (
  clk, rst_n, epsilon_rsc_dat, epsilon_triosy_lz, is_random_rsc_dat, is_random_triosy_lz,
      valid_rsc_dat, valid_triosy_lz
);
  input clk;
  input rst_n;
  input epsilon_rsc_dat;
  output epsilon_triosy_lz;
  output is_random_rsc_dat;
  output is_random_triosy_lz;
  output valid_rsc_dat;
  output valid_triosy_lz;



  // Interconnect Declarations for Component Instantiations 
  cusums_core cusums_core_inst (
      .clk(clk),
      .rst_n(rst_n),
      .epsilon_rsc_dat(epsilon_rsc_dat),
      .epsilon_triosy_lz(epsilon_triosy_lz),
      .is_random_rsc_dat(is_random_rsc_dat),
      .is_random_triosy_lz(is_random_triosy_lz),
      .valid_rsc_dat(valid_rsc_dat),
      .valid_triosy_lz(valid_triosy_lz)
    );
endmodule


module runs_core (
  clk, rst_n, is_random_rsc_dat, is_random_triosy_lz, valid_rsc_dat, valid_triosy_lz,
      epsilon_rsc_dat, epsilon_triosy_lz
);
  input clk;
  input rst_n;
  output is_random_rsc_dat;
  output is_random_triosy_lz;
  output valid_rsc_dat;
  output valid_triosy_lz;
  input epsilon_rsc_dat;
  output epsilon_triosy_lz;


  // Interconnect Declarations
  reg is_random_rsci_idat;
  reg valid_rsci_idat;
  wire epsilon_rsci_idat;
  wire [15:0] acc_tmp;
  wire [16:0] nl_acc_tmp;
  wire or_dcpl_15;
  wire or_dcpl_30;
  reg prev_0_sva;
  reg [15:0] S_sva;
  reg [15:0] n_sva;
  wire [15:0] S_sva_dfm_mx0;
  wire unequal_tmp_1;
  reg reg_epsilon_triosy_obj_ld_cse;
  wire [15:0] V_static_init_else_mux_1_cse;
  reg [15:0] V_sva;
  reg mgc_0_1_dfmergedata_lpi_1_dfm_12;
  reg if_2_land_42_lpi_1_dfm;
  wire [15:0] V_sva_dfm_mx0w0;
  wire [16:0] nl_V_sva_dfm_mx0w0;
  wire if_2_land_42_lpi_1_dfm_mx0;
  wire mgc_0_1_dfmergedata_lpi_1_dfm_12_mx0;
  wire [14:0] V_sva_dfm_mx3_15_1;
  wire xor_cse;
  wire and_18_cse;
  wire and_49_cse;
  wire operator_16_false_6_acc_1_itm_16_1;
  wire operator_16_false_4_acc_1_itm_16_1;
  wire operator_16_false_1_acc_1_itm_16_1;
  wire operator_16_false_5_acc_1_itm_15_1;
  wire operator_16_false_2_acc_1_itm_15_1;
  wire operator_16_false_7_acc_1_itm_11_1;
  wire operator_16_false_3_acc_1_itm_13_1;
  wire operator_16_false_acc_1_itm_16_1;
  wire operator_16_false_27_acc_1_itm_13_1;
  wire operator_16_false_1_acc_1_itm_14_1;
  wire operator_16_false_4_acc_1_itm_16_1_1;
  wire operator_16_false_3_acc_1_itm_16_1;
  wire operator_16_false_8_acc_1_itm_15_1;
  wire operator_16_false_5_acc_1_itm_15_1_1;
  wire operator_16_false_12_acc_1_itm_16_1;

  wire[15:0] if_acc_nl;
  wire[16:0] nl_if_acc_nl;
  wire if_2_if_14_if_2_if_14_and_1_nl;
  wire if_2_if_2_or_12_nl;
  wire[16:0] operator_16_false_acc_nl;
  wire[17:0] nl_operator_16_false_acc_nl;
  wire[16:0] operator_16_false_7_acc_nl;
  wire[17:0] nl_operator_16_false_7_acc_nl;
  wire[15:0] operator_16_false_15_acc_nl;
  wire[16:0] nl_operator_16_false_15_acc_nl;
  wire[14:0] operator_16_false_17_acc_nl;
  wire[15:0] nl_operator_16_false_17_acc_nl;
  wire[16:0] operator_16_false_8_acc_nl;
  wire[17:0] nl_operator_16_false_8_acc_nl;
  wire[15:0] operator_16_false_19_acc_nl;
  wire[16:0] nl_operator_16_false_19_acc_nl;
  wire[15:0] operator_16_false_9_acc_nl;
  wire[16:0] nl_operator_16_false_9_acc_nl;
  wire[15:0] operator_16_false_21_acc_nl;
  wire[16:0] nl_operator_16_false_21_acc_nl;
  wire[16:0] operator_16_false_10_acc_nl;
  wire[17:0] nl_operator_16_false_10_acc_nl;
  wire[14:0] operator_16_false_23_acc_nl;
  wire[15:0] nl_operator_16_false_23_acc_nl;
  wire[16:0] operator_16_false_11_acc_nl;
  wire[17:0] nl_operator_16_false_11_acc_nl;
  wire[14:0] operator_16_false_25_acc_nl;
  wire[15:0] nl_operator_16_false_25_acc_nl;
  wire[15:0] operator_16_false_12_acc_nl;
  wire[16:0] nl_operator_16_false_12_acc_nl;
  wire[15:0] and_2_nl;
  wire[16:0] operator_16_false_6_acc_1_nl;
  wire[17:0] nl_operator_16_false_6_acc_1_nl;
  wire[16:0] operator_16_false_4_acc_1_nl;
  wire[17:0] nl_operator_16_false_4_acc_1_nl;
  wire[16:0] operator_16_false_1_acc_1_nl;
  wire[17:0] nl_operator_16_false_1_acc_1_nl;
  wire[15:0] operator_16_false_5_acc_1_nl;
  wire[16:0] nl_operator_16_false_5_acc_1_nl;
  wire[15:0] operator_16_false_2_acc_1_nl;
  wire[16:0] nl_operator_16_false_2_acc_1_nl;
  wire[11:0] operator_16_false_7_acc_1_nl;
  wire[12:0] nl_operator_16_false_7_acc_1_nl;
  wire[13:0] operator_16_false_3_acc_1_nl;
  wire[14:0] nl_operator_16_false_3_acc_1_nl;
  wire[16:0] operator_16_false_acc_1_nl;
  wire[17:0] nl_operator_16_false_acc_1_nl;
  wire[13:0] operator_16_false_27_acc_1_nl;
  wire[14:0] nl_operator_16_false_27_acc_1_nl;
  wire[14:0] operator_16_false_1_acc_1_nl_1;
  wire[15:0] nl_operator_16_false_1_acc_1_nl_1;
  wire[16:0] operator_16_false_4_acc_1_nl_1;
  wire[17:0] nl_operator_16_false_4_acc_1_nl_1;
  wire[16:0] operator_16_false_3_acc_1_nl_1;
  wire[17:0] nl_operator_16_false_3_acc_1_nl_1;
  wire[15:0] operator_16_false_8_acc_1_nl;
  wire[16:0] nl_operator_16_false_8_acc_1_nl;
  wire[15:0] operator_16_false_5_acc_1_nl_1;
  wire[16:0] nl_operator_16_false_5_acc_1_nl_1;
  wire[16:0] operator_16_false_12_acc_1_nl;
  wire[17:0] nl_operator_16_false_12_acc_1_nl;

  // Interconnect Declarations for Component Instantiations 
  ccs_out_v1 #(.rscid(32'sd1),
  .width(32'sd1)) is_random_rsci (
      .idat(is_random_rsci_idat),
      .dat(is_random_rsc_dat)
    );
  ccs_out_v1 #(.rscid(32'sd2),
  .width(32'sd1)) valid_rsci (
      .idat(valid_rsci_idat),
      .dat(valid_rsc_dat)
    );
  ccs_in_v1 #(.rscid(32'sd3),
  .width(32'sd1)) epsilon_rsci (
      .dat(epsilon_rsc_dat),
      .idat(epsilon_rsci_idat)
    );
  mgc_io_sync_v2 #(.valid(32'sd0)) is_random_triosy_obj (
      .ld(reg_epsilon_triosy_obj_ld_cse),
      .lz(is_random_triosy_lz)
    );
  mgc_io_sync_v2 #(.valid(32'sd0)) valid_triosy_obj (
      .ld(reg_epsilon_triosy_obj_ld_cse),
      .lz(valid_triosy_lz)
    );
  mgc_io_sync_v2 #(.valid(32'sd0)) epsilon_triosy_obj (
      .ld(reg_epsilon_triosy_obj_ld_cse),
      .lz(epsilon_triosy_lz)
    );
  assign and_18_cse = (n_sva==16'b1111111111111111);
  assign and_49_cse = ((acc_tmp!=16'b1111111111111111)) & (n_sva==16'b1111111111111111);
  assign nl_V_sva_dfm_mx0w0 = V_sva + 16'b0000000000000001;
  assign V_sva_dfm_mx0w0 = nl_V_sva_dfm_mx0w0[15:0];
  assign V_static_init_else_mux_1_cse = MUX_v_16_2_2(V_sva_dfm_mx0w0, V_sva, or_dcpl_15);
  assign V_sva_dfm_mx3_15_1 = MUX_v_15_2_2((V_sva_dfm_mx0w0[15:1]), (V_sva[15:1]),
      or_dcpl_15);
  assign nl_if_acc_nl = S_sva + 16'b0000000000000001;
  assign if_acc_nl = nl_if_acc_nl[15:0];
  assign S_sva_dfm_mx0 = MUX_v_16_2_2(S_sva, if_acc_nl, epsilon_rsci_idat);
  assign if_2_if_14_if_2_if_14_and_1_nl = (~ operator_16_false_27_acc_1_itm_13_1)
      & (~ operator_16_false_acc_1_itm_16_1) & (S_sva_dfm_mx0==16'b1000000101001010);
  assign if_2_land_42_lpi_1_dfm_mx0 = MUX_s_1_2_2(if_2_if_14_if_2_if_14_and_1_nl,
      if_2_land_42_lpi_1_dfm, or_dcpl_30);
  assign nl_operator_16_false_acc_nl = ({1'b1 , (~ S_sva_dfm_mx0)}) + 17'b00111111010110111;
  assign operator_16_false_acc_nl = nl_operator_16_false_acc_nl[16:0];
  assign nl_operator_16_false_7_acc_nl = conv_u2s_16_17(V_static_init_else_mux_1_cse)
      + 17'b11000000101001001;
  assign operator_16_false_7_acc_nl = nl_operator_16_false_7_acc_nl[16:0];
  assign nl_operator_16_false_15_acc_nl = conv_u2s_15_16(~ (S_sva_dfm_mx0[14:0]))
      + 16'b1000000010010011;
  assign operator_16_false_15_acc_nl = nl_operator_16_false_15_acc_nl[15:0];
  assign nl_operator_16_false_17_acc_nl = conv_u2s_14_15(~ (S_sva_dfm_mx0[14:1]))
      + 15'b100000001100111;
  assign operator_16_false_17_acc_nl = nl_operator_16_false_17_acc_nl[14:0];
  assign nl_operator_16_false_8_acc_nl = ({1'b1 , (~ S_sva_dfm_mx0)}) + 17'b01000000010010011;
  assign operator_16_false_8_acc_nl = nl_operator_16_false_8_acc_nl[16:0];
  assign nl_operator_16_false_19_acc_nl = conv_u2s_15_16(~ (S_sva_dfm_mx0[14:0]))
      + 16'b1000000011101001;
  assign operator_16_false_19_acc_nl = nl_operator_16_false_19_acc_nl[15:0];
  assign nl_operator_16_false_9_acc_nl = ({1'b1 , (~ (S_sva_dfm_mx0[15:1]))}) + 16'b0100000001100111;
  assign operator_16_false_9_acc_nl = nl_operator_16_false_9_acc_nl[15:0];
  assign nl_operator_16_false_21_acc_nl = conv_u2s_15_16(~ (S_sva_dfm_mx0[14:0]))
      + 16'b1000000100010011;
  assign operator_16_false_21_acc_nl = nl_operator_16_false_21_acc_nl[15:0];
  assign nl_operator_16_false_10_acc_nl = ({1'b1 , (~ S_sva_dfm_mx0)}) + 17'b01000000011101001;
  assign operator_16_false_10_acc_nl = nl_operator_16_false_10_acc_nl[16:0];
  assign nl_operator_16_false_23_acc_nl = conv_u2s_14_15(~ (S_sva_dfm_mx0[14:1]))
      + 15'b100000010010011;
  assign operator_16_false_23_acc_nl = nl_operator_16_false_23_acc_nl[14:0];
  assign nl_operator_16_false_11_acc_nl = ({1'b1 , (~ S_sva_dfm_mx0)}) + 17'b01000000100010011;
  assign operator_16_false_11_acc_nl = nl_operator_16_false_11_acc_nl[16:0];
  assign nl_operator_16_false_25_acc_nl = conv_u2s_14_15(~ (S_sva_dfm_mx0[14:1]))
      + 15'b100000010100101;
  assign operator_16_false_25_acc_nl = nl_operator_16_false_25_acc_nl[14:0];
  assign nl_operator_16_false_12_acc_nl = ({1'b1 , (~ (S_sva_dfm_mx0[15:1]))}) +
      16'b0100000010010011;
  assign operator_16_false_12_acc_nl = nl_operator_16_false_12_acc_nl[15:0];
  assign if_2_if_2_or_12_nl = ((~ operator_16_false_27_acc_1_itm_13_1) & (~ operator_16_false_acc_1_itm_16_1)
      & (S_sva_dfm_mx0==16'b0111111010110110)) | (~(operator_16_false_27_acc_1_itm_13_1
      | operator_16_false_1_acc_1_itm_14_1 | operator_16_false_1_acc_1_itm_16_1 |
      (~ (readslicef_17_1_16(operator_16_false_acc_nl))))) | (~(operator_16_false_4_acc_1_itm_16_1_1
      | operator_16_false_1_acc_1_itm_14_1 | operator_16_false_2_acc_1_itm_15_1 |
      (~ operator_16_false_1_acc_1_itm_16_1))) | (~(operator_16_false_4_acc_1_itm_16_1_1
      | operator_16_false_3_acc_1_itm_16_1 | operator_16_false_3_acc_1_itm_13_1 |
      (~ operator_16_false_2_acc_1_itm_15_1))) | (~(operator_16_false_8_acc_1_itm_15_1
      | operator_16_false_3_acc_1_itm_16_1 | operator_16_false_4_acc_1_itm_16_1 |
      (~ operator_16_false_3_acc_1_itm_13_1))) | (~(operator_16_false_8_acc_1_itm_15_1
      | operator_16_false_5_acc_1_itm_15_1_1 | operator_16_false_5_acc_1_itm_15_1
      | (~ operator_16_false_4_acc_1_itm_16_1))) | (~(operator_16_false_12_acc_1_itm_16_1
      | operator_16_false_5_acc_1_itm_15_1_1 | operator_16_false_6_acc_1_itm_16_1
      | (~ operator_16_false_5_acc_1_itm_15_1))) | (~(operator_16_false_12_acc_1_itm_16_1
      | (readslicef_17_1_16(operator_16_false_7_acc_nl)) | operator_16_false_7_acc_1_itm_11_1
      | (~ operator_16_false_6_acc_1_itm_16_1))) | (~(operator_16_false_12_acc_1_itm_16_1
      | operator_16_false_5_acc_1_itm_15_1_1 | (readslicef_16_1_15(operator_16_false_15_acc_nl))
      | (~ operator_16_false_7_acc_1_itm_11_1))) | (~(operator_16_false_8_acc_1_itm_15_1
      | operator_16_false_5_acc_1_itm_15_1_1 | (readslicef_15_1_14(operator_16_false_17_acc_nl))
      | (~ (readslicef_17_1_16(operator_16_false_8_acc_nl))))) | (~(operator_16_false_8_acc_1_itm_15_1
      | operator_16_false_3_acc_1_itm_16_1 | (readslicef_16_1_15(operator_16_false_19_acc_nl))
      | (~ (readslicef_16_1_15(operator_16_false_9_acc_nl))))) | (~(operator_16_false_4_acc_1_itm_16_1_1
      | operator_16_false_3_acc_1_itm_16_1 | (readslicef_16_1_15(operator_16_false_21_acc_nl))
      | (~ (readslicef_17_1_16(operator_16_false_10_acc_nl))))) | (~(operator_16_false_4_acc_1_itm_16_1_1
      | operator_16_false_1_acc_1_itm_14_1 | (readslicef_15_1_14(operator_16_false_23_acc_nl))
      | (~ (readslicef_17_1_16(operator_16_false_11_acc_nl))))) | (~(operator_16_false_27_acc_1_itm_13_1
      | operator_16_false_1_acc_1_itm_14_1 | (readslicef_15_1_14(operator_16_false_25_acc_nl))
      | (~ (readslicef_16_1_15(operator_16_false_12_acc_nl)))));
  assign mgc_0_1_dfmergedata_lpi_1_dfm_12_mx0 = MUX_s_1_2_2(if_2_if_2_or_12_nl, mgc_0_1_dfmergedata_lpi_1_dfm_12,
      or_dcpl_30);
  assign unequal_tmp_1 = ~((n_sva==16'b1111111111111111));
  assign and_2_nl = MUX_v_16_2_2(16'b0000000000000000, n_sva, unequal_tmp_1);
  assign nl_acc_tmp = and_2_nl + 16'b0000000000000001;
  assign acc_tmp = nl_acc_tmp[15:0];
  assign nl_operator_16_false_6_acc_1_nl = ({1'b1 , (~ S_sva_dfm_mx0)}) + 17'b00111111110100001;
  assign operator_16_false_6_acc_1_nl = nl_operator_16_false_6_acc_1_nl[16:0];
  assign operator_16_false_6_acc_1_itm_16_1 = readslicef_17_1_16(operator_16_false_6_acc_1_nl);
  assign nl_operator_16_false_4_acc_1_nl = ({1'b1 , (~ S_sva_dfm_mx0)}) + 17'b00111111100110011;
  assign operator_16_false_4_acc_1_nl = nl_operator_16_false_4_acc_1_nl[16:0];
  assign operator_16_false_4_acc_1_itm_16_1 = readslicef_17_1_16(operator_16_false_4_acc_1_nl);
  assign nl_operator_16_false_1_acc_1_nl = ({1'b1 , (~ S_sva_dfm_mx0)}) + 17'b00111111011011011;
  assign operator_16_false_1_acc_1_nl = nl_operator_16_false_1_acc_1_nl[16:0];
  assign operator_16_false_1_acc_1_itm_16_1 = readslicef_17_1_16(operator_16_false_1_acc_1_nl);
  assign nl_operator_16_false_5_acc_1_nl = ({1'b1 , (~ (S_sva_dfm_mx0[15:1]))}) +
      16'b0011111110110111;
  assign operator_16_false_5_acc_1_nl = nl_operator_16_false_5_acc_1_nl[15:0];
  assign operator_16_false_5_acc_1_itm_15_1 = readslicef_16_1_15(operator_16_false_5_acc_1_nl);
  assign nl_operator_16_false_2_acc_1_nl = ({1'b1 , (~ (S_sva_dfm_mx0[15:1]))}) +
      16'b0011111101110111;
  assign operator_16_false_2_acc_1_nl = nl_operator_16_false_2_acc_1_nl[15:0];
  assign operator_16_false_2_acc_1_itm_15_1 = readslicef_16_1_15(operator_16_false_2_acc_1_nl);
  assign nl_operator_16_false_7_acc_1_nl = ({1'b1 , (~ (S_sva_dfm_mx0[15:5]))}) +
      12'b010000000011;
  assign operator_16_false_7_acc_1_nl = nl_operator_16_false_7_acc_1_nl[11:0];
  assign operator_16_false_7_acc_1_itm_11_1 = readslicef_12_1_11(operator_16_false_7_acc_1_nl);
  assign nl_operator_16_false_3_acc_1_nl = ({1'b1 , (~ (S_sva_dfm_mx0[15:3]))}) +
      14'b00111111100011;
  assign operator_16_false_3_acc_1_nl = nl_operator_16_false_3_acc_1_nl[13:0];
  assign operator_16_false_3_acc_1_itm_13_1 = readslicef_14_1_13(operator_16_false_3_acc_1_nl);
  assign nl_operator_16_false_acc_1_nl = conv_u2s_16_17(V_static_init_else_mux_1_cse)
      + 17'b11000000101001101;
  assign operator_16_false_acc_1_nl = nl_operator_16_false_acc_1_nl[16:0];
  assign operator_16_false_acc_1_itm_16_1 = readslicef_17_1_16(operator_16_false_acc_1_nl);
  assign nl_operator_16_false_27_acc_1_nl = ({1'b1 , (~ (V_static_init_else_mux_1_cse[15:3]))})
      + 14'b01000000101001;
  assign operator_16_false_27_acc_1_nl = nl_operator_16_false_27_acc_1_nl[13:0];
  assign operator_16_false_27_acc_1_itm_13_1 = readslicef_14_1_13(operator_16_false_27_acc_1_nl);
  assign nl_operator_16_false_1_acc_1_nl_1 = conv_u2u_14_15(V_static_init_else_mux_1_cse[15:2])
      + 15'b110000001010011;
  assign operator_16_false_1_acc_1_nl_1 = nl_operator_16_false_1_acc_1_nl_1[14:0];
  assign operator_16_false_1_acc_1_itm_14_1 = readslicef_15_1_14(operator_16_false_1_acc_1_nl_1);
  assign nl_operator_16_false_4_acc_1_nl_1 = ({1'b1 , (~ V_static_init_else_mux_1_cse)})
      + 17'b01000000101001001;
  assign operator_16_false_4_acc_1_nl_1 = nl_operator_16_false_4_acc_1_nl_1[16:0];
  assign operator_16_false_4_acc_1_itm_16_1_1 = readslicef_17_1_16(operator_16_false_4_acc_1_nl_1);
  assign nl_operator_16_false_3_acc_1_nl_1 = conv_u2s_16_17(V_static_init_else_mux_1_cse)
      + 17'b11000000101001011;
  assign operator_16_false_3_acc_1_nl_1 = nl_operator_16_false_3_acc_1_nl_1[16:0];
  assign operator_16_false_3_acc_1_itm_16_1 = readslicef_17_1_16(operator_16_false_3_acc_1_nl_1);
  assign nl_operator_16_false_8_acc_1_nl = ({1'b1 , (~ V_sva_dfm_mx3_15_1)}) + 16'b0100000010100101;
  assign operator_16_false_8_acc_1_nl = nl_operator_16_false_8_acc_1_nl[15:0];
  assign operator_16_false_8_acc_1_itm_15_1 = readslicef_16_1_15(operator_16_false_8_acc_1_nl);
  assign nl_operator_16_false_5_acc_1_nl_1 = conv_u2u_15_16(V_sva_dfm_mx3_15_1) +
      16'b1100000010100101;
  assign operator_16_false_5_acc_1_nl_1 = nl_operator_16_false_5_acc_1_nl_1[15:0];
  assign operator_16_false_5_acc_1_itm_15_1_1 = readslicef_16_1_15(operator_16_false_5_acc_1_nl_1);
  assign nl_operator_16_false_12_acc_1_nl = ({1'b1 , (~ V_static_init_else_mux_1_cse)})
      + 17'b01000000101001011;
  assign operator_16_false_12_acc_1_nl = nl_operator_16_false_12_acc_1_nl[16:0];
  assign operator_16_false_12_acc_1_itm_16_1 = readslicef_17_1_16(operator_16_false_12_acc_1_nl);
  assign xor_cse = prev_0_sva ^ epsilon_rsci_idat;
  assign or_dcpl_15 = ~(xor_cse & reg_epsilon_triosy_obj_ld_cse);
  assign or_dcpl_30 = (n_sva!=16'b1111111111111111);
  always @(posedge clk) begin
    if ( ~ rst_n ) begin
      V_sva <= 16'b0000000000000000;
    end
    else if ( and_18_cse | (xor_cse & reg_epsilon_triosy_obj_ld_cse) ) begin
      V_sva <= MUX_v_16_2_2(16'b0000000000000000, V_static_init_else_mux_1_cse, unequal_tmp_1);
    end
  end
  always @(posedge clk) begin
    if ( ~ rst_n ) begin
      S_sva <= 16'b0000000000000000;
    end
    else if ( and_18_cse | epsilon_rsci_idat ) begin
      S_sva <= MUX_v_16_2_2(16'b0000000000000000, S_sva_dfm_mx0, unequal_tmp_1);
    end
  end
  always @(posedge clk) begin
    if ( ~ rst_n ) begin
      if_2_land_42_lpi_1_dfm <= 1'b0;
      mgc_0_1_dfmergedata_lpi_1_dfm_12 <= 1'b0;
    end
    else if ( and_49_cse ) begin
      if_2_land_42_lpi_1_dfm <= if_2_land_42_lpi_1_dfm_mx0;
      mgc_0_1_dfmergedata_lpi_1_dfm_12 <= mgc_0_1_dfmergedata_lpi_1_dfm_12_mx0;
    end
  end
  always @(posedge clk) begin
    if ( ~ rst_n ) begin
      reg_epsilon_triosy_obj_ld_cse <= 1'b0;
      valid_rsci_idat <= 1'b0;
      is_random_rsci_idat <= 1'b0;
      n_sva <= 16'b0000000000000000;
      prev_0_sva <= 1'b1;
    end
    else begin
      reg_epsilon_triosy_obj_ld_cse <= 1'b1;
      valid_rsci_idat <= ~ unequal_tmp_1;
      is_random_rsci_idat <= ~((~(mgc_0_1_dfmergedata_lpi_1_dfm_12_mx0 | if_2_land_42_lpi_1_dfm_mx0))
          | unequal_tmp_1);
      n_sva <= acc_tmp;
      prev_0_sva <= epsilon_rsci_idat;
    end
  end

  function automatic  MUX_s_1_2_2;
    input  input_0;
    input  input_1;
    input  sel;
    reg  result;
  begin
    case (sel)
      1'b0 : begin
        result = input_0;
      end
      default : begin
        result = input_1;
      end
    endcase
    MUX_s_1_2_2 = result;
  end
  endfunction


  function automatic [14:0] MUX_v_15_2_2;
    input [14:0] input_0;
    input [14:0] input_1;
    input  sel;
    reg [14:0] result;
  begin
    case (sel)
      1'b0 : begin
        result = input_0;
      end
      default : begin
        result = input_1;
      end
    endcase
    MUX_v_15_2_2 = result;
  end
  endfunction


  function automatic [15:0] MUX_v_16_2_2;
    input [15:0] input_0;
    input [15:0] input_1;
    input  sel;
    reg [15:0] result;
  begin
    case (sel)
      1'b0 : begin
        result = input_0;
      end
      default : begin
        result = input_1;
      end
    endcase
    MUX_v_16_2_2 = result;
  end
  endfunction


  function automatic [0:0] readslicef_12_1_11;
    input [11:0] vector;
    reg [11:0] tmp;
  begin
    tmp = vector >> 11;
    readslicef_12_1_11 = tmp[0:0];
  end
  endfunction


  function automatic [0:0] readslicef_14_1_13;
    input [13:0] vector;
    reg [13:0] tmp;
  begin
    tmp = vector >> 13;
    readslicef_14_1_13 = tmp[0:0];
  end
  endfunction


  function automatic [0:0] readslicef_15_1_14;
    input [14:0] vector;
    reg [14:0] tmp;
  begin
    tmp = vector >> 14;
    readslicef_15_1_14 = tmp[0:0];
  end
  endfunction


  function automatic [0:0] readslicef_16_1_15;
    input [15:0] vector;
    reg [15:0] tmp;
  begin
    tmp = vector >> 15;
    readslicef_16_1_15 = tmp[0:0];
  end
  endfunction


  function automatic [0:0] readslicef_17_1_16;
    input [16:0] vector;
    reg [16:0] tmp;
  begin
    tmp = vector >> 16;
    readslicef_17_1_16 = tmp[0:0];
  end
  endfunction


  function automatic [14:0] conv_u2s_14_15 ;
    input [13:0]  vector ;
  begin
    conv_u2s_14_15 =  {1'b0, vector};
  end
  endfunction


  function automatic [15:0] conv_u2s_15_16 ;
    input [14:0]  vector ;
  begin
    conv_u2s_15_16 =  {1'b0, vector};
  end
  endfunction


  function automatic [16:0] conv_u2s_16_17 ;
    input [15:0]  vector ;
  begin
    conv_u2s_16_17 =  {1'b0, vector};
  end
  endfunction


  function automatic [14:0] conv_u2u_14_15 ;
    input [13:0]  vector ;
  begin
    conv_u2u_14_15 = {1'b0, vector};
  end
  endfunction


  function automatic [15:0] conv_u2u_15_16 ;
    input [14:0]  vector ;
  begin
    conv_u2u_15_16 = {1'b0, vector};
  end
  endfunction

endmodule

// ------------------------------------------------------------------
//  Design Unit:    runs
// ------------------------------------------------------------------


module runs (
  clk, rst_n, is_random_rsc_dat, is_random_triosy_lz, valid_rsc_dat, valid_triosy_lz,
      epsilon_rsc_dat, epsilon_triosy_lz
);
  input clk;
  input rst_n;
  output is_random_rsc_dat;
  output is_random_triosy_lz;
  output valid_rsc_dat;
  output valid_triosy_lz;
  input epsilon_rsc_dat;
  output epsilon_triosy_lz;



  // Interconnect Declarations for Component Instantiations 
  runs_core runs_core_inst (
      .clk(clk),
      .rst_n(rst_n),
      .is_random_rsc_dat(is_random_rsc_dat),
      .is_random_triosy_lz(is_random_triosy_lz),
      .valid_rsc_dat(valid_rsc_dat),
      .valid_triosy_lz(valid_triosy_lz),
      .epsilon_rsc_dat(epsilon_rsc_dat),
      .epsilon_triosy_lz(epsilon_triosy_lz)
    );
endmodule



//------> ./rtl.v 
// ----------------------------------------------------------------------
//  HLS HDL:        Verilog Netlister
//  HLS Version:    2023.1_2/1049935 Production Release
//  HLS Date:       Sat Jun 10 10:53:51 PDT 2023
// 
//  Generated by:   lc4976@hansolo.poly.edu
//  Generated date: Tue Mar 19 17:06:52 2024
// ----------------------------------------------------------------------

// 
// ------------------------------------------------------------------
//  Design Unit:    monobit_block_core
// ------------------------------------------------------------------


module monobit_block_core (
  clk, rst_n, is_random_rsc_dat, is_random_triosy_lz, valid_rsc_dat, valid_triosy_lz,
      epsilon_rsc_dat, epsilon_triosy_lz
);
  input clk;
  input rst_n;
  output is_random_rsc_dat;
  output is_random_triosy_lz;
  output valid_rsc_dat;
  output valid_triosy_lz;
  input epsilon_rsc_dat;
  output epsilon_triosy_lz;


  // Interconnect Declarations
  reg is_random_rsci_idat;
  reg valid_rsci_idat;
  wire epsilon_rsci_idat;
  reg [9:0] bit_count_sva;
  wire [10:0] nl_bit_count_sva;
  reg reg_epsilon_triosy_obj_ld_cse;
  reg [19:0] sum_sva;
  reg [7:0] blockSum_19_12_sva;
  wire [7:0] blockSum_19_12_sva_2;
  wire [8:0] nl_blockSum_19_12_sva_2;
  wire [19:0] asn_24;
  wire [20:0] nl_asn_24;
  wire unequal_tmp_2;
  wire [2:0] v_conc_3_8_6;
  wire [3:0] nl_v_conc_3_8_6;

  wire[18:0] if_1_acc_nl;
  wire[19:0] nl_if_1_acc_nl;
  wire nand_nl;
  wire[16:0] if_if_mul_nl;
  wire signed [17:0] nl_if_if_mul_nl;

  // Interconnect Declarations for Component Instantiations 
  ccs_out_v1 #(.rscid(32'sd1),
  .width(32'sd1)) is_random_rsci (
      .idat(is_random_rsci_idat),
      .dat(is_random_rsc_dat)
    );
  ccs_out_v1 #(.rscid(32'sd2),
  .width(32'sd1)) valid_rsci (
      .idat(valid_rsci_idat),
      .dat(valid_rsc_dat)
    );
  ccs_in_v1 #(.rscid(32'sd3),
  .width(32'sd1)) epsilon_rsci (
      .dat(epsilon_rsc_dat),
      .idat(epsilon_rsci_idat)
    );
  mgc_io_sync_v2 #(.valid(32'sd0)) is_random_triosy_obj (
      .ld(reg_epsilon_triosy_obj_ld_cse),
      .lz(is_random_triosy_lz)
    );
  mgc_io_sync_v2 #(.valid(32'sd0)) valid_triosy_obj (
      .ld(reg_epsilon_triosy_obj_ld_cse),
      .lz(valid_triosy_lz)
    );
  mgc_io_sync_v2 #(.valid(32'sd0)) epsilon_triosy_obj (
      .ld(reg_epsilon_triosy_obj_ld_cse),
      .lz(epsilon_triosy_lz)
    );
  assign nl_blockSum_19_12_sva_2 = blockSum_19_12_sva + conv_u2u_1_8(epsilon_rsci_idat);
  assign blockSum_19_12_sva_2 = nl_blockSum_19_12_sva_2[7:0];
  assign nl_if_if_mul_nl = $signed(({v_conc_3_8_6 , (blockSum_19_12_sva_2[5:0])}))
      * $signed(({v_conc_3_8_6 , (blockSum_19_12_sva_2[5:0])}));
  assign if_if_mul_nl = nl_if_if_mul_nl[16:0];
  assign nl_asn_24 = sum_sva + conv_s2s_15_20(readslicef_17_15_2(if_if_mul_nl));
  assign asn_24 = nl_asn_24[19:0];
  assign unequal_tmp_2 = ~((bit_count_sva==10'b1111111111));
  assign nl_v_conc_3_8_6 = conv_s2s_2_3(blockSum_19_12_sva_2[7:6]) + 3'b111;
  assign v_conc_3_8_6 = nl_v_conc_3_8_6[2:0];
  always @(posedge clk) begin
    if ( ~ rst_n ) begin
      sum_sva <= 20'b00000000000000000000;
    end
    else if ( (bit_count_sva[6:0]==7'b1111111) ) begin
      sum_sva <= MUX_v_20_2_2(20'b00000000000000000000, asn_24, unequal_tmp_2);
    end
  end
  always @(posedge clk) begin
    if ( ~ rst_n ) begin
      reg_epsilon_triosy_obj_ld_cse <= 1'b0;
      valid_rsci_idat <= 1'b0;
      is_random_rsci_idat <= 1'b0;
      bit_count_sva <= 10'b0000000000;
      blockSum_19_12_sva <= 8'b00000000;
    end
    else begin
      reg_epsilon_triosy_obj_ld_cse <= 1'b1;
      valid_rsci_idat <= ~ unequal_tmp_2;
      is_random_rsci_idat <= (readslicef_19_1_18(if_1_acc_nl)) & (~ unequal_tmp_2);
      bit_count_sva <= nl_bit_count_sva[9:0];
      blockSum_19_12_sva <= MUX_v_8_2_2(8'b00000000, blockSum_19_12_sva_2, nand_nl);
    end
  end
  assign nl_if_1_acc_nl = conv_s2u_18_19(asn_24[19:2]) + 19'b1111111111111011001;
  assign if_1_acc_nl = nl_if_1_acc_nl[18:0];
  assign nl_bit_count_sva  = bit_count_sva + 10'b0000000001;
  assign nand_nl = ~((bit_count_sva[6:0]==7'b1111111));

  function automatic [19:0] MUX_v_20_2_2;
    input [19:0] input_0;
    input [19:0] input_1;
    input  sel;
    reg [19:0] result;
  begin
    case (sel)
      1'b0 : begin
        result = input_0;
      end
      default : begin
        result = input_1;
      end
    endcase
    MUX_v_20_2_2 = result;
  end
  endfunction


  function automatic [7:0] MUX_v_8_2_2;
    input [7:0] input_0;
    input [7:0] input_1;
    input  sel;
    reg [7:0] result;
  begin
    case (sel)
      1'b0 : begin
        result = input_0;
      end
      default : begin
        result = input_1;
      end
    endcase
    MUX_v_8_2_2 = result;
  end
  endfunction


  function automatic [14:0] readslicef_17_15_2;
    input [16:0] vector;
    reg [16:0] tmp;
  begin
    tmp = vector >> 2;
    readslicef_17_15_2 = tmp[14:0];
  end
  endfunction


  function automatic [0:0] readslicef_19_1_18;
    input [18:0] vector;
    reg [18:0] tmp;
  begin
    tmp = vector >> 18;
    readslicef_19_1_18 = tmp[0:0];
  end
  endfunction


  function automatic [2:0] conv_s2s_2_3 ;
    input [1:0]  vector ;
  begin
    conv_s2s_2_3 = {vector[1], vector};
  end
  endfunction


  function automatic [19:0] conv_s2s_15_20 ;
    input [14:0]  vector ;
  begin
    conv_s2s_15_20 = {{5{vector[14]}}, vector};
  end
  endfunction


  function automatic [18:0] conv_s2u_18_19 ;
    input [17:0]  vector ;
  begin
    conv_s2u_18_19 = {vector[17], vector};
  end
  endfunction


  function automatic [7:0] conv_u2u_1_8 ;
    input [0:0]  vector ;
  begin
    conv_u2u_1_8 = {{7{1'b0}}, vector};
  end
  endfunction

endmodule

// ------------------------------------------------------------------
//  Design Unit:    monobit_block
// ------------------------------------------------------------------


module monobit_block (
  clk, rst_n, is_random_rsc_dat, is_random_triosy_lz, valid_rsc_dat, valid_triosy_lz,
      epsilon_rsc_dat, epsilon_triosy_lz
);
  input clk;
  input rst_n;
  output is_random_rsc_dat;
  output is_random_triosy_lz;
  output valid_rsc_dat;
  output valid_triosy_lz;
  input epsilon_rsc_dat;
  output epsilon_triosy_lz;



  // Interconnect Declarations for Component Instantiations 
  monobit_block_core monobit_block_core_inst (
      .clk(clk),
      .rst_n(rst_n),
      .is_random_rsc_dat(is_random_rsc_dat),
      .is_random_triosy_lz(is_random_triosy_lz),
      .valid_rsc_dat(valid_rsc_dat),
      .valid_triosy_lz(valid_triosy_lz),
      .epsilon_rsc_dat(epsilon_rsc_dat),
      .epsilon_triosy_lz(epsilon_triosy_lz)
    );
endmodule



