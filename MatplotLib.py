import matplotlib.pyplot as plt

# Sample data
x = [1, 2, 3, 4, 5]
y1 = [10, 20, 25, 30, 35]
y2 = [15, 18, 22, 27, 33]

# Create a line plot
plt.plot(x, y1, label='Line 1', color='blue', marker='o')  # First line
plt.plot(x, y2, label='Line 2', color='green', linestyle='--', marker='s')  # Second line

# Add title and labels
plt.title('Sample Line Plot')
plt.xlabel('X Axis')
plt.ylabel('Y Axis')

# Add a legend
plt.legend()

# Display the plot
plt.show()
