# Parallel-Computing
This repository was made to store and guide my studies about parallel computing using CUDA

**Table of Contents**
 - [Parallel Communication](#parallel-communication)
 - [GPU Hardware Design](#gpu-hardware-design)

## Parallel Communication
Parallel Programmming Paradigm requires
some special communication design between GPU threads.

 - **MAP** (One-to-One)
    - This pattern compute each data given by the host and write some result for each data in different memory addresses.
 - **Transpose** (One-to-One)
    - Reorganize structure of the data storage inside memory
 - **Gather** (Many-To-One)
    - This pattern compute a set of data given by host and generate a single result on each thread.
 - **Scatter** (One-To-Many)
    - This pattern compute some data given by host and write and same result in different memory addresses.
 - **Stencil** (Several-to-One)
     - Like gather pattern, this pattern get a set/struct of data given by host,compute and write result in a single memory address.

<p align="center">
  <img src="./Resources/parallel-patterns.png" width="350"/>
</p>


## GPU Hardware Design


