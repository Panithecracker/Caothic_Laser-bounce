# Order-from-Chaos-Tracing-Laser-Trajectories
Exploring analytically and visually the chaotic behaviour of a laser bouncing off the walls of an elliptcal white cell.
In laser physics, a "white cell" is a mirror system that acts as a delay line for the laser beam. The beam enters the cell, bounces around on the mirrors, and eventually works its way back out
## Mathematical problem that motivates this project ::
Each time the laser beam hits the surface of the ellipse, it follows the usual law of reflection "angle of incidence equals angle of reflection." That is, both the incident and reflected beams make the same angle with the normal line at the point of incidence.
The normal line is perpendicular to this tangent line at the point of incidence.
So an interesting question is : How many times does the beam hit the internal surface of the white cell before exiting given the initial hit coordinate and starting position for the beam as initial conditions??
## Project Overview

This project explores the chaotic behavior of light inside an elliptic white cell, bouncing off the walls until it exits the ellipse. Despite the seemingly random paths that the laser beam can take, there is a surprising order and symmetry to the system that we can uncover through our simulation.

The simulation allows users to observe the intricate patterns that emerge as the laser beam bounces off the walls of the ellipse, revealing the hidden order that underlies the chaotic motion. The program works for any situation in which a laser can enter the white cell, with the only required inputs being the starting point of the laser beam and the first point of impact inside the elliptic cell. Additionally, the simulation calculates the total number of reflections made by the laser before it escapes, providing insight into the complexity of the system.

**The cell is defined by the equation 4x^2 + y^2 = 100 and the opened region is the one for which -0.01 <= x <= 0.01**

## Features
- Visualization of laser beam trajectory inside the elliptic white cell
- Counter of the total number of reflections until the beam exits the ellipse
- Customization of initial conditions for the laser beam (starting point and first hit coordinates)
- Last trajectory inside the cell is colored in green
- The program generates a video of the animation in an avi file

## Examples: 
- **Results for starting point (0,10.1) and first impact at the point (1.4,-9.6) :**

![(-5,0)case](https://user-images.githubusercontent.com/97905110/229291183-ee044948-c26c-4233-b4a4-f74a0802c31d.gif) 

![2023-04-01 (1)](https://user-images.githubusercontent.com/97905110/229292082-e30a025b-967d-47fc-b36c-c9a6f001b6a5.png)
