<a rel="license" href="http://creativecommons.org/licenses/by/4.0/"><img alt="Creative Commons License" style="border-width:0" src="https://i.creativecommons.org/l/by/4.0/88x31.png" /></a><br />This work is licensed under a <a rel="license" href="http://creativecommons.org/licenses/by/4.0/">Creative Commons Attribution 4.0 International License</a>.


# Reservoir Water Quality and Climate Change: Web-Based Hydrophysical Simulations

## Project Overview

This project investigates the impacts of climate change on reservoir water quality, focusing on thermal stratification and mixing dynamics using hydrophysical simulations. A user-friendly **web-based application** was developed using the R package **Shiny**, integrated with the **General Lake Model (GLM)**, to make these simulations accessible to a wide range of users.

The study was conducted on the **Grosse Dhünn Reservoir**, the second-largest drinking water reservoir in Germany, under various climate change scenarios.

---

## Goals

- Providing an **interactive tool** for analyzing the hydrophysical properties of reservoirs.
- Allowing **users of all technical backgrounds** to simulate thermal stratification under varying climate conditions.
- Exploring and visualize the effects of different **climate change scenarios** on water quality.

---

## Features

### 1. **User Interface**
The web application includes:
- **Interactive controls** for scenario selection (e.g., air temperature, wind factor, rain factor).
- **Graphical visualizations** of thermal stratification and water temperature variations.
- **Real-time outputs** of simulation results, including temperature profiles and Schmidt stability indices.

![User Interface](https://github.com/niloysamadder/Hydrophysical-Simulation-of-Lake-Water-/blob/88926191a28a0230c1787805c77c0c7f1e08c3a9/User%20Interface.PNG)

### 2. **Climate Change Scenarios**
Simulations consider Representative Concentration Pathway (RCP) scenarios:
- **RCP 4.5 (Moderate emissions)**  
- **RCP 8.5 (High emissions)**  

### 3. **Key Metrics**
- **Water temperature profiles** at varying depths.
- **Schmidt stability values**, representing resistance to mixing.
- **Thermal stratification dynamics** under climate stressors.

---

## Methodology

1. **Study Site**  
   - **Location**: Grosse Dhünn Reservoir, Germany.  
   - **Features**: 81 million m³ capacity, 53 m maximum depth.  

2. **Tools Used**  
   - **General Lake Model (GLM):** A 1D hydrodynamic model for temperature and density simulations.  
   - **RShiny:** For developing the interactive web application.  
   - **R Lake Analyzer:** For computing metrics like thermal layers, thermocline depth, and Schmidt stability.  

3. **Climate Variables Simulated**  
   - Air temperature  
   - Wind speed  
   - Rainfall
   - Short Wave
   - Long Wave
   - Relative Humidity  

---

## Key Insights

- **Warming Effects**:  
  - Surface water temperatures may increase by up to **4°C** under high-emission scenarios (RCP 8.5).  
  - Bottom water temperatures exhibit a slower but notable rise, up to **2°C**.

  ![Difference in Surface Temperature](https://github.com/niloysamadder/Hydrophysical-Simulation-of-Lake-Water-/blob/88926191a28a0230c1787805c77c0c7f1e08c3a9/Image%202D%20of%20Lake%20stratification%20with%20changed%20atmospheric%20temperature.png)

- **Stratification Changes**:  
  - Extended and intensified stratification periods are predicted, increasing resistance to mixing.  

- **Schmidt Stability**:  
  - Stability values significantly rise under warmer conditions, implying greater energy requirements for mixing.

  ![Schimdt Stability](https://github.com/niloysamadder/Hydrophysical-Simulation-of-Lake-Water-/blob/88926191a28a0230c1787805c77c0c7f1e08c3a9/Schmidt%20Stability.png)

---

## Future Work

- Expand the model to include additional **meteorological and hydrological parameters**.  
- Simulate a broader range of **climate change scenarios**.  
- Enhance the web interface for improved user experience and scalability.  

---

## How to Run the Application

1. Clone this repository:
   ```bash
   git clone https://github.com/niloysamadder/Hydrophysical-Simulation-of-Lake-Water.git
   cd Reservoir-Water-Quality
   ```

2. Install the required R packages:
   ```R
   install.packages(c("shiny", "glmtools", "lakeanalyzer"))
   ```

3. Run the application:
   ```R
   shiny::runApp()
   ```

---
**Developed By:**  
Niloy Samaddar 

----
## Acknowledgments

This project was conducted as part of the curriculum at **TU Dresden** under the supervision of **Dr. Thomas Petzoldt** and **Johannes Feldbauer**.

---
