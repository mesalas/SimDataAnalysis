import unittest
from plot_price import plot_price


class TestCase(unittest.TestCase):
    def test_plot_bars(self):
        test_args = ["test_data/daily_bars.png","test_data/ABC_NYSE@0_daily_bars.csv","test_data/DEF_NYSE@0_daily_bars.csv"]
        plot_price(test_args)


if __name__ == '__main__':
    unittest.main()
