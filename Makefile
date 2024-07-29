all:
	ln -s "$$(pwd)/.zshrc" "$$HOME/.zshrc"

force:
	ln -sf "$$(pwd)/.zshrc" "$$HOME/.zshrc"

.PHONY: all force
