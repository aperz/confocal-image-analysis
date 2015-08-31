// macro takes in channel 1 and 2 and returns image of colocalised stain and mesurement of total colocalised area per as many pixels / um

args = getArgument();

processFile(args);

function processFile(args) {
	file1 = args;
	file2 = replace(args, "C1-", "C2-");
	print(file1);
	print(file2);

	open(file1);
	open(file2);

	// only colocalised
	run("Colocalization Threshold", "channel_1=file1 channel_2=file2 use=None channel=[Red : Green] show");
	selectWindow("Results");
	close();
	selectWindow("Colocalized Pixel Map RGB Image");
	run("RGB Measure Plus", "red_threshold_min=1 red_threshold_max=255 green_threshold_min=1 green_threshold_max=255 blue_threshold_min=1 blue_threshold_max=255");
	

	//run("Split Channels");
	//selectWindow("Colocalized Pixel Map RGB Image (blue)");
	//run("Make Binary");	

	// measure
	new_path=replace(file1, "convert", "colocalisation")
	run("Save", "save=new_path");
	saveAs("Results", new_path+"_coloc.tsv");
	
	//while (nImages>0) { 
	//	selectImage(nImages); 
	//close(); 
	//} 
}
run("Quit");