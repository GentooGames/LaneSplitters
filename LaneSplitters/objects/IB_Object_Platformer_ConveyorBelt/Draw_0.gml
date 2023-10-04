// obj_conveyor_belt.draw //
event_inherited();
draw_self();
draw_text(x, y, "vx: " + string(mover.velocity_x_get(true)));
