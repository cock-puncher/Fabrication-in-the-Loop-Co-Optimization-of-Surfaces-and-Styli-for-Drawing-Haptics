# Welcome

This a repository containing supplementary files for our project Fabrication-in-the-Loop Co-Optimization of Surfaces and Styli for Drawing Hapticspublished on Siggraph 2020. More information on the project, as well as, the full paper are available on our [project webpage](https://www.pdf.inf.usi.ch/projects/SurfaceStylusCoOpt/index.html).

## main.m

Example usage of the optimization with our dataset

## BayesianOptimization.m

Implementation of the optimization using Gaussian Processes. When executed the code suggests new tool and surface design to be manufactured

## features.mat

Dataset of measured drawing tool and surface designs for ourt project

## expected_improvement2D.m

Reference implementation of the analytical improvement function for two-dimensional distance minimization for Gaussain Processes

## GeneratePatternFrequency.m

A sample implementation of a freuqency-based Gabor filter that takes the input npoise parameters and generates a binary mask for single-layer printing processes.

## fit_GP_proxy.m

Example of Gaussian processes for predicting perceived friction and vibration using the reference implementation in matlab

## maximize_expected_improvement_genetic.m

Genetic algorithm style optimization of new drawing tools and substrates.

## Measurements

The friction and vibration measurements of each datasample captured by the device from our previous project Perception-Aware Modeling and Fabrication of Digital Drawing Tools. More details available on the [project webpage](http://pdf.mmci.uni-saarland.de/projects/DigitalStylus/).

## Citation
If you use any of these materials, please, reference our original paper:
```
Perception-Aware Modeling and Fabrication of Digital Drawing Tools
Michal Piovarči, Danny M. Kaufman, David I.W. Levin, Piotr Didyk
ACM Transactions on Graphics 39(4) (Proc. SIGGRAPH 2020, Washington DC, USA) 
```
bibtex:
```
@article{Piovarci2020,
  author = { Michal Piovar\v{c}i and Danny M. Kaufman and David I.W. Levin and Piotr Didyk},
  title = {Fabrication-in-the-Loop Co-Optimization of Surfaces and Styli for Drawing Haptics},
  journal = {ACM Transactions on Graphics (Proc. SIGGRAPH)},
  year = {2020},
  volume = {39},
  number = {4}
}
```
