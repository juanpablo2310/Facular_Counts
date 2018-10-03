# Facular Counter

Matlab base tool for storage latitude positions of Solar Faculae as a matrix in which the rows are the dates of the observed data and the columns are latitude intervals 10 grades long, data is gather inside a matrix as output in .m and .txt format

## Getting Started

![Interface Image](interface.png)

Program Interface, from left to right :
#### Reset buttons
NAN all: puts all the inputs as NAN value \\\
Zero all : puts all the inputs as zero value

#### Navegation Panel
In the middle of the interface, shows the date in which the data will be recorded, the date can be changed by directly introducing it or by tweaking it using the navigation buttons  (going from 1ts of january of 1883 to 31st of december of 1930)

#### Administration buttons
SaveTex : Save the matrix as a .txt file \\\
SaveMat : Save the matrix as a .m file \\\
LoadFile : Loads previous .m file \\\
Quit : Exit the user from the aplication generating a backup file automatically

#### Counting Panel
Here is recorded and display the counting of Solar faculae per latitude interval, the first panel display the number, in the case that no observation had taken place that day we left all entries as NANs, for adding (subtracting) faculaes to each interval right (left) click  with the mouse over the interval buttons, for restarting de count for an individual interval click the zero button, for become an individual entry a NAN object click the NAN button  


### Prerequisites

Facular_Counts.m needs 3 backup files (provided with the code) and Matlab's 2016 version or higher 




## Built With

* [MATLAB](https://www.mathworks.com/products/matlab.html) 





## Authors

* **Juan Pablo Vargas-Acosta** - *Initial work* - [juanpablo2310](https://github.com/juanpablo2310)
* **Andres Muñoz-Jaramillo** - *Initial work* - [amunozj](https://github.com/amunozj)



## License

This project is licensed under the general public licence


