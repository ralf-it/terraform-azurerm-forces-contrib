include ~/.make/forces.mk

#███████████████████████████████████████████████████████████████████████████████████████████████████
#████ Development
#███████████████████████████████████████████████████████████████████████████████████████████████████

PLAYBOOKS_DIR :=
PATH_MODULES := modules

delete-tag: /gtd ## [git/tag] delete tag locally and remotely

release-tag: /version-increment-patch /GACMTP ## [git/tag] push as new tag

release-tag-force: /version-increment-patch /GACMTPF ## [git/tag] force push as a tag

docs: /tf-docs ## [docs] generate documentation
