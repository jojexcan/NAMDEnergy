#####################################
###       NAMDEnergy script       ###
#####################################
#Require package
package require namdenergy

#set the files names
set topfile "file.psf"
set trjfile1 "file1.dcd"
set trjfile2 "file2.dcd"
set trjfile3 "file3.dcd"

#Upload the system
mol new $topfile type psf waitfor all
mol addfile $trjfile1 type dcd waitfor all
mol addfile $trjfile2 type dcd waitfor all
mol addfile $trjfile3 type dcd waitfor all

#select the pair to compute the interaction energy within them
set sel1 [atomselect top "resname LIG"]
set sel2 [atomselect top "not resname LIG"]

# Run namdenergy
namdenergy \
	-par par_all36_carb.prm \
	-par par_all36_cgenff.prm \
	-par par_all36_lipid.prm \
	-par par_all36_na.prm \
	-par par_all36_prot.prm \
	-par toppar_all36_carb_glycopeptide.str \
	-par toppar_water_ions_namd.str \
	-extsys "file.xsc" \
	-sel $sel1 $sel2 \
	-ofile "Interaction_Energy.dat" \
	-vdw \
	-elec \
	-switch 10 \
	-cutoff 12 \
	-pme \
	-exe /path/to/namd2 \
	
###################################################################
# For any questions or inquiries regarding the use of this script, 
# please feel free to contact  jorgec@fq.edu.uy.
###################################################################
