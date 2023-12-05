/*import 'package:chaquopy/chaquopy.dart';

void runPythonScript() async {
  await Chaquopy.executeCode("""
    import matplotlib.pyplot as plt
    import numpy as np
    
    # Generate data
    x = np.linspace(0, 2 * np.pi, 100)
    y = np.sin(x)
    
    # Create a figure and axis
    fig, ax = plt.subplots()
    
    # Plot the data
    ax.plot(x, y)
    
    # Add circles at specific positions
    positions = [(0.5, 0.2), (1.5, -0.3), (2.0, 0.7)]
    colors = ['red', 'green', 'blue']
    radii = [0.1, 0.15, 0.2]
    
    for (x_pos, y_pos), color, radius in zip(positions, colors, radii):
        circle = plt.Circle((x_pos, y_pos), radius, color=color, alpha=0.5)
        ax.add_artist(circle)
    
    # Set plot title and labels
    ax.set_title('Sine Wave with Circles')
    ax.set_xlabel('X')
    ax.set_ylabel('Y')
    
    # Save the plot as an image
    plt.savefig('output.png')
    
    # Print a message
    print('Plot generated and saved as output.png')
  """);
}
*/