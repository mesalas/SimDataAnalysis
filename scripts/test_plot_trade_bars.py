import unittest
from plots import plot_price

class TestCase(unittest.TestCase):
    def test_plot_bars(self):
        test_args = ["test_data/ABC_NYSE@0_daily_bars.csv", "out"]
        plot_price(test_args)

if __name__ == '__main__':
    unittest.main()
