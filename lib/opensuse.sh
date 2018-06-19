bonsai_install()
{
	mkdir -p "$dest"/etc/zypp/repos.d
	: ${repos:=oss}
	for repo in "${repos[@]}"; do
		eval url=\"\$repo_${repo}_url\"
		zypper --root "$dest" ar -f "$url" repo-$repo
	done
	rpm --root "$dest" --import /usr/lib/rpm/gnupg/keys/*
	if [ -n "$copy_fillup_passwd" ]; then
		cp /var/adm/fillup-templates/passwd.aaa_base "$dest"/etc/passwd
		cp /var/adm/fillup-templates/group.aaa_base "$dest"/etc/group
	fi
	zypper --root "$dest" install --no-recommends "$@"
}
