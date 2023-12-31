# NAMDEnergy
*Run NAMDEnergy in command line*

This script is designed to calculate interaction energies (Uab) between two selected groups of atoms from a molecular dynamics trajectory. Please make sure that you have correctly selected the options in the parameters section and entered the appropriate data for your system. Once you have done this, you can run the script from the Linux command line:

    vmd -dispdev text -eofexit < NAMDEnergy.tcl > NAMDEnergy.log

Adjusting details in the current script allows you to use it to calculate whether the net forces are attractive or repulsive between the  center of mass of the pair selected, calculate only total contributions from a single selection, or use the AMBER force field.

# NAMDEnergy for X-PLOR format

If you want to use NAMDEnergy and your force field parameter file are in *X-PLOR format*, we recommend downloading our version of NAMDEnergy [namdenergy-x-plor.tcl](namdenergy-x-plor.tcl) and modifying line 5 of the [NAMDEnergy.tcl](NAMDEnergy.tcl) script as follows:

replace:

    package require namdenergy

with:

    source namdenergy-x-plor.tcl

After making this change, save it, and you can then execute it as indicated in the previous section.


#  PARAMETERS of NAMDEnergy    


**-ofile** *FILE*

Output file Gives the name of the file for final energy output to be printed to. If not specified, output will be printed to the vmd console.

**-tempname** *FILE* 

Prefix for temporary files used by NAMD. These will be deleted after the run unless the debug option is used.

**-switch** *NUMBER* 

Switching distance used by NAMD for nonbond interactions. Default 10. If switch is less than zero, switching will be turned off.

**-cutoff** *NUMBER*

Cutoff for nonbond interactions, used by NAMD. Default 12.

**-skip** *NUMBER* 

Number of frames to skip between every calculated energy frame in NAMDenergy calculations on trajectories. Default 0.

**-ts** *NUMBER*

Starting timestep from NAMD; this is purely for bookkeeping purposes. Default: 0

**-timemult** *NUMBER*

Length of each timestep that a dynamics trajectory was recorded at, in fs; this is for bookkeeping purposes. Default 1.

**-stride** *NUMBER*

Number of timesteps between each output in a trajectory; this is purely for bookkeeping purposes. Default: 1

**-par** *FILE*

One or more parameter files for NAMD to use; a default will be used if none are specified, but you must make sure that it is suitable for your application. Each additional parameter file requires another -par option.

**-drude**

If present, drude polarizable force field is supported.

**-silent**

If this flag is specified, no energy output will be printed. This is usually only useful for the command line form, when you want to use the returned energy lists as part of another function.

**-debug**

If this flag is specified, temporary files used by NAMDenergy will not be deleted.

**-keepforce**

If this flag is specified, information on force magnitudes will be included in the output from interaction calculations. This only applies for calculating the interaction between two selections.

**-projforce** 

This flag is only meaningful when combined with keepforce. When specified, the output forces will be the projection of the total forces onto the vector between the center of mass of the two selections. In this case the forces are signed quantities; a negative force is attractive and a positive force repulsive.

**-plot** 

Use multiplot to plot energy output. Plotting will only occur if there is more than one timestep of data.

**-gui**

Force creation of gui from command line, using command line options instead of the defaults. 

**-extsys** *FILE*

Use the specified xsc file to set up a periodic system

**-updatesel** 

Update the selections used for interactions every frame. Use of this option incurs a significant slowdown, but is needed if one or both of the selections contain different sets of atoms in different frames.

**-pme** 

Run energy calculations with PME. Only meaningful when combined with -extsys

**-exe** */path/to/namd2*

Explicitly set the path to the NAMD multicore executable 


*Energy types are indicated by options* 

**-all** 

*Bonded energy types*

**-bond** 

**-angl** 

**-dihe** 

**-impr** 

**-conf** 

*non-bonded energy types*

**-vdw** 

**-elec** 

**-nonb**

Note **-nonb** is vwd + elec energy

One or two atom selections should also be given after a **-sel** option in the [NAMDEnergy.tcl](NAMDEnergy.tcl) script to define the atom selections to run energy calculations. The argument for the **-sel** option is a variable containing either one or two atom selections; if a single selection is given (**-sel** *$sel1*), then energies indicated in the options for that selection are calculated. If two selections are given (**-sel** *$sel1* *$sel2*), only the *non-bonded energy types*  between the two selections can be calculated (the Uab). When using two selections take care that the second atom select does not include any atoms from the first. 

Note that all energy output is given in *kcal/mol*, and all force outputs in *kcal/(mol * Å)*. 
