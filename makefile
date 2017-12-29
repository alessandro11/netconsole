SCRIPT = setup-netconsole.sh
SETTINGS = netconsole
SYSTEMD_SERVICE = netconsole.service
PREFIX = /usr/local/bin
SYSTEMD_PREFIX = /etc/systemd/system

CWD = $(shell pwd)
USERID = $(shell id -u)

install: isroot
	install --mode 0755 --owner=root --group=root $(SCRIPT) $(PREFIX)/$(SCRIPT)
	install --mode 0644 --owner=root --group=root $(SETTINGS) /etc/default/$(SETTINGS)
	install --mode 0644 --owner=root --group=root $(SYSTEMD_SERVICE) $(SYSTEMD_PREFIX)/$(SYSTEMD_SERVICE)

isroot:
	@if [ $(USERID) -ne 0 ]; then\
		echo "Must be root!";\
		exit 1;\
	fi

uninstall: isroot
	rm -rf $(PREFIX)/$(SCRIPT)
	rm -rf /etc/default/$(SETTINGS)
	rm -rf $(SYSTEMD_PREFIX)/$(SYSTEMD_SERVICE)
