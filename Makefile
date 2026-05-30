export PATH := $(HOME)/Library/Python/3.13/bin:$(PATH)

install-deps:
	ansible-galaxy install -r requirements.yml

setup:
	ansible-playbook playbook.yml -i inventory.ini

deploy:
	ansible-playbook playbook.yml -i inventory.ini --tags deploy

vault-encrypt:
	ansible-vault encrypt group_vars/webservers/vault.yml

vault-decrypt:
	ansible-vault decrypt group_vars/webservers/vault.yml

vault-edit:
	ansible-vault edit group_vars/webservers/vault.yml
