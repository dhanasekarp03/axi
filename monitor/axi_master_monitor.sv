//AXI_MASTER_MONITOR PSEUDOCODE:
//-----------------------------------------------------------------------------------
//axi_master_monitor is user-defined class which is extended from uvm_monitor which is a pre-defined uvm class
class axi_master_monitor extends uvm_monitor 

//Factory registration
`uvm_component_utils(axi_master_monitor)

//Handle to virtual interface
virtual axi_master_interface vif;
  
//Declaring a handle of axi_master_sequence_item
axi_master_sequence_item req_op;

//Declaring 5 analysis ports to put 5 channel signals to 5 different FIFOs in scoreboard
uvm_analysis_port#(axi4_master_tx) axi4_master_read_address_analysis_port;
uvm_analysis_port#(axi4_master_tx) axi4_master_read_data_analysis_port;
uvm_analysis_port#(axi4_master_tx) axi4_master_write_address_analysis_port;
uvm_analysis_port#(axi4_master_tx) axi4_master_write_data_analysis_port;
uvm_analysis_port#(axi4_master_tx) axi4_master_write_response_analysis_port;

//Different methods present in the class that are defined outside class using extern keyword
extern function new(string name = "axi4_master_monitor_proxy", uvm_component parent = null);
extern virtual function void build_phase(uvm_phase phase);
extern virtual function void connect_phase(uvm_phase phase);
extern virtual function void end_of_elaboration_phase(uvm_phase phase);
extern virtual task run_phase(uvm_phase phase);
extern virtual task axi4_write_address();
extern virtual task axi4_write_data();
extern virtual task axi4_write_response();
extern virtual task axi4_read_address();
extern virtual task axi4_read_data();

endclass : axi_master_monitor_

//--------------------------------------------------------------------------------
//Function: class constructor
function axi_master_monitor::new(string name = "axi_master_monitor", uvm_component parent = null);
  super.new(name, parent)
  axi4_master_read_address_analysis_port   = new("axi4_master_read_address_analysis_port",this);
  axi4_master_read_data_analysis_port      = new("axi4_master_read_data_analysis_port",this);
  axi4_master_write_address_analysis_port  = new("axi4_master_write_address_analysis_port",this);
  axi4_master_write_data_analysis_port     = new("axi4_master_write_data_analysis_port",this);
  axi4_master_write_response_analysis_port = new("axi4_master_write_response_analysis_port",this);
endfunction : new

//Function: Build phase
function void axi4_master_monitor_proxy::build_phase(uvm_phase phase);
  super.build_phase(phase);
  if(!uvm_config_db#(virtual axi_master_interface)::get(this, "", "vif", vif))a
      `uvm_fatal("Monitor: ", "No vif is found!")
  end 
endfunction : build_phase 

//Function: connect phase
function void axi4_master_monitor_proxy::connect_phase(uvm_phase phase);
  super.connect_phase(phase);
endfunction : connect_phase

//Task: run phase
task axi_master_monitor::run_phase(uvm_phase phase);
  if(vif.aresetn) begin
  fork 
    axi4_write_address();
    axi4_write_data();
    axi4_write_response();
    axi4_read_address();
    axi4_read_data();
  join
end
endtask : run_phase

//Task: axi4_write_address
//Task to obtain write address channel signals
task axi4_master_monitor::axi4_write_address();
  forever begin
    // Copy all write address channel signals to req_op
    //using write address analysis port call write function to pass write address signals to scoreboard
  end
endtask

//Task: axi4_write_data
//Task to obtain write data channel signals
task axi4_master_monitor::axi4_write_data();
  forever begin
    // Copy all write data channel signals to req_op
    //using write data analysis port call write function to pass write data signals to scoreboard
  end
endtask

//Task: axi4_write_response
//Task to obtain write response channel signals
task axi4_master_monitor::axi4_write_data();
  forever begin
    // Copy all write response channel signals to req_op
    //using write response analysis port call write function to pass write response signals to scoreboard
  end
endtask

//Task: axi4_read_address
//Task to obtain read address channel signals
task axi4_master_monitor::axi4_read_address();
  forever begin
    // Copy all read address channel signals to req_op
    //using read address analysis port call write function to pass read address signals to scoreboard
  end
endtask
  
//Task: axi4_read_data
//Task to obtain read data channel signals
task axi4_master_monitor::axi4_read_data();
  forever begin
    // Copy all read data channel signals to req_op
    //using read data analysis port call write function to pass read data signals to scoreboard
  end
endtask
