all:
	ln -s "$$(pwd)/.zshrc" "$$HOME/.zshrc"
	ln -s "$$(pwd)/.zsh_aliases" "$$HOME/.zsh_aliases"
	mkdir -p ~/.zsh
	git clone https://github.com/zsh-users/zsh-autosuggestions ~/.zsh/zsh-autosuggestions

force:
	ln -sf "$$(pwd)/.zshrc" "$$HOME/.zshrc"
	ln -sf "$$(pwd)/.zsh_aliases" "$$HOME/.zsh_aliases"
	rm -rf ~/.zsh
	mkdir ~/.zsh
	git clone https://github.com/zsh-users/zsh-autosuggestions ~/.zsh/zsh-autosuggestions

.PHONY: all force
