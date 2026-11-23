include /lib/ix/help.mk
.PHONY: users shells network prompt

users: ## Read the local account table
	@cut -d: -f1,3,6,7 passwd
shells: ## Read the login shell list
	@cat shells
network: ## See interfaces, routes and name servers
	@ip addr
	@ip route
	@cat resolv.conf
prompt: ## Read the Bash startup file, including make completion
	@cat bashrc
