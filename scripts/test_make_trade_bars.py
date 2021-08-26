import unittest
from make_daily_trade_bars import make_trade_bars

class TestCase(unittest.TestCase):
    def test_read_trades_write_bars(self):
        test_args = ["test_data/ABC_NYSE@0_Matching-MatchedOrders.csv",
                     "test_data/ABC_NYSE@0_daily_bars.csv"]
        make_trade_bars(test_args)

if __name__ == '__main__':
    unittest.main()
