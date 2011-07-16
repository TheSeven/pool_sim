Running the tests
=================

    ruby test.rb

Changing the parameters
=======================

You can pass the following options to the run() method, or to the initializer of the simulator object:

- `:rounds`: number of rounds to run
- `:difficulty`: difficulty level, in mean shares per block
- `:miner_percent`: percentage of total hashrate owned by target miner
- `:average_fees`: mean amount of fees, in BTC
