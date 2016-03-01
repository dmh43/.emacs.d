# -*- mode: snippet; require-final-newline: nil -*-
# name: Unit Test
# key: 
# binding: direct-keybinding
# --

from nose2.compat import unittest

class FuncTest(unittest.TestCase):
    def setUp(self):
        pass
    
    def tearDown(self):
        pass
    
    def test_func(self):
        
        
        
if __name__ == '__main__':
    unittest.main()
