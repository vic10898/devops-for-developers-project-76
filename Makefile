export PATH := $(HOME)/Library/Python/3.13/bin:$(PATH)
VAULT_FLAGS := --vault-password-file .vault-password

install-deps:
	ansible-galaxy install -r requirements.yml

setup:
	ansible-playbook playbook.yml -i inventory.ini $(VAULT_FLAGS)

deploy:
	ansible-playbook playbook.yml -i inventory.ini --tags deploy $(VAULT_FLAGS)

vault-encrypt:
	ansible-vault encrypt group_vars/webservers/vault.yml $(VAULT_FLAGS)

vault-decrypt:
	ansible-vault decrypt group_vars/webservers/vault.yml $(VAULT_FLAGS)

vault-edit:
	ansible-vault edit group_vars/webservers/vault.yml $(VAULT_FLAGS)
