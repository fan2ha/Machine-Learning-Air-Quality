# Machine Learning Air Quality

**Introduction:**

Process-based numeric atmospheric models follow explicit algorithms among spatial grids and temporal steps. They are more interpretable and widely accepted, while at the cost of more stringent standards for data acquisition and higher computational cost. Increasingly intensive availability of meteorological and emission inventory data made it possible to explore the capability of data-driven machine learning models in air quality prediction. For decades, machine learning has been enriched by novel training patterns and corresponding data normalization techniques. LSTM (Long-Short Term Memory) is one of the most popular recursive deep learning algorithms. Apart from feed-forward neural networks or convolutional deep neural networks specializing in regression prediction and computer vision, LSTM is extremely powerful in handling time series data structures. In cases where decision-making focuses on more on quick and precise prediction while disregarding interpretabilities, LSTM machine learning models will become a competitive option.

This project is a continuation of previous contributions from Dr. Fernando Garcia Menendez’s Lab. The model is already capable of predicting ozone concentration in the upcoming 24 hours using 30 hours’ data prior as input. There is still room for improvement in terms of precision. Another unique feature of the model is it considers relative locations of target points of interest from monitoring stations as its default explanatory variables.

**Fig 1. 4-dimensional tensor structure**
<p align="center">
  <img src="Images/Model_Structure_1.PNG">
</p>

**Fig 2. LSTM model structure**
<p align="center">
  <img src="Images/Model_Structure_2.png">
</p>

**Fig 3. Interactive plots example**
<p align="center">
  <img src="Images/Widget.png">
</p>
