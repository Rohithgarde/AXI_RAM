//include agent, scoreboard, subscriber files
`include "axi_master_agent.sv"
`include "axi_master_scoreboard.sv"
`include "axi_master_coverage.sv"

//factory registration and creating handles for agent, scoreboard, subscriber
class axi_master_environment extends uvm_env;
  axi_master_agent axi_master_agt;
  axi_master_scoreboard axi_master_scb;
  axi_master_coverage axi_master_cov;
  `uvm_component_utils(axi_master_environment)

  //default constructor new
  function new(string name = "axi_master_environment", uvm_component parent);
    super.new(name, parent);
  endfunction

  //create object for agent, scoreboard, subscriber in build phase
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    axi_master_agt = axi_master_agent::type_id::create("axi_master_agt", this);
    axi_master_scb = axi_master_scoreboard::type_id::create("axi_master_scb", this);
    axi_master_cov = axi_master_coverage::type_id::create("axi_master_cov", this);
  endfunction

  //connect analysis port of monitor to export of scoreboard and subscriber
  virtual function void connect_phase(uvm_phase phase);
    axi_master_agt.axi_master_mon.item_got_port.connect(axi_master_scb.item_got_export);
    axi_master_agt.axi_master_mon.item_got_port.connect(axi_master_cov.item_got_export_sub);
  endfunction

endclass
