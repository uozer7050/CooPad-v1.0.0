"""
PyInstaller hook for tkinter package.

This hook ensures that tkinter and its native dependencies (_tkinter.so, libtk, libtcl)
are properly included in the PyInstaller bundle when building on Linux.
"""
from PyInstaller.utils.hooks import collect_submodules
import sys

# Collect all tkinter submodules
hiddenimports = collect_submodules('tkinter')

# On Linux, ensure _tkinter is explicitly imported
if sys.platform.startswith('linux'):
    try:
        import _tkinter
        print(f"Found _tkinter at: {_tkinter.__file__}")
    except ImportError as e:
        print(f"Warning: Could not import _tkinter: {e}")
