# Niryo Ned2 Kinematics MATLAB

MATLAB robotics project for modelling, calibrating, and testing the kinematics of the Niryo Ned2 robot arm. The repository contains symbolic derivations, generated MATLAB functions, numerical kinematics exercises, calibration experiments, and supporting course material.

## Authors

Work by Fils Elie Boungoueres & Dr. Stephane Ygorra

## Recommended Repository Name

`niryo-ned2-kinematics-matlab`

This name is short, searchable, and accurately reflects the main content of the project: MATLAB implementations of geometric, inverse, and differential kinematics for the Niryo Ned2 manipulator.

## Project Overview

The work focuses on the kinematic study of a 6-axis serial robot arm. It includes:

- Direct geometric model generation using Denavit-Hartenberg transformations.
- Inverse geometric model exploration using Paul equation decomposition.
- Jacobian-based numerical kinematics for end-effector point displacement.
- Symbolic derivation of homogeneous transformations and generated MATLAB functions.
- Calibration support using OptiTrack/Niryo measurement data.
- Additional UR10 educational material and CoppeliaSim scene files for comparison and practice.

## Repository Structure

```text
.
|-- docs/
|   |-- 3-modele_geometrique.pdf
|   |-- 4-cinematique.pdf
|   |-- MGI_methode_de_paul_matlab.pdf
|   `-- tp_niryo.pdf
|-- equations_de_paul/
|   |-- equations_de_paul/
|   |   `-- Paul-equation helper solvers
|   |-- mgdNed2.m
|   |-- mgiNed2.m
|   `-- generated equation parameter/variable files
|-- results/
|   `-- empty output folder
|-- src/
|   |-- tr_homogene/
|   |   `-- homogeneous transformation helpers
|   |-- td_ur10_cinematique_edu/
|   |   `-- UR10 MATLAB and CoppeliaSim educational material
|   |-- ned2_symbolic.m
|   |-- ned2_numeric_kinemartics.m
|   |-- calibrer_ned2.m
|   |-- partie_numerique.m
|   |-- mgdNed2.m
|   |-- T06Ned2.m
|   `-- J0P6Ned2.m
|-- AUTHORS.md
|-- .gitignore
`-- README.md
```

## Main MATLAB Files

| File | Purpose |
| --- | --- |
| `src/ned2_symbolic.m` | Builds the symbolic Denavit-Hartenberg model of the Niryo Ned2 and generates `mgdNed2.m` and `T06Ned2.m`. |
| `src/mgdNed2.m` | Generated direct geometric model returning the elementary transformations from frame 0 to frame 6. |
| `src/T06Ned2.m` | Generated full homogeneous transformation from base frame to end-effector frame. |
| `src/J0P6Ned2.m` | Generated Jacobian for the displacement of a point expressed in frame 6. |
| `src/ned2_numeric_kinemartics.m` | Numerical test using the Jacobian to move a point by a desired displacement. |
| `src/mgi_ned2.m` | Inverse geometric model experiment based on Paul equation solving. |
| `src/calibrer_ned2.m` | Symbolic preparation for calibration equations between robot and OptiTrack frames. |
| `src/partie_numerique.m` | Numerical calibration script using `niryo_calibration_data.txt`. |

## Requirements

- MATLAB
- Symbolic Math Toolbox
- Optional: CoppeliaSim, only for opening the `.ttt` simulation scenes in `src/td_ur10_cinematique_edu/ur10-vrep/`

The generated files mention Symbolic Math Toolbox 8.7, so MATLAB R2021b or a compatible newer version is recommended.

## Important Path Setup Notice

Before running any script or simulation, make sure MATLAB can access all required folders used by the project. Some files call functions located in other directories, especially `src/tr_homogene/`, `equations_de_paul/`, `equations_de_paul/equations_de_paul/`, and `src/td_ur10_cinematique_edu/matlab/`.

If these paths are not added first, MATLAB may return errors such as `Undefined function or variable` even if the function exists elsewhere in the repository.

You can add the paths manually from MATLAB with:

```matlab
addpath('src')
addpath('src/tr_homogene')
addpath('src/td_ur10_cinematique_edu/matlab')
addpath('equations_de_paul')
addpath('equations_de_paul/equations_de_paul')
```

If you move files or run scripts from another working directory, update these paths so they match the actual location of the folders on your computer.

## How to Run

From MATLAB, open the repository root and add the source folders:

```matlab
cd path/to/niryo-ned2-kinematics-matlab
addpath('src')
addpath('src/tr_homogene')
addpath('src/td_ur10_cinematique_edu/matlab')
addpath('equations_de_paul')
addpath('equations_de_paul/equations_de_paul')
```

Run a direct geometric model example:

```matlab
d1 = 166.3e-3;
a2 = 221e-3;
a3 = 32.5e-3;
d4 = 235e-3;
params = [d1; a2; a3; d4];
q = zeros(6,1);

[T01,T12,T23,T34,T45,T56] = mgdNed2(q, params);
T06 = T01*T12*T23*T34*T45*T56
```

Run the numerical Jacobian exercise:

```matlab
cd src
ned2_numeric_kinemartics
```

## Known Maintenance Notes

- `src/mgi_ned2.m` references some helper names that are not present under the exact same filenames in the current tree, such as `params_type7_O24_q2_q3_` and `vars_type7_O24_q2_q3_`. These may need to be regenerated from `src/ned2_symbolic.m` or renamed to match the available generated files.
- `src/partie_numerique.m` calls `CalcHF` with fewer inputs than the generated `CalcHF.m` signature currently requires. The calibration script likely needs parameter values added to the call.
- `src/CalcHandF.m` appears incomplete and should be treated as experimental draft code.
- `src/partie_numerique.asv` is a MATLAB autosave file and should not be committed.

## Short Description of the Work Done

This project develops a MATLAB-based kinematic study of the Niryo Ned2 robot. It defines the robot's homogeneous transformations, generates direct geometric and Jacobian functions from symbolic expressions, explores inverse kinematics through Paul equation decomposition, and includes calibration scripts using OptiTrack measurement data. Supporting PDFs and UR10 examples are included as course references and complementary robotics exercises.

Project prepared and documented by Fils Elie Boungoueres and Dr. Stephane Ygorra at University of Bordeaux/ IMS Lab
