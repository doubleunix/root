include /lib/ix/help.mk
.PHONY: users network genesis

users: ## See who lives here
	@cut -d: -f1,3,6,7 passwd
network: ## Read the routes and name servers
	@ip addr && ip route && cat resolv.conf
genesis: ## Read the first lines
	@cat genesis
