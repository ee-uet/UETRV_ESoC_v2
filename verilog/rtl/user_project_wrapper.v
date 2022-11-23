// SPDX-FileCopyrightText: 2020 Efabless Corporation
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//      http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
// SPDX-License-Identifier: Apache-2.0

`default_nettype none
/*
 *-------------------------------------------------------------
 *
 * user_project_wrapper
 *
 * This wrapper enumerates all of the pins available to the
 * user for the user project.
 *
 * An example user project is provided in this wrapper.  The
 * example should be removed and replaced with the actual
 * user project.
 *
 *-------------------------------------------------------------
 */

module user_project_wrapper #(
    parameter BITS = 32
) (
`ifdef USE_POWER_PINS
    inout vdda1,	// User area 1 3.3V supply
    inout vdda2,	// User area 2 3.3V supply
    inout vssa1,	// User area 1 analog ground
    inout vssa2,	// User area 2 analog ground
    inout vccd1,	// User area 1 1.8V supply
    inout vccd2,	// User area 2 1.8v supply
    inout vssd1,	// User area 1 digital ground
    inout vssd2,	// User area 2 digital ground
`endif

    // Wishbone Slave ports (WB MI A)
    input wb_clk_i,
    input wb_rst_i,
    input wbs_stb_i,
    input wbs_cyc_i,
    input wbs_we_i,
    input [3:0] wbs_sel_i,
    input [31:0] wbs_dat_i,
    input [31:0] wbs_adr_i,
    output wbs_ack_o,
    output [31:0] wbs_dat_o,

    // Logic Analyzer Signals
    input  [127:0] la_data_in,
    output [127:0] la_data_out,
    input  [127:0] la_oenb,

    // IOs
    input  [`MPRJ_IO_PADS-1:0] io_in,
    output [`MPRJ_IO_PADS-1:0] io_out,
    output [`MPRJ_IO_PADS-1:0] io_oeb,

    // Analog (direct connection to GPIO pad---use with caution)
    // Note that analog I/O is not available on the 7 lowest-numbered
    // GPIO pads, and so the analog_io indexing is offset from the
    // GPIO indexing by 7 (also upper 2 GPIOs do not have analog_io).
    inout [`MPRJ_IO_PADS-10:0] analog_io,

    // Independent clock (on independent integer divider)
    input   user_clock2,

    // User maskable interrupt signals
    output [2:0] user_irq
);

/*--------------------------------------*/
/* User project is instantiated  here   */
/*--------------------------------------*/

SoC_Tile mprj (
//`ifdef USE_POWER_PINS
//	.VDD(vccd1),	// User area 1 1.8V power
//	.VSS(vssd1),	// User area 1 digital ground
//`endif

    //.wb_clk_i(wb_clk_i),
    //.wb_rst_i(wb_rst_i),

    //// MGMT SoC Wishbone Slave

    //.wbs_cyc_i(wbs_cyc_i),
    //.wbs_stb_i(wbs_stb_i),
    //.wbs_we_i(wbs_we_i),
    //.wbs_sel_i(wbs_sel_i),
    //.wbs_adr_i(wbs_adr_i),
    //.wbs_dat_i(wbs_dat_i),
    //.wbs_ack_o(wbs_ack_o),
    //.wbs_dat_o(wbs_dat_o),

    //// Logic Analyzer

    //.la_data_in(la_data_in),
    //.la_data_out(la_data_out),
    //.la_oenb (la_oenb),

    // IO Pads

    //.io_in (io_in),

    .user_clock         (user_clock2),
    .wb_clock           (wb_clk_i),

    //.io_out(io_out),

    // GPIOs 0 thru 4 are unused because they are
    // required for management core's SPI. When 
    // changing pin assignments here, also update:
    // 1) SoC_Tile verilog to provide reset to 
    //      io_oeb for the outputs only,
    // 2) par.tcl to place pins on appropriate side 
    //      with appropriate spacing
    // 3) user_defines.v
    // 4) io_ports.c
    // 5) io_ports_tb.v

    .clock_sel          ( io_in[ 5]),
    .clk_muxed          (io_out[ 6]),   // debug

    .io_m1_io_qei_ch_a  ( io_in[ 7]),    
    .io_m1_io_qei_ch_b  ( io_in[ 8]),    
    .io_m1_io_pwm_high  (io_out[ 9]),
    .io_m1_io_pwm_low   (io_out[10]),
    .io_m1_io_x_homed   ( io_in[11]),    
    .io_m1_io_y_homed   ( io_in[12]),    
    .io_m1_io_step1dir  (io_out[13]), 
    .io_m1_io_step2dir  (io_out[14]),
    
    .reset              ( io_in[15]),

    .io_m2_io_qei_ch_a  ( io_in[16]),    
    .io_m2_io_qei_ch_b  ( io_in[17]),    
    .io_m2_io_pwm_high  (io_out[18]),
    .io_m2_io_pwm_low   (io_out[19]),
    .io_m2_io_x_homed   ( io_in[20]),    
    .io_m2_io_y_homed   ( io_in[21]),    
    .io_m2_io_step1dir  (io_out[22]), 
    .io_m2_io_step2dir  (io_out[23]),

    .io_spi_mosi        (io_out[24]),
    .io_spi_clk         (io_out[25]),
    .io_spi_cs          (io_out[26]),
    .io_spi_miso        ( io_in[27]),

    .io_uart_rx         ( io_in[28]),
    .io_uart_tx         (io_out[29]),

    .io_m3_io_qei_ch_a  ( io_in[30]),    
    .io_m3_io_qei_ch_b  ( io_in[31]),    
    .io_m3_io_pwm_high  (io_out[32]),
    .io_m3_io_pwm_low   (io_out[33]),
    .io_m3_io_x_homed   ( io_in[34]),    
    .io_m3_io_y_homed   ( io_in[35]),    
    .io_m3_io_step1dir  (io_out[36]), 
    .io_m3_io_step2dir  (io_out[37]),

    .io_oeb(io_oeb)

    //// IRQ
    //.irq(user_irq)
);

endmodule	// user_project_wrapper

`default_nettype wire
