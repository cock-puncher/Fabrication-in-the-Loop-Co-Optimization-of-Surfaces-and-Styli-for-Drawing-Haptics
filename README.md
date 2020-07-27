# Welcome

This a repository containing supplementary files for our project *Fabrication-in-the-Loop Co-Optimization of Surfaces and Styli for Drawing Hapticsp* ublished on Siggraph 2020. More information on the project, as well as, the full paper are available on our [project webpage](https://www.pdf.inf.usi.ch/projects/SurfaceStylusCoOpt/index.html).

## main.m

Example usage of the optimization with our dataset

## features.mat

Dataset of measured drawing tool and surface designs for our project. The stylus nib parametrization is a pair of `[radius, material]` and the surface parametreization is defined by `[manufacturing method, mixing ratio, mean frequency 1, deviation of frequency 1, mean frequency 2, deviation of frequency 2, layer scaling]`

## BayesianOptimization.m

Implementation of the optimization using Gaussian Processes. The input is a set of manufactured digital designs with observed percieved friction and vibration, a set of available stylus nibs, a description of currently printed tool (a vector with `[estimated printing time in seconds, expected improvement, and nib parameters]`), and the desired target haptic feedback represented as percieved friction and vibration. When executed the code suggests new tool and surface design to be manufactured

## expected_improvement2D.m

Reference implementation of the analytical improvement function for two-dimensional distance minimization for Gaussain Processes. The function takes as input predicted friction and vibration with confidence bounds, target friction and vibration, distance to closest design from the target and a parameter that modulates the degree of exploration (in all of our experiments we use `zeta=0.1`). The output is the expected improvement towards target desired behavior.

## GeneratePatternFrequency.m

A sample implementation of a freuqency-based Gabor filter that takes the input surface parameters and generates a binary mask for single-layer printing processes.

## fit_GP_proxy.m

Example of Gaussian processes for predicting perceived friction and vibration using the reference implementation in Matlab.

## maximize_expected_improvement_genetic.m

Genetic algorithm style optimization of new drawing tools and substrates. The function either optimizes for the stylus parameters with a set of fixed surfaces or for the surface parameters with a set of fixed stylus nibs.

## Measurements

The friction and vibration measurements of each datasample captured by the device from our previous project *Perception-Aware Modeling and Fabrication of Digital Drawing Tools*. More details available on the [project webpage](http://pdf.mmci.uni-saarland.de/projects/DigitalStylus/).

## Citation
If you use any of these materials, please, reference our original paper:
```
Fabrication-in-the-Loop Co-Optimization of Surfaces and Styli for Drawing Haptics
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
