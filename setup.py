#!/usr/bin/python
# -*- coding: UTF-8 -*-
import os
import math
import argparse

# UTILITY -~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-

def report(message):
	cols = int(shell('stty size').split()[1])
	numDashes = cols - len(message)
	dashes = '-' * numDashes
	mid = numDashes / 2
	print "{0}{1}{2}".format(dashes[:mid], message, dashes[mid:])

def positive_report(message):
	report("✅\ {0}".format(message))

def pending_report(message):
	report("🤔\ {0}".format(message))

def error_report(message):
	report("❌\ {0}".format(message))

def shell(command):
	v = os.popen(command, 'r').read()
	# print command
	# print v
	return v

def ask_for_affirmative(question):
	return raw_input(
						"{0} [Y/N] "
						.format(question)
					).lower() in ["yes", "y"]

# Targets -~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-

class Target:
	def __init__(self, name):
		self.name = name
	def __str__(self):
		return self.name
	def __repr__(self):
		return self.__str__()
	def is_installed(self): 
		raise ValueError("not implemented.")
	def install(self): 
		raise ValueError("not implemented.")

class Shell(Target):
	def __init__(self, command): 
		Target.__init__(self, "Run: {0}".format(command))
		self.command = command;
		self.installed = False

	def is_installed(self):
		return self.installed		
	def install(self):
		# TODO, return values?
		self.installed = True
		return shell(self.command)

class ConditionalShell(Target):
	def __init__(self, name):
		Target.__init__(self, name)
		self.check_command = "{0}"
		self.install_command = "{0}"

	# Installed if check_command has any output.
	def is_installed(self):
		return len(shell(self.check_command.format(self.name))) != 0

	def install(self):
		return shell(self.install_command.format(self.name))

class ConditionalShellValue(ConditionalShell):
	def __init__(self, name, value): 
		ConditionalShell.__init__(self, name)
		self.value = None
		self.check_command = None
		self.install_command = None

	# Installed if check_command produces self.value
	def is_installed(self):
		if not self.check_command:
			raise ValueError("No check_command.")
		return shell(self.check_command).strip() == self.value

	def install(self):
		if not self.install_command:
			raise ValueError("No install_command.")
		return shell(self.install_command)

class ApplePlist(ConditionalShellValue):
	def __init__(self, name, plist, var, value): 
		ConditionalShellValue.__init__(self, name, value)
		self.value = value
		self.check_command = "defaults read {0} {1}".format(plist, var)
		self.install_command = "defaults write {0} {1} {2}".format(plist, var, value)

class BrewFormula(ConditionalShell):
	def __init__(self, name): 
		ConditionalShell.__init__(self, name)
		self.check_command = "brew ls --versions {0}"
		self.install_command = "brew install {0}"

class BrewCaskFormula(ConditionalShell):
	def __init__(self, name): 
		ConditionalShell.__init__(self, name)
		self.check_command = "brew cask ls --versions {0}"
		self.install_command = "brew cask install {0}"


# MAIN  -~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-

targets = [
	BrewFormula("tree"),
	BrewFormula("the_silver_searcher"),
	BrewFormula("unrar"),

	BrewCaskFormula("google-chrome"),
	BrewCaskFormula("sublime-text"),
	BrewCaskFormula("iterm2"),
	BrewCaskFormula("spectacle"),
	BrewCaskFormula("unity"),

	ApplePlist("Show only active apps in dock", "com.apple.dock", "static-only", "1"),
	Shell("killall dock"),

	Shell("sudo systemsetup -setcomputersleep 30 > /dev/null")
]

def main():

	args = get_args()
	brew_only = bool(args.brew)

	for t in targets:
		if brew_only and not any([isinstance(t, clazz) for clazz in [BrewFormula, BrewCaskFormula]]):
			continue

		if t.is_installed():
			report(str(t))
		else:
			report(str(t))
			print t.install()
			if t.is_installed() :
				positive_report("")
			else:
				error_report(t)


def get_args():
	parser = argparse.ArgumentParser()
	parser.add_argument('--brew', action='store_true')
	return parser.parse_args()

if __name__ == "__main__":
	main()



