Properties:
* Used Gray Code for FIFO pointers to avoid multi-bit signal transitions.
* Avoided meta-stability issues in CDC by implementing 2 Flip-Flop based Synchronizer.
* Tested exhaustively for full and empty flags with fast write clock and slow read clock.

Used 16x16b memory.
RTL discription in Verilog HDL.
