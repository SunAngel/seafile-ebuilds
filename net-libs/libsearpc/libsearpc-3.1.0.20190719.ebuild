# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# Created by Martin Kupec

EAPI=6

PYTHON_COMPAT=( python2_7 )
inherit autotools python-single-r1 vcs-snapshot


DESCRIPTION="RPC library for Seafile"
HOMEPAGE="https://github.com/haiwen/libsearpc/ http://seafile.com/"
RELEASE_COMMIT_HASH="2803f8d5cff4db632015c061e032d19f9c3a26eb"
SRC_URI="https://github.com/haiwen/${PN}/archive/${RELEASE_COMMIT_HASH}.tar.gz -> ${PN}-${RELEASE_COMMIT_HASH}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

DEPEND="${PYTHON_DEPS}
	>=dev-libs/glib-2.26.0
	>=dev-libs/jansson-2.2.1"
RDEPEND="${DEPEND}
	dev-python/simplejson[${PYTHON_USEDEP}]"

src_prepare() {
	default
	sed -i -e "s/(DESTDIR)//" ${PN}.pc.in || die
	eautoreconf
}

src_install() {
	default
	# Remove unnecessary .la files, as recommended by ltprune.eclass
	find "${ED}" -name '*.la' -delete || die
	python_fix_shebang "${ED}"usr/bin
}
