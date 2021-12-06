# KAUST CS294O Class Projet - Gold Miner
This is an implementation of popular Gold Miner game by Verilog

Projects are designed and tested on **NEXYS A7** board.

Game idea comes from https://www.crazygames.com/game/gold-miner

| Hierarchy  |                                                              |
| ---------- | ------------------------------------------------------------ |
| Constraint | Constraint file                                              |
| IP         | Intelligence Property instance files, can not be run directly |
| Sources    | Design fiels in verilog                                      |

**User Guide**:

To deploy the figure.	

1. Create a new project in Xilinx vivado

2. Add all **.coe** files in folder **Figures** to project.

3. Add all **.v** files in folder **sources** to project.

4. Set **game_top.v** to the top file.

5. Configure IP modules (Two are used, [Clocking Wizard v6.0](https://www.xilinx.com/support/documentation/ip_documentation/clk_wiz/v6_0/pg065-clk-wiz.pdf) & [Block Memory Generator](https://www.xilinx.com/support/documentation/ip_documentation/blk_mem_gen/v8_4/pg058-blk-mem-gen.pdf))

   *We will not cover details of IP configuration, if interested, please contact us.*
