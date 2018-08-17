#!/usr/bin/python3

import tkinter as tk
from window import Window

def main():
	main_object = Window("Website Generator", 800, 600)
	main_object.establish_window_parameters()

	main_object.looper()

main()
