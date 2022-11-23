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

`timescale 1 ns / 1 ps

module io_ports_tb;
	reg clock;
	reg RSTB;
	reg CSB;
	reg power1, power2;
	reg power3, power4;

	wire gpio;
	wire [37:0] mprj_io;

    reg [31:0] loop_count, wdata;
    reg [7:0]  bdata;
    reg [31:0] buffer [0:511];  // buffer for SPI flash memory
    reg [31:0] index, byte_no, bit_index;

    reg clock_sel;
    reg my_reset;
    reg homing_switch_x, homing_switch_y;

    reg io_uart_tx; 
    reg io_uart_rx; 

    reg io_spi_cs, io_spi_clk, io_spi_mosi; 
    reg io_spi_miso; 

    reg io_dir_m1, io_dir_m2;
    reg step1step, step2step;
    reg pen_servo_control;

    reg clk_muxed;

    reg io_m1_io_qei_ch_a,
        io_m1_io_qei_ch_b,
        io_m2_io_qei_ch_a,
        io_m2_io_qei_ch_b,
        io_m3_io_qei_ch_a,
        io_m3_io_qei_ch_b;

    assign mprj_io[ 5] = clock_sel;
    assign mprj_io[ 7] = 0; //io_m1_io_qei_ch_a;
    assign mprj_io[ 8] = 0; //io_m1_io_qei_ch_b;
    assign mprj_io[11] = 0; //io_m1_io_x_homed;
    assign mprj_io[12] = 0; //io_m1_io_y_homed;
    assign mprj_io[15] = my_reset;
    assign mprj_io[16] = 0; //io_m2_io_qei_ch_a;
    assign mprj_io[17] = 0; //io_m2_io_qei_ch_b;
    assign mprj_io[20] = homing_switch_x; //io_m2_io_x_homed;
    assign mprj_io[21] = homing_switch_y; //io_m2_io_y_homed;
    assign mprj_io[27] = io_spi_miso;
    assign mprj_io[28] = io_uart_rx;
    assign mprj_io[30] = 0; //io_m3_io_qei_ch_a;
    assign mprj_io[31] = 0; //io_m3_io_qei_ch_b;
    assign mprj_io[34] = 0; //io_m3_io_x_homed;
    assign mprj_io[35] = 0; //io_m3_io_y_homed;
   
    always@(*)
    begin
        clk_muxed         = mprj_io[ 6];
        pen_servo_control = mprj_io[ 9]; 
        step1step         = mprj_io[19]; 
        io_dir_m1         = mprj_io[22]; 
        io_dir_m2         = mprj_io[23]; 
        io_spi_mosi       = mprj_io[24]; 
        io_spi_clk        = mprj_io[25]; 
        io_spi_cs         = mprj_io[26]; 
        io_uart_tx        = mprj_io[29]; 
        step2step         = mprj_io[33]; 

        clock_sel = 1'b0;
        io_uart_rx = io_uart_tx;    // loopback
        homing_switch_x = 0;    // assume motors are homed
        homing_switch_y = 0;    // assume motors are homed

        //io_m1_io_qei_ch_a = 1'b0;
        //io_m1_io_qei_ch_b = 1'b0;
        //io_m2_io_qei_ch_a = 1'b0;
        //io_m2_io_qei_ch_b = 1'b0;
        //io_m3_io_qei_ch_a = 1'b0;
        //io_m3_io_qei_ch_b = 1'b0;
    end
    

	// External clock is used by default.  Make this artificially fast for the
	// simulation.  Normally this would be a slow clock and the digital PLL
	// would be the fast clock.

	always #12.5 clock <= (clock === 1'b0);

	initial begin
		clock = 0;
	end


	`ifdef ENABLE_SDF
		initial begin
			$sdf_annotate("../../../sdf/user_proj_example.sdf", uut.mprj) ;
			$sdf_annotate("../../../sdf/user_project_wrapper.sdf", uut.mprj.mprj) ;
			$sdf_annotate("../../../mgmt_core_wrapper/sdf/DFFRAM.sdf", uut.soc.DFFRAM_0) ;
			$sdf_annotate("../../../mgmt_core_wrapper/sdf/mgmt_core.sdf", uut.soc.core) ;
			$sdf_annotate("../../../caravel/sdf/housekeeping.sdf", uut.housekeeping) ;
			$sdf_annotate("../../../caravel/sdf/chip_io.sdf", uut.padframe) ;
			$sdf_annotate("../../../caravel/sdf/mprj_logic_high.sdf", uut.mgmt_buffers.mprj_logic_high_inst) ;
			$sdf_annotate("../../../caravel/sdf/mprj2_logic_high.sdf", uut.mgmt_buffers.mprj2_logic_high_inst) ;
			$sdf_annotate("../../../caravel/sdf/mgmt_protect_hv.sdf", uut.mgmt_buffers.powergood_check) ;
			$sdf_annotate("../../../caravel/sdf/mgmt_protect.sdf", uut.mgmt_buffers) ;
			$sdf_annotate("../../../caravel/sdf/caravel_clocking.sdf", uut.clocking) ;
			$sdf_annotate("../../../caravel/sdf/digital_pll.sdf", uut.pll) ;
			$sdf_annotate("../../../caravel/sdf/xres_buf.sdf", uut.rstb_level) ;
			$sdf_annotate("../../../caravel/sdf/user_id_programming.sdf", uut.user_id_value) ;
			$sdf_annotate("../../../caravel/sdf/gpio_control_block.sdf", uut.\gpio_control_bidir_1[0] ) ;
			$sdf_annotate("../../../caravel/sdf/gpio_control_block.sdf", uut.\gpio_control_bidir_1[1] ) ;
			$sdf_annotate("../../../caravel/sdf/gpio_control_block.sdf", uut.\gpio_control_bidir_2[0] ) ;
			$sdf_annotate("../../../caravel/sdf/gpio_control_block.sdf", uut.\gpio_control_bidir_2[1] ) ;
			$sdf_annotate("../../../caravel/sdf/gpio_control_block.sdf", uut.\gpio_control_bidir_2[2] ) ;
			$sdf_annotate("../../../caravel/sdf/gpio_control_block.sdf", uut.\gpio_control_in_1[0] ) ;
			$sdf_annotate("../../../caravel/sdf/gpio_control_block.sdf", uut.\gpio_control_in_1[1] ) ;
			$sdf_annotate("../../../caravel/sdf/gpio_control_block.sdf", uut.\gpio_control_in_1[2] ) ;
			$sdf_annotate("../../../caravel/sdf/gpio_control_block.sdf", uut.\gpio_control_in_1[3] ) ;
			$sdf_annotate("../../../caravel/sdf/gpio_control_block.sdf", uut.\gpio_control_in_1[4] ) ;
			$sdf_annotate("../../../caravel/sdf/gpio_control_block.sdf", uut.\gpio_control_in_1[5] ) ;
			$sdf_annotate("../../../caravel/sdf/gpio_control_block.sdf", uut.\gpio_control_in_1[6] ) ;
			$sdf_annotate("../../../caravel/sdf/gpio_control_block.sdf", uut.\gpio_control_in_1[7] ) ;
			$sdf_annotate("../../../caravel/sdf/gpio_control_block.sdf", uut.\gpio_control_in_1[8] ) ;
			$sdf_annotate("../../../caravel/sdf/gpio_control_block.sdf", uut.\gpio_control_in_1[9] ) ;
			$sdf_annotate("../../../caravel/sdf/gpio_control_block.sdf", uut.\gpio_control_in_1[10] ) ;
			$sdf_annotate("../../../caravel/sdf/gpio_control_block.sdf", uut.\gpio_control_in_1a[0] ) ;
			$sdf_annotate("../../../caravel/sdf/gpio_control_block.sdf", uut.\gpio_control_in_1a[1] ) ;
			$sdf_annotate("../../../caravel/sdf/gpio_control_block.sdf", uut.\gpio_control_in_1a[2] ) ;
			$sdf_annotate("../../../caravel/sdf/gpio_control_block.sdf", uut.\gpio_control_in_1a[3] ) ;
			$sdf_annotate("../../../caravel/sdf/gpio_control_block.sdf", uut.\gpio_control_in_1a[4] ) ;
			$sdf_annotate("../../../caravel/sdf/gpio_control_block.sdf", uut.\gpio_control_in_1a[5] ) ;
			$sdf_annotate("../../../caravel/sdf/gpio_control_block.sdf", uut.\gpio_control_in_2[0] ) ;
			$sdf_annotate("../../../caravel/sdf/gpio_control_block.sdf", uut.\gpio_control_in_2[1] ) ;
			$sdf_annotate("../../../caravel/sdf/gpio_control_block.sdf", uut.\gpio_control_in_2[2] ) ;
			$sdf_annotate("../../../caravel/sdf/gpio_control_block.sdf", uut.\gpio_control_in_2[3] ) ;
			$sdf_annotate("../../../caravel/sdf/gpio_control_block.sdf", uut.\gpio_control_in_2[4] ) ;
			$sdf_annotate("../../../caravel/sdf/gpio_control_block.sdf", uut.\gpio_control_in_2[5] ) ;
			$sdf_annotate("../../../caravel/sdf/gpio_control_block.sdf", uut.\gpio_control_in_2[6] ) ;
			$sdf_annotate("../../../caravel/sdf/gpio_control_block.sdf", uut.\gpio_control_in_2[7] ) ;
			$sdf_annotate("../../../caravel/sdf/gpio_control_block.sdf", uut.\gpio_control_in_2[8] ) ;
			$sdf_annotate("../../../caravel/sdf/gpio_control_block.sdf", uut.\gpio_control_in_2[9] ) ;
			$sdf_annotate("../../../caravel/sdf/gpio_control_block.sdf", uut.\gpio_control_in_2[10] ) ;
			$sdf_annotate("../../../caravel/sdf/gpio_control_block.sdf", uut.\gpio_control_in_2[11] ) ;
			$sdf_annotate("../../../caravel/sdf/gpio_control_block.sdf", uut.\gpio_control_in_2[12] ) ;
			$sdf_annotate("../../../caravel/sdf/gpio_control_block.sdf", uut.\gpio_control_in_2[13] ) ;
			$sdf_annotate("../../../caravel/sdf/gpio_control_block.sdf", uut.\gpio_control_in_2[14] ) ;
			$sdf_annotate("../../../caravel/sdf/gpio_control_block.sdf", uut.\gpio_control_in_2[15] ) ;
			$sdf_annotate("../../../caravel/sdf/gpio_defaults_block.sdf", uut.\gpio_defaults_block_0[0] ) ;
			$sdf_annotate("../../../caravel/sdf/gpio_defaults_block.sdf", uut.\gpio_defaults_block_0[1] ) ;
			$sdf_annotate("../../../caravel/sdf/gpio_defaults_block.sdf", uut.\gpio_defaults_block_2[0] ) ;
			$sdf_annotate("../../../caravel/sdf/gpio_defaults_block.sdf", uut.\gpio_defaults_block_2[1] ) ;
			$sdf_annotate("../../../caravel/sdf/gpio_defaults_block.sdf", uut.\gpio_defaults_block_2[2] ) ;
			$sdf_annotate("../../../caravel/sdf/gpio_defaults_block.sdf", uut.gpio_defaults_block_5) ;
			$sdf_annotate("../../../caravel/sdf/gpio_defaults_block.sdf", uut.gpio_defaults_block_6) ;
			$sdf_annotate("../../../caravel/sdf/gpio_defaults_block.sdf", uut.gpio_defaults_block_7) ;
			$sdf_annotate("../../../caravel/sdf/gpio_defaults_block.sdf", uut.gpio_defaults_block_8) ;
			$sdf_annotate("../../../caravel/sdf/gpio_defaults_block.sdf", uut.gpio_defaults_block_9) ;
			$sdf_annotate("../../../caravel/sdf/gpio_defaults_block.sdf", uut.gpio_defaults_block_10) ;
			$sdf_annotate("../../../caravel/sdf/gpio_defaults_block.sdf", uut.gpio_defaults_block_11) ;
			$sdf_annotate("../../../caravel/sdf/gpio_defaults_block.sdf", uut.gpio_defaults_block_12) ;
			$sdf_annotate("../../../caravel/sdf/gpio_defaults_block.sdf", uut.gpio_defaults_block_13) ;
			$sdf_annotate("../../../caravel/sdf/gpio_defaults_block.sdf", uut.gpio_defaults_block_14) ;
			$sdf_annotate("../../../caravel/sdf/gpio_defaults_block.sdf", uut.gpio_defaults_block_15) ;
			$sdf_annotate("../../../caravel/sdf/gpio_defaults_block.sdf", uut.gpio_defaults_block_16) ;
			$sdf_annotate("../../../caravel/sdf/gpio_defaults_block.sdf", uut.gpio_defaults_block_17) ;
			$sdf_annotate("../../../caravel/sdf/gpio_defaults_block.sdf", uut.gpio_defaults_block_18) ;
			$sdf_annotate("../../../caravel/sdf/gpio_defaults_block.sdf", uut.gpio_defaults_block_19) ;
			$sdf_annotate("../../../caravel/sdf/gpio_defaults_block.sdf", uut.gpio_defaults_block_20) ;
			$sdf_annotate("../../../caravel/sdf/gpio_defaults_block.sdf", uut.gpio_defaults_block_21) ;
			$sdf_annotate("../../../caravel/sdf/gpio_defaults_block.sdf", uut.gpio_defaults_block_22) ;
			$sdf_annotate("../../../caravel/sdf/gpio_defaults_block.sdf", uut.gpio_defaults_block_23) ;
			$sdf_annotate("../../../caravel/sdf/gpio_defaults_block.sdf", uut.gpio_defaults_block_24) ;
			$sdf_annotate("../../../caravel/sdf/gpio_defaults_block.sdf", uut.gpio_defaults_block_25) ;
			$sdf_annotate("../../../caravel/sdf/gpio_defaults_block.sdf", uut.gpio_defaults_block_26) ;
			$sdf_annotate("../../../caravel/sdf/gpio_defaults_block.sdf", uut.gpio_defaults_block_27) ;
			$sdf_annotate("../../../caravel/sdf/gpio_defaults_block.sdf", uut.gpio_defaults_block_28) ;
			$sdf_annotate("../../../caravel/sdf/gpio_defaults_block.sdf", uut.gpio_defaults_block_29) ;
			$sdf_annotate("../../../caravel/sdf/gpio_defaults_block.sdf", uut.gpio_defaults_block_30) ;
			$sdf_annotate("../../../caravel/sdf/gpio_defaults_block.sdf", uut.gpio_defaults_block_31) ;
			$sdf_annotate("../../../caravel/sdf/gpio_defaults_block.sdf", uut.gpio_defaults_block_32) ;
			$sdf_annotate("../../../caravel/sdf/gpio_defaults_block.sdf", uut.gpio_defaults_block_33) ;
			$sdf_annotate("../../../caravel/sdf/gpio_defaults_block.sdf", uut.gpio_defaults_block_34) ;
			$sdf_annotate("../../../caravel/sdf/gpio_defaults_block.sdf", uut.gpio_defaults_block_35) ;
			$sdf_annotate("../../../caravel/sdf/gpio_defaults_block.sdf", uut.gpio_defaults_block_36) ;
			$sdf_annotate("../../../caravel/sdf/gpio_defaults_block.sdf", uut.gpio_defaults_block_37) ;
//        $sdf_annotate("../../synthesis/riscv_delays.sdf", RISCVCPU_tb.my_cpu,,"sdf.log","MAXIMUM");
		end
	`endif 

    wire [31:0] loop_count_divided;
    assign loop_count_divided = loop_count >> 10;

    always@(index or loop_count_divided)
    begin
        $display("Time: %d\t index: %d \t loop_count = %d", $time, index, loop_count);
    end

    //always@(*)  $display("First few bytes of memory:\n io_ports_tb.uut.mprj.mprj.wb_inter_connect.imem.imem.imem.imem_ext.mem_0_0.mem[0] = %h \n\n", io_ports_tb.uut.mprj.mprj.wb_inter_connect.imem.imem.imem.imem_ext.mem_0_0.mem[0]);  // debug

	initial begin
		$dumpfile("io_ports.vcd");
		$dumpvars(0, io_ports_tb);
        //$dumpvars(1, io_ports_tb.uut.mprj.mprj.clk_muxed, SoC_tb.index, io_ports_tb.uut.mprj.mprj.wb_inter_connect.uart.tx_data_r, SoC_tb.io_dir_m1, SoC_tb.io_dir_m2, SoC_tb.pen_servo_control, SoC_tb.step1step, SoC_tb.step2step);
        //$monitor("Time: %d\t index: %d \t loop_count_divided = %d", $time, index, loop_count_divided);

        $display("Starting reset sequence...");
        my_reset = 1;
        #2000;
        my_reset = 0;
        wait(clk_muxed === 1'b1);  // wait for management core to finish configuration of the GPIOs that are to be used as outputs
        #2000;
        my_reset = 1;   // apply reset again
        #2000;
        my_reset = 0;
        
        $display("Starting loading of program over SPI...");
        $readmemh("imem.txt", buffer);
        index = 0;
        io_spi_miso = 0;
    
        for (loop_count = 0; loop_count < 300000; loop_count = loop_count + 1)
        begin
            //$display("Loop count = %d\n", loop_count);
            @ (posedge clock);
    
            // transmit the instruction memory contents byte by byte over SPI
        	if (io_spi_mosi == 1)
            begin
        	    wdata = buffer[index];
        	    index = index + 1;  // increment byte index

                //if (index == 2) $finish;    // debug

        	    repeat (431) @ (posedge clock);
        	    for (byte_no = 0; byte_no < 4; byte_no = byte_no + 1) 
                begin
                    case (byte_no)
                        0:  bdata = wdata[7:0];
                        1:  bdata = wdata[15:8];
                        2:  bdata = wdata[23:16];
                        3:  bdata = wdata[31:24];
                    endcase
        	        repeat (68) @ (posedge clock);
                    // transmit the selected byte bit by bit over SPI
                    for (bit_index = 0; bit_index < 8; bit_index = bit_index + 1) 
                    begin
                        io_spi_miso = bdata[7 - bit_index];
                        repeat (8) @ (posedge clock);
                    end
                    @ (posedge clock);
                    io_spi_miso = 0;
        	    end
            end
        end
        
        $display("%c[1;31m",27);
        $display("Testbench failed.");
//		`ifdef GL
//			$display ("Monitor: Timeout, Test Mega-Project IO Ports (GL) Failed");
//		`else
//			$display ("Monitor: Timeout, Test Mega-Project IO Ports (RTL) Failed");
//		`endif
        $display("%c[0m",27);
        $finish; 
	end

    initial        // logic has been verified through practical demonstration using FPGA, hence this testbench is only checking connections by applying inputs and observing that the outputs are toggling as a result of the inputs
    begin
        wait(io_ports_tb.uut.mprj.mprj.wb_inter_connect.uart.tx_data_r == 8'd0);   // wait till program transmits the coordinates (0, 0)
        repeat(2)       // wait for 2 pulses of pen_servo_control output
        begin
            @ (posedge pen_servo_control);
            @ (negedge pen_servo_control);
        end
        wait(io_ports_tb.uut.mprj.mprj.wb_inter_connect.uart.tx_data_r == 8'd100);         // wait for d i.e. the down command
        @ (posedge io_dir_m2);          // current coordinates are (0, 0) so no movement occurs i.e. no step pulses to motors; just check for change of direction output
        wait(io_ports_tb.uut.mprj.mprj.wb_inter_connect.uart.tx_data_r == 8'd108);         // wait for l i.e. the left command
        wait(step1step == 1'b0);
        wait(step2step == 1'b0);
        @ (negedge io_dir_m1);
        wait(step1step == 1'b1);
        wait(step2step == 1'b1);
        @ (negedge step1step);
        wait(step2step == 1'b0);
        #500000
        
        $display("Testbench passed.");
//		`ifdef GL
//	    	$display("Monitor: Test 1 Mega-Project IO (GL) Passed");
//		`else
//		    $display("Monitor: Test 1 Mega-Project IO (RTL) Passed");
//		`endif
        $finish;
    end

	initial begin
		RSTB <= 1'b0;
		CSB  <= 1'b1;		// Force CSB high
		#2000;
		RSTB <= 1'b1;	    	// Release reset
		#3_00_000;
		CSB = 1'b0;		// CSB can be released
	end

	initial begin		// Power-up sequence
		power1 <= 1'b0;
		power2 <= 1'b0;
		power3 <= 1'b0;
		power4 <= 1'b0;
		#100;
		power1 <= 1'b1;
		#100;
		power2 <= 1'b1;
		#100;
		power3 <= 1'b1;
		#100;
		power4 <= 1'b1;
	end

//	always @(mprj_io) begin
//		#1 $display("MPRJ-IO state = %b ", mprj_io[7:0]);
//	end

	wire flash_csb;
	wire flash_clk;
	wire flash_io0;
	wire flash_io1;

	wire VDD3V3;
	wire VDD1V8;
	wire VSS;
	
	assign VDD3V3 = power1;
	assign VDD1V8 = power2;
	assign VSS = 1'b0;

	caravel uut (
		.vddio	  (VDD3V3),
		.vddio_2  (VDD3V3),
		.vssio	  (VSS),
		.vssio_2  (VSS),
		.vdda	  (VDD3V3),
		.vssa	  (VSS),
		.vccd	  (VDD1V8),
		.vssd	  (VSS),
		.vdda1    (VDD3V3),
		.vdda1_2  (VDD3V3),
		.vdda2    (VDD3V3),
		.vssa1	  (VSS),
		.vssa1_2  (VSS),
		.vssa2	  (VSS),
		.vccd1	  (VDD1V8),
		.vccd2	  (VDD1V8),
		.vssd1	  (VSS),
		.vssd2	  (VSS),
		.clock    (clock),
		.gpio     (gpio),
		.mprj_io  (mprj_io),
		.flash_csb(flash_csb),
		.flash_clk(flash_clk),
		.flash_io0(flash_io0),
		.flash_io1(flash_io1),
		.resetb	  (RSTB)
	);

	spiflash #(
		.FILENAME("io_ports.hex")
	) spiflash (
		.csb(flash_csb),
		.clk(flash_clk),
		.io0(flash_io0),
		.io1(flash_io1),
		.io2(),			// not used
		.io3()			// not used
	);

endmodule
`default_nettype wire
