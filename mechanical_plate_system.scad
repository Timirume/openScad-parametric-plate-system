// ============================================================================
// PROJECT: PARAMETRIC BORED & STUDDED PLATE SYSTEM
// AUTHOR: Timothy Okibe Ogese
// SOFTWARE: OpenSCAD
// ============================================================================

$fn = 40;
clearance = 0.2;

module bored_plate(size, hole_dia, hole_margin, hole_count = [2,2]) {
    if (hole_count.x == 0 || hole_count.y == 0) {
        cube(size);
    } else {
        difference() {
            cube(size);
            main_dia = hole_dia + (2 * clearance);
            abs_margin = hole_margin + main_dia / 2;

            hole_spacing_x = hole_count.x > 1 ? (size.x - 2 * abs_margin) / (hole_count.x - 1) : 0;
            hole_spacing_y = hole_count.y > 1 ? (size.y - 2 * abs_margin) / (hole_count.y - 1) : 0;

            x_values = [abs_margin : hole_spacing_x : size.x - abs_margin + 0.1];
            y_values = [abs_margin : hole_spacing_y : size.y - abs_margin + 0.1];

            for (x = x_values, y = y_values)
                translate([x, y, -1])
                    cylinder(d = main_dia, h = size.z + 2);
        }
    }
}

module studded_plate(size, stud_dia, stud_height, stud_margin, stud_count = [2,2]) {
    if (stud_count.x == 0 || stud_count.y == 0) {
        cube(size);
    } else {
        union() {
            cube(size);
            abs_margin = stud_margin + stud_dia / 2;

            stud_spacing_x = stud_count.x > 1 ? (size.x - 2 * abs_margin) / (stud_count.x - 1) : 0;
            stud_spacing_y = stud_count.y > 1 ? (size.y - 2 * abs_margin) / (stud_count.y - 1) : 0;

            x_values = [abs_margin : stud_spacing_x : size.x - abs_margin];
            y_values = [abs_margin : stud_spacing_y : size.y - abs_margin];

            for (x = x_values, y = y_values)
                translate([x, y, size.z - 0.01])
                    cylinder(d = stud_dia, h = stud_height);
        }
    }
}

// EXAMPLE USAGE
translate([0, 0, 30])
    bored_plate(size=[110, 50, 5], hole_dia=6, hole_margin=4, hole_count=[4,4]);

studded_plate(size=[110, 50, 5], stud_dia=6, stud_height=4, stud_margin=4, stud_count=[4,4]);
