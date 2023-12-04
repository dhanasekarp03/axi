//AXI_MASTER_MONITOR PSEUDOCODE:
//-----------------------------------------------------------------------------------
//axi_master_monitor is user-defined class which is extended from uvm_monitor which is a pre-defined uvm class
class axi_master_monitor extends uvm_monitor 

//Factory registration
`uvm_component_utils(axi_master_monitor)

//Declaring a handle of axi_master_sequence_item
axi_master_sequence_item req_op;

//Declaring analysis ports to put 5 channel signals to 5 different FIFOs in scoreboard
uvm_analysis_port#(axi4_master_sequence_item) axi4_master_analysis_port;


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
  super.new(name, parent);
  axi4_master_analysis_port   = new("axi_master_read_address_analysis_port",this);
endfunction : new

//Function: Build phase
function void axi4_master_monitor_proxy::build_phase(uvm_phase phase);
  super.build_phase(phase);
  if(!uvm_config_db#(virtual axi_master_interface)::get(this, "", "vif", vif))
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
