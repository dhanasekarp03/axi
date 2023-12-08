

class axi_master_write_read_test extends apb_base_test;
  `uvm_component_utils(axi_master_write_read_test)

  // instantiation of the handle 
  
  axi_master_write_read_transfer  axi_master_write_read_transfer_h; 

  // Factory registeration
  
  function axi_master_write_read_test::new(string name = "axi_master_write_read_test",uvm_component parent = null);
  super.new(name, parent);
endfunction : new

  // task for run phase

 task axi_master_write_read_test::run_phase(uvm_phase phase);
  
  super.run_phase(phase);
   axi_master_write_read_transfer_h = axi_master_write_read_transfer::type_id::create("axi_master_write_read_transfer_h");
   `uvm_info(get_type_name(),$sformatf("axi_master_write_read_test"),UVM_LOW);
  phase.raise_objection(this);
    axi_master_write_read_transfer_h .start(axi_env_h.axi_master_agent_h.axi_seqr_h);
  phase.drop_objection(this);

endtask : run_phase

  endclass     
