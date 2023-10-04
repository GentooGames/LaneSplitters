
	// fade to death
	if (image_alpha > 0) {
		image_xscale += 0.05;
		image_yscale += 0.05;
		image_alpha  -= 0.01;
		y			 -= 1;
	}
	else {
		instance_destroy();	
	}
	
	depth = -y;