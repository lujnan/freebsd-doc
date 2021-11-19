# $FreeBSD$
#
# The user can override the default list of languages to build and install
# with the DOC_LANG variable.
#
.if defined(ENGLISH_ONLY) && !empty(ENGLISH_ONLY)
DOC_LANG=	en_US.ISO8859-1
.endif

.if defined(DOC_LANG) && !empty(DOC_LANG)
SUBDIR = 	${DOC_LANG}
.else
SUBDIR =	en_US.ISO8859-1
SUBDIR+=	zh_CN.UTF-8
SUBDIR+=	zh_TW.UTF-8
.endif

SUBDIR+=	share

DOC_PREFIX?=   ${.CURDIR}

.if exists(/usr/bin/svnlite)
SVN?=		/usr/bin/svnlite
.elif exists(/usr/bin/svn)
SVN?=		/usr/bin/svn
.else
SVN?=		/usr/local/bin/svn
.endif

update:
.if !exists(${SVN})
	@${ECHODIR} "--------------------------------------------------------------"
	@${ECHODIR} ">>> ${SVN} is required to update ${.CURDIR}"
	@${ECHODIR} "--------------------------------------------------------------"
	@${EXIT}
.else
	@${ECHODIR} "--------------------------------------------------------------"
	@${ECHODIR} ">>> Updating ${.CURDIR} from svn repository"
	@${ECHODIR} "--------------------------------------------------------------"
	cd ${.CURDIR}; ${SVN} update
.endif

.include "${DOC_PREFIX}/share/mk/doc.project.mk"
