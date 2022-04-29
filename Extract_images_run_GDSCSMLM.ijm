path= newArray(1);	


// All paths go below:

path[0]="\\\\chem-mh-store\\D\\Members\\Mathew Horrocks\\Data\\Array_Tomography_New_NB\\AD_1in100SynaptophysinAF488_2nMUCB0107AF647_pos1_3\\pos_0\\"


for (i=0; i<path.length; i++){
dir=path[i];

// Open first image

stem="posZ0.tif";
processFiles(dir,stem);
rename("stack");
// Extract the synaptophysin from the first image
makeRectangle(0, 0, 428, 684);
// Duplicate just the synaptophysin side
run("Duplicate...", "duplicate range=201-210");
// Z-project
run("Z Project...", "projection=[Average Intensity]");
saveAs("Tiff", dir+"synaptophysin.tif");
close();
close();


makeRectangle(428, 0, 856, 684);
run("Duplicate...", "duplicate");
selectWindow("stack");
close();

stem="posZ0_1.tif";
processFiles(dir,stem);
rename("stack");
makeRectangle(428, 0, 856, 684);
run("Duplicate...", "duplicate");
selectWindow("stack");
close();

stem="posZ0_2.tif";
processFiles(dir,stem);
rename("stack");
makeRectangle(428, 0, 856, 684);
run("Duplicate...", "duplicate");
selectWindow("stack");
close();

stem="posZ0_3.tif";
processFiles(dir,stem);
rename("stack");
makeRectangle(428, 0, 856, 684);
run("Duplicate...", "duplicate");
selectWindow("stack");
close();

stem="posZ0_4.tif";
processFiles(dir,stem);
rename("stack");
makeRectangle(428, 0, 856, 684);
run("Duplicate...", "duplicate");
selectWindow("stack");
close();


run("Concatenate...", "all_open title=[Concatenated Stacks]");		// Join all of the images together

saveAs("Tiff", dir+"Tau.tif");


// Super-resolution section

config_file="C:\\Users\\mhorrock\\gdsc.smlm.settings.xml";			// This is where the GDSCSMLM cofig. file is saved. This can be found by running the fit peaks command. 
pixel_size=117;			// Size of each pixel in nm
exposure=50;			// Exposure time
precision_thresh=20;	// Precision threshold.
signal_thresh=30;		// Signal threshold.

run("Peak Fit", "template=[None] config_file="+config_file+" calibration="+pixel_size+" gain=2.17 exposure_time="+exposure+" initial_stddev0=2.000 initial_stddev1=2.000 initial_angle=0.000 spot_filter_type=Single spot_filter=Mean smoothing=0.50 search_width=2.50 border=1 fitting_width=3 fit_solver=[Least Squares Estimator (LSE)] fit_function=Circular fail_limit=10 include_neighbours neighbour_height=0.30 residuals_threshold=1 duplicate_distance=0.50 shift_factor=2 signal_strength="+signal_thresh+" min_photons=0 min_width_factor=0.50 width_factor=2 precision="+precision_thresh+" results_table=Uncalibrated image=[Localisations (width=precision)] image_precision=5 image_scale=8 results_dir="+dir+" results_in_memory camera_bias=0 fit_criteria=[Least-squared error] significant_digits=5 coord_delta=0.0001 lambda=10.0000 max_iterations=20 stack");
saveAs("Tiff", dir+"Tau_super_res.tif");
close();
selectWindow("Fit Results");
saveAs("text",dir+"FitResults.txt");
run("Close");
close();

	
}

function processFiles(dir,stem) 

	{

	list = getFileList(dir);

		for (i=0; i<list.length; i++)

		 {

		if (!startsWith(list[i],"Log"))

			{

			if (endsWith(list[i], "/"))

		              processFiles(""+dir+list[i]);

         			 else 

			{

		            // showProgress(n++, count);

            			path = dir+list[i];

	            		processFile(path,stem);

			}

			}

		}

	}

function processFile(path,stem) 

	{
		       	if (endsWith(path, stem) ) 
 
		{
			
			open(path);
			


		}
	}