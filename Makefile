all:
	ln -s "$$(pwd)/.zshrc" "$$HOME/.zshrc"
	ln -s "$$(pwd)/.zsh_aliases" "$$HOME/.zsh_aliases"

force:
	ln -sf "$$(pwd)/.zshrc" "$$HOME/.zshrc"
	ln -sf "$$(pwd)/.zsh_aliases" "$$HOME/.zsh_aliases"

.PHONY: all force
