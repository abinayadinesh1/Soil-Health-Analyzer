# Soil Health Analyzer
## Motivation
Soil health on a farm, garden, or even a tiny pot is a complex matrix dependent on the texture of the soil (its clay, silt, sand proportions), water content, organic matter, nutrients and microbial diversity. However, the most expensive factors for a farmer are water and fertilizer: is there a way we can optimize usage of these resources to cut costs and maintain crop yields, while slowly building back inherent fertility? Yes, and it only takes an image. 

## Software Architecture
The user interface with the app is built entirely in SwiftUI. Here, a farmer can set up a new 'plot' on the app where they will upload representative samples of the soil in their field, organized by the type of plant it is. At home gardeners can use it the same way, now uploading pictures of their pot, raised bed, or at home garden. 

The user uploads an image of the soil right under their plant of interest, which gets added to the list of samples for that plant. This triggers an AWS Lambda Function where I've loaded a custom script in Python that uses OpenCV to analyze the color space of this set of images and generate the statistics and graph for the plant. Then, I made a custom  AWS Gateway API to send images and statistics back down to the app, where they will populate for the associated plant in the app. Currently, recommendations are handwritten based off of retention and decomposition rates, but in future implementations I will use LLMS to generate a more specific, automated description. 

## Hardware Architecture
It is unrealistic to ask a farmer, gardener, or busy human to take pictures of their plants every 3, 6, or 12 hours. Moreover, the lighting and camera variability leads to extremely noisy and untrustworthy image results. 

Therefore, I implemented a hardware portion to this app to automate taking images.
### Materials
1. 3D printed acrylic box, to create a completely dark environment 
2. Raspberry Pi
3. Arducam Regular (for RGB images)
4. Arducam NoIR (to take images in RGB and IR)
5. LED white light source (produces flash for every photo for consistent lighting)

This setup is still being perfected, but already proven to have more consistent results than phone pictures. Some considerations for the future would be waterproofing the setup, ensuring longevity of the wires and sensors, and dipping into PCB design to make a cheaper circuit system. After considerable research on the best hardware for this, it would be great to have an accurate water sensor to cross reference with the color information. 

## Extension
As part of a project for CS 194, Computational Color, with Professor Ren Ng at Berkeley, I am developing a novel 5 channel camera. With this completed, I would be able to take pictures simultaneously in UV, RGB, and IR which might provide interesting insights into microbial diversity of the soil. 

## Screenshots
![Simulator Screenshot - iPhone 14 Pro - 2023-09-29 at 12 32 06](https://github.com/abinayadinesh1/Soil-Health-Analyzer/assets/29685826/86149313-b263-43c9-9cf7-eca3b1355081)
![Simulator Screenshot - iPhone 14 Pro - 2023-09-29 at 17 39 16](https://github.com/abinayadinesh1/Soil-Health-Analyzer/assets/29685826/e2dcd507-8597-4051-97c3-a0c4c3e38cf9)
![Simulator Screenshot - iPhone 14 Pro - 2023-09-29 at 17 39 29](https://github.com/abinayadinesh1/Soil-Health-Analyzer/assets/29685826/f693fbc9-8d3e-4a63-8675-4257e8cb9c7b)
![Simulator Screenshot - iPhone 14 Pro - 2023-09-29 at 17 39 36](https://github.com/abinayadinesh1/Soil-Health-Analyzer/assets/29685826/da9efa60-bb29-4be0-9e4d-cb0fa2294dde)
![Simulator Screenshot - iPhone 14 Pro - 2023-09-29 at 17 39 43](https://github.com/abinayadinesh1/Soil-Health-Analyzer/assets/29685826/d3b7ec43-10c0-4d1c-8b79-754ca6621fde)
![Simulator Screenshot - iPhone 14 Pro - 2023-09-29 at 17 39 53](https://github.com/abinayadinesh1/Soil-Health-Analyzer/assets/29685826/ae52c5b0-d2d0-4a3f-a1f4-b380aa1907a6)
