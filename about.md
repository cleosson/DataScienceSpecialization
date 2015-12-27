---
title: "Documentation"
output: html_document
---

Welcome to the "Select the best car for your trip" app, that was developed for the Developing Data Products Course, from Coursera. This app helps you to choose a car for a trip, using the [mtcars](https://stat.ethz.ch/R-manual/R-devel/library/datasets/html/mtcars.html) dataset from [R]. 

First, you need to inform the distance of your trip and the price of gasoline in your region. These information will be used to calculate the Gasoline Costs for each car in the dataset. 

Second, you can choose some caractheristcs of the cars that you desire: Cylinders, Gears, Carburetors, Horse Power and Transmission.

The table will show only the cars with the filters selected. You can sort the table according to the variable you want by clicking the arrows at the top of the table.

The plot show the best three cars.

Source code for ui.R and server.R files are available on the [GitHub](https://github.com/cleosson/DevelopingDataProductsProject).