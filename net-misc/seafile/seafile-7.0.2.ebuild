# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# Created by Martin Kupec
# Updated by Vladimir Goshev

EAPI=7
PYTHON_COMPAT=( python2_7 )
inherit autotools python-single-r1 vala

DESCRIPTION="Cloud file syncing software"
HOMEPAGE="http://www.seafile.com"
SRC_URI="https://github.com/haiwen/${PN}/archive/v${PV}.tar.gz -> ${PN}-${PV}.tar.gz"

LICENSE="GPL-2+-with-openssl-exception"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

RDEPEND="${PYTHON_DEPS}
	net-libs/libsearpc[${PYTHON_USEDEP}]
	dev-libs/glib:2
	dev-libs/libevent:0
	dev-libs/jansson
	sys-libs/zlib:0
	net-misc/curl
	dev-libs/openssl:0
	dev-db/sqlite:3"
DEPEND="${RDEPEND}
	$(vala_depend)"

src_prepare() {
	default
	sed -i -e 's/valac /${VALAC} /' lib/Makefile.am || die
	eautoreconf
	vala_src_prepare
}

src_install() {
	default
	# Remove unnecessary .la files, as recommended by ltprune.eclass
	find "${ED}" -name '*.la' -delete || die

	#insinto /usr/share/seafile
	#doins -r ${S}/scripts
	#dodoc ${S}/doc/cli-readme.txt
	#doman ${S}/doc/*.1

	python_fix_shebang "${ED}"/usr/bin
}
