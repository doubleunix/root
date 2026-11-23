include /lib/ix/help.mk
.PHONY: passwd ip genesis

passwd: ## List usernames, UIDs, home directories, and shells
	@cut -d: -f1,3,6,7 passwd
ip: ## Show IP addresses, routes, and DNS configuration
	@ip addr && ip route && cat resolv.conf
genesis: ## Read /etc/genesis
	@cat genesis
