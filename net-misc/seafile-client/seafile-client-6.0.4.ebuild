# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# by Martin Kupec
# Updated by Vladimir Goshev

EAPI=6

inherit eutils

DESCRIPTION="Cloud file syncing software"
HOMEPAGE="http://www.seafile.com"
SRC_URI="https://github.com/haiwen/${PN}/archive/v${PV}.tar.gz -> ${PN}-${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
#IUSE=""


RDEPEND="
	>=net-misc/seafile-${PV}[client] 
	dev-libs/jansson
	dev-db/sqlite:3
	>=dev-qt/qtcore-5.5.1
	"

DEPEND="
	${RDEPEND}
	dev-util/cmake
	"

src_configure() {
	cmake -DCMAKE_INSTALL_PREFIX=/usr . || die "src_compile failed"
}

src_compile() {
	emake || die "emake failed"
}
