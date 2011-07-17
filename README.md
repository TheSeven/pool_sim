Pool Payout Simulator
=====================

Running the simulation
----------------------

    ruby test.rb

Changing the parameters
-----------------------

You can pass the following options to the run() method, or to the initializer of the simulator object:

- `:rounds`: number of rounds to run
- `:difficulty`: difficulty level, in mean shares per block
- `:miner_percent`: percentage of total hashrate owned by target miner
- `:average_fees`: mean amount of fees, in BTC
- `:withholding_percent`: percentage of pool that will withhold a found block

Available payout models
-----------------------

- `Prop`: Straight proportional payout
- `SMPPS`: Luke-Jr's Shared-Maximum Pay-per-Share
- `XPPS`: Like SMPPS, but without debt memory

Writing your own model
----------------------

To create your own payout scheme, subclass `PoolSim` and implement the `pay_out` method.
This method should, at a minimum, update the `@honest_earnings` variable, which represents
the cumulative earnings of a single miner owning `miner_percent`% of the pool hashrate.

If you have other variables you want to plot other than the defaults (Round, Reward, Shares, and Difficulty),
you can declare them with

    class CustomPool < PoolSim
      plot :myvar1, :myvar2
    end

TODO
----

- Monte-carlo simulation
- Graphs
- Attack models
- Hashrate profiles
