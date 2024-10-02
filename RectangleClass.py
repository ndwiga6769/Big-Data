import matplotlib.pyplot as plt

class Rectangle(object):
    
    # Constructor
    def __init__(self, width=8, height=3, color='red'):
                self.width = width
                self.heght = height
                self.color = color    # Method
    def drawRectangle(self):
        plt.gca().add_patch(plt.Rectangle((0, 0), self.width, self.height ,fc=self.color))
        plt.axis('scaled')
        plt.show()