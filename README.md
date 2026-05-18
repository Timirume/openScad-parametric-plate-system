# Parametric Bored & Studded Plate System
A modular, fully parametric mechanical alignment system designed in OpenSCAD. This library provides a procedural approach to generating matching interlocking plates—one with a grid of holes (bored) and one with a grid of raised pins (studded). 
It is optimized for mechanical prototyping, press-fit assemblies, LEGO-style modular design, and 3D printing workflows.
## Features
* **Fully Parametric Architecture:** Instantly scale plate dimensions, thickness, component spacing, and grid counts by altering standard parameters.
* **Built-in Print Tolerance:** Includes a globally adjustable `clearance` offset applied to hole diameters to compensate for real-world plastic expansion during 3D printing.
* **Automatic Grid Spacing:** The layout math automatically calculates spacing between items uniformly based on your defined margins, preventing out-of-bounds or edge clipping.
* **Robust Edge-Case Checks:** Built-in validation handles single-element configurations ($1 \times 1$ grids) and reverts seamlessly to solid plates if a count of zero is input.
---
## Technical Specifications & Modules
### 1. `bored_plate()`
Generates a solid base plate and utilizes a `difference()` boolean subtraction to array precise cylindrical voids.
* **Key Logic:** Voids are offset by $2 \times \text{clearance}$ and translated marginally past the Z-axis boundary to ensure perfectly clean boolean passes through the model.
### 2. `studded_plate()`
Generates a solid base plate and utilizes a `union()` boolean operation to fuse an array of raised positioning pins onto the top surface face.
---
## Parameters Reference

| Parameter | Type | Description |
| :--- | :--- | :--- |
| `size` | Vector `[X, Y, Z]` | The total bounding dimensions of the base plate. |
| `hole_dia` / `stud_dia` | Number | Base nominal diameter of the fitting cylinders. |
| `hole_margin` / `stud_margin` | Number | Clear distance from the outermost plate edges to the perimeter of the nearest cylinder. |
| `hole_count` / `stud_count` | Vector `[X, Y]` | The quantity of elements to generate along the X and Y grid lines. |
| `stud_height` | Number | Vertical extension height of alignment pins. |
| `clearance` | Number | Global additive clearance parameter (applied to holes) to secure perfect physical press-fits. |

---
## Quick Start & Usage Example
To instantiate a matching pair of $4 \times 4$ alignment plates separated dynamically on your viewport, use the boilerplate configuration below:
```openscad
// Top Fitting Plate (Bored)
translate([0, 0, 30])
    bored_plate(
        size        = [110, 50, 5],
        hole_dia    = 6,
        hole_margin = 4,
        hole_count  = [4, 4]
    );
// Bottom Base Plate (Studded)
studded_plate(
    size         = [110, 50, 5],
    stud_dia     = 6,
    stud_height  = 4,
    stud_margin  = 4,
    stud_count   = [4, 4]
);
