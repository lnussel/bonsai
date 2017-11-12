bonsai_install()
{
	mkdir -p "$dest"/etc/zypp/repos.d
	zypper --root "$dest" ar -f "$repo_oss_url" repo-oss
	rpm --root "$dest" --import /usr/lib/rpm/gnupg/keys/*
	if [ -n "$copy_fillup_passwd" ]; then
		cp /var/adm/fillup-templates/passwd.aaa_base "$dest"/etc/passwd
		cp /var/adm/fillup-templates/group.aaa_base "$dest"/etc/group
	fi
	zypper --root "$dest" install --no-recommends "$@"
}
