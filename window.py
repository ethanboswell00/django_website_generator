import tkinter as tk
import subprocess as sp

class Window:
	def __init__(self, window_title, width, height):
		self.title = window_title
		self.width = width
		self.height = height

		self.root = tk.Tk()
		self.server_started = tk.IntVar()
		self.root.title(self.title)
		self.main_frame = tk.Frame(width=self.width, height=self.height, bd=1, relief=tk.SUNKEN)
		self.user_label_one = tk.Label(self.main_frame, text="Enter Website Name: ")
		self.user_label_two = tk.Label(self.main_frame, text="Enter Port Number: ")

		self.user_input_one = tk.Entry(self.main_frame, width=25)
		self.user_input_two = tk.Entry(self.main_frame, width=25)

		self.start_server_check = tk.Checkbutton(self.main_frame, text="Start Server Now?", variable=self.server_started)

		self.submit_button = tk.Button(self.main_frame, text="Submit", width=25, command=self.create_website)

		self.quit_button = tk.Button(self.root, text="Quit", width=25, command=self.root.destroy)

	def establish_window_parameters(self):
		self.main_frame.pack(fill=tk.X, padx=5, pady=5)
		self.submit_button.pack(side=tk.BOTTOM)
		self.quit_button.pack(side=tk.RIGHT)
		self.user_label_one.pack()
		self.user_input_one.pack()
		self.user_label_two.pack()
		self.user_input_two.pack()
		self.start_server_check.pack()

	def looper(self):
		self.root.mainloop()

	def create_website(self):
		string = "bash makesite.sh " + self.user_input_one.get() + " " + self.user_input_two.get() + " "

		if self.server_started:
			string += "1"
		else:
			string += "0"

		sp.call(string, shell=True)
