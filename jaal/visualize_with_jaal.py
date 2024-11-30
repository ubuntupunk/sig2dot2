import pandas as pd
from jaal import Jaal

# Load the nodes and edges data from CSV files
def load_data():
    nodes = pd.read_csv('nodes.csv')
    edges = pd.read_csv('edges.csv')
    return nodes, edges

# Visualize the network using Jaal
def visualize():
    nodes, edges = load_data()
    Jaal(nodes, edges).plot()

if __name__ == "__main__":
    visualize()
