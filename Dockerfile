FROM centos:7
RUN yum install -y rpmdevtools mock sudo man make postgresql-devel openldap compat-openldap openldap-clients openldap-servers openldap-servers-sql openldap-devel gnupg which autoconf automake bison gcc-c++ libffi-devel libtool readline-devel ruby sqlite-devel zlib-devel glibc-headers glibc-devel openssl-devel openssh-clients git nfs-utils mkisofs epel-release centos-release-scl lockdev-devel libssh2-devel&& \
    rpm --import http://download.fedoraproject.org/pub/epel/RPM-GPG-KEY-EPEL-7 && \
    yum install -y python-pip llvm-toolset-7.0 llvm-toolset-7.0-cmake botan botan-doc botan-devel cyrus-sasl cyrus-sasl-devel python-django-bash-completion python2-django python2-django-rest-framework python2-ruamel-ordereddict python2-ruamel-yaml python2-typing llvm-toolset-7.0-clang llvm-toolset-7.0-git-clang-format llvm-toolset-7.0-git-clang-format llvm-toolset-7.0-clang-tools-extra boost-devel python-devel createrepo yum-utils

SHELL ["/bin/bash", "-lc"]
CMD ["/bin/bash", "-l"]

RUN touch /.yarnrc && \
    chmod 777 /.yarnrc && \
    echo -e "#!/bin/bash\nexport PATH=\"$PATH:/opt/rh/llvm-toolset-7/root/usr/bin/\"\nsource scl_source enable llvm-toolset-7.0 && /bin/bash" >/usr/local/bin/init.sh && \
    chmod 755 /usr/local/bin/init.sh

RUN ln -s /usr/local/bin/init.sh / # backwards compat

ENTRYPOINT ["init.sh"]


