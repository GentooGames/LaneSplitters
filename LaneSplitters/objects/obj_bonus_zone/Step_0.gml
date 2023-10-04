
	if (blinking) {
		blink_timer++;
		if (blink_timer > blink_time) {
			blinking = false;	
		}
		if (iceberg.time.do_every_frame(blink_rate)) {
			visible = !visible;	
			if (visible) {
				audio_play_sound(sfx_bonus_zone, 1, false);
			}
		}
	}
	else {
		visible = true;	
	}
	
	depth = objc_world.depth + 1;